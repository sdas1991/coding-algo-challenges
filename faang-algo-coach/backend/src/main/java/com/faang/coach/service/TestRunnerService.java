package com.faang.coach.service;

import com.faang.coach.domain.TestCase;
import com.faang.coach.dto.TestCaseResult;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.tools.*;
import java.io.*;
import java.lang.reflect.Method;
import java.net.URI;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.*;
import java.util.concurrent.*;

@Service
@RequiredArgsConstructor
@Slf4j
public class TestRunnerService {

    private static final int DEFAULT_TIMEOUT_MS = 5000;
    private static final int MAX_OUTPUT_LENGTH = 10000;

    public List<TestCaseResult> runJavaTests(String code, List<TestCase> testCases, int timeoutMs) {
        List<TestCaseResult> results = new ArrayList<>();

        try {
            // Extract class name from code
            String className = extractClassName(code);
            if (className == null) {
                throw new IllegalArgumentException("Could not find public class in submitted code");
            }

            // Compile the code
            Class<?> compiledClass = compileJavaCode(className, code);

            // Run each test case
            for (int i = 0; i < testCases.size(); i++) {
                TestCase testCase = testCases.get(i);
                TestCaseResult result = executeTestCase(compiledClass, testCase, i + 1, timeoutMs);
                results.add(result);
            }

        } catch (Exception e) {
            log.error("Error running Java tests", e);
            TestCaseResult errorResult = TestCaseResult.builder()
                    .testCaseNumber(1)
                    .passed(false)
                    .errorMessage("Compilation/Execution Error: " + e.getMessage())
                    .build();
            results.add(errorResult);
        }

        return results;
    }

    private String extractClassName(String code) {
        // Simple regex to extract class name (production would use proper parser)
        String[] lines = code.split("\n");
        for (String line : lines) {
            if (line.trim().startsWith("public class ")) {
                String[] parts = line.trim().split("\\s+");
                for (int i = 0; i < parts.length - 1; i++) {
                    if (parts[i].equals("class")) {
                        return parts[i + 1].replace("{", "").trim();
                    }
                }
            }
        }
        return null;
    }

    private Class<?> compileJavaCode(String className, String code) throws Exception {
        // Get Java compiler
        JavaCompiler compiler = ToolProvider.getSystemJavaCompiler();
        if (compiler == null) {
            throw new IllegalStateException("Java compiler not available. Ensure you're running with JDK, not JRE.");
        }

        // Prepare in-memory compilation
        InMemoryJavaFileManager fileManager = new InMemoryJavaFileManager(
                compiler.getStandardFileManager(null, null, null));

        // Create source file object
        JavaFileObject sourceFile = new InMemoryJavaFileObject(className, code);

        // Compile
        JavaCompiler.CompilationTask task = compiler.getTask(
                null,
                fileManager,
                null,
                null,
                null,
                Collections.singletonList(sourceFile)
        );

        boolean success = task.call();
        if (!success) {
            throw new IllegalArgumentException("Compilation failed");
        }

        // Load compiled class
        InMemoryClassLoader classLoader = new InMemoryClassLoader(fileManager.getClassBytes());
        return classLoader.loadClass(className);
    }

    private TestCaseResult executeTestCase(Class<?> clazz, TestCase testCase, int testNumber, int timeoutMs) {
        long startTime = System.currentTimeMillis();

        try {
            // Parse input and expected output
            String[] inputLines = testCase.getInputData().split("\n");
            String expectedOutput = testCase.getExpectedOutput().trim();

            // Find and invoke the solution method
            Object instance = clazz.getDeclaredConstructor().newInstance();
            Method method = findSolutionMethod(clazz);

            if (method == null) {
                return TestCaseResult.builder()
                        .testCaseNumber(testNumber)
                        .passed(false)
                        .errorMessage("No solution method found")
                        .build();
            }

            // Execute with timeout
            ExecutorService executor = Executors.newSingleThreadExecutor();
            Future<String> future = executor.submit(() -> {
                try {
                    Object result = method.invoke(instance, parseMethodArgs(method, inputLines));
                    return result != null ? result.toString() : "null";
                } catch (Exception e) {
                    throw new RuntimeException("Execution error: " + e.getCause().getMessage());
                }
            });

            String actualOutput;
            try {
                actualOutput = future.get(timeoutMs, TimeUnit.MILLISECONDS);
            } catch (TimeoutException e) {
                future.cancel(true);
                executor.shutdownNow();
                return TestCaseResult.builder()
                        .testCaseNumber(testNumber)
                        .passed(false)
                        .errorMessage("Time Limit Exceeded")
                        .executionTimeMs((long) timeoutMs)
                        .build();
            } finally {
                executor.shutdown();
            }

            long executionTime = System.currentTimeMillis() - startTime;
            boolean passed = actualOutput.trim().equals(expectedOutput);

            return TestCaseResult.builder()
                    .testCaseNumber(testNumber)
                    .passed(passed)
                    .input(testCase.getInputData())
                    .expectedOutput(expectedOutput)
                    .actualOutput(actualOutput.trim())
                    .executionTimeMs(executionTime)
                    .build();

        } catch (Exception e) {
            long executionTime = System.currentTimeMillis() - startTime;
            return TestCaseResult.builder()
                    .testCaseNumber(testNumber)
                    .passed(false)
                    .errorMessage(e.getMessage())
                    .executionTimeMs(executionTime)
                    .build();
        }
    }

    private Method findSolutionMethod(Class<?> clazz) {
        // Look for common method names: solve, solution, main logic methods
        Method[] methods = clazz.getDeclaredMethods();
        for (Method method : methods) {
            String name = method.getName();
            if (name.equals("solve") || name.equals("solution") || name.equals("twoSum") ||
                name.equals("findMedian") || !name.equals("main")) {
                method.setAccessible(true);
                return method;
            }
        }
        return methods.length > 0 ? methods[0] : null;
    }

    private Object[] parseMethodArgs(Method method, String[] inputLines) {
        Class<?>[] paramTypes = method.getParameterTypes();
        Object[] args = new Object[paramTypes.length];

        for (int i = 0; i < paramTypes.length && i < inputLines.length; i++) {
            args[i] = parseValue(paramTypes[i], inputLines[i].trim());
        }

        return args;
    }

    private Object parseValue(Class<?> type, String value) {
        if (type == int.class || type == Integer.class) {
            return Integer.parseInt(value);
        } else if (type == long.class || type == Long.class) {
            return Long.parseLong(value);
        } else if (type == double.class || type == Double.class) {
            return Double.parseDouble(value);
        } else if (type == String.class) {
            return value;
        } else if (type == int[].class) {
            String[] parts = value.replace("[", "").replace("]", "").split(",");
            return Arrays.stream(parts).map(String::trim).mapToInt(Integer::parseInt).toArray();
        }
        return value;
    }

    // Inner classes for in-memory compilation

    private static class InMemoryJavaFileObject extends SimpleJavaFileObject {
        private final String code;

        protected InMemoryJavaFileObject(String className, String code) {
            super(URI.create("string:///" + className.replace('.', '/') + Kind.SOURCE.extension), Kind.SOURCE);
            this.code = code;
        }

        @Override
        public CharSequence getCharContent(boolean ignoreEncodingErrors) {
            return code;
        }
    }

    private static class InMemoryJavaFileManager extends javax.tools.ForwardingJavaFileManager<JavaFileManager> {
        private final Map<String, ByteArrayOutputStream> classBytes = new HashMap<>();

        protected InMemoryJavaFileManager(JavaFileManager fileManager) {
            super(fileManager);
        }

        @Override
        public JavaFileObject getJavaFileForOutput(JavaFileManager.Location location, String className, JavaFileObject.Kind kind, FileObject sibling) {
            return new SimpleJavaFileObject(URI.create("string:///" + className.replace('.', '/') + kind.extension), kind) {
                @Override
                public OutputStream openOutputStream() {
                    ByteArrayOutputStream baos = new ByteArrayOutputStream();
                    classBytes.put(className, baos);
                    return baos;
                }
            };
        }

        public Map<String, byte[]> getClassBytes() {
            Map<String, byte[]> result = new HashMap<>();
            classBytes.forEach((name, baos) -> result.put(name, baos.toByteArray()));
            return result;
        }
    }

    private static class InMemoryClassLoader extends ClassLoader {
        private final Map<String, byte[]> classBytes;

        public InMemoryClassLoader(Map<String, byte[]> classBytes) {
            this.classBytes = classBytes;
        }

        @Override
        protected Class<?> findClass(String name) throws ClassNotFoundException {
            byte[] bytes = classBytes.get(name);
            if (bytes == null) {
                throw new ClassNotFoundException(name);
            }
            return defineClass(name, bytes, 0, bytes.length);
        }
    }
}
