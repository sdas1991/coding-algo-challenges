<template>
  <div class="flex flex-col h-full">
    <!-- Editor Header -->
    <div class="bg-gray-800 text-white px-4 py-2 rounded-t-lg flex items-center justify-between">
      <div class="flex items-center space-x-4">
        <select
          v-model="selectedLanguage"
          class="bg-gray-700 text-white px-3 py-1 rounded text-sm border border-gray-600 focus:outline-none focus:ring-2 focus:ring-primary-500"
        >
          <option value="java">Java</option>
          <option value="python">Python</option>
          <option value="javascript">JavaScript</option>
          <option value="cpp">C++</option>
        </select>
        <span class="text-sm text-gray-400">{{ fileName }}</span>
      </div>
      <div class="flex items-center space-x-2">
        <button
          @click="formatCode"
          class="px-3 py-1 bg-gray-700 hover:bg-gray-600 rounded text-sm transition-colors"
        >
          Format
        </button>
        <button
          @click="resetCode"
          class="px-3 py-1 bg-gray-700 hover:bg-gray-600 rounded text-sm transition-colors"
        >
          Reset
        </button>
      </div>
    </div>

    <!-- Code Textarea -->
    <div class="flex-1 relative">
      <textarea
        v-model="code"
        @input="handleInput"
        class="w-full h-full p-4 font-mono text-sm bg-gray-900 text-gray-100 resize-none focus:outline-none"
        :placeholder="placeholder"
        spellcheck="false"
      ></textarea>

      <!-- Line Numbers (optional enhancement) -->
      <div class="absolute left-0 top-0 bottom-0 w-12 bg-gray-800 text-gray-500 text-right pr-2 pt-4 font-mono text-sm select-none pointer-events-none">
        <div v-for="n in lineCount" :key="n" class="leading-6">{{ n }}</div>
      </div>
      <style scoped>
        textarea {
          padding-left: 3.5rem;
        }
      </style>
    </div>

    <!-- Editor Footer -->
    <div class="bg-gray-800 text-white px-4 py-2 rounded-b-lg flex items-center justify-between text-sm">
      <div class="text-gray-400">
        Lines: {{ lineCount }} | Length: {{ code.length }} characters
      </div>
      <div class="text-gray-400">
        Tab size: 4 spaces
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, watch } from 'vue'

const props = defineProps({
  modelValue: {
    type: String,
    default: ''
  },
  language: {
    type: String,
    default: 'java'
  },
  placeholder: {
    type: String,
    default: 'Write your code here...'
  }
})

const emit = defineEmits(['update:modelValue', 'language-change'])

const code = ref(props.modelValue)
const selectedLanguage = ref(props.language)

const lineCount = computed(() => {
  return code.value.split('\n').length
})

const fileName = computed(() => {
  const extensions = {
    java: 'Solution.java',
    python: 'solution.py',
    javascript: 'solution.js',
    cpp: 'solution.cpp'
  }
  return extensions[selectedLanguage.value] || 'solution.txt'
})

watch(() => props.modelValue, (newValue) => {
  code.value = newValue
})

watch(selectedLanguage, (newLang) => {
  emit('language-change', newLang)
})

function handleInput() {
  emit('update:modelValue', code.value)
}

function formatCode() {
  // Basic formatting - add proper indentation
  try {
    const lines = code.value.split('\n')
    let indentLevel = 0
    const formattedLines = lines.map(line => {
      const trimmed = line.trim()

      // Decrease indent for closing braces
      if (trimmed.startsWith('}') || trimmed.startsWith(']') || trimmed.startsWith(')')) {
        indentLevel = Math.max(0, indentLevel - 1)
      }

      const formattedLine = '    '.repeat(indentLevel) + trimmed

      // Increase indent for opening braces
      if (trimmed.endsWith('{') || trimmed.endsWith('[') || trimmed.endsWith('(')) {
        indentLevel++
      }

      return formattedLine
    })

    code.value = formattedLines.join('\n')
    emit('update:modelValue', code.value)
  } catch (error) {
    console.error('Format error:', error)
  }
}

function resetCode() {
  code.value = ''
  emit('update:modelValue', code.value)
}

// Handle tab key for indentation
function handleKeyDown(event) {
  if (event.key === 'Tab') {
    event.preventDefault()
    const start = event.target.selectionStart
    const end = event.target.selectionEnd
    code.value = code.value.substring(0, start) + '    ' + code.value.substring(end)
    emit('update:modelValue', code.value)

    // Move cursor after inserted spaces
    setTimeout(() => {
      event.target.selectionStart = event.target.selectionEnd = start + 4
    }, 0)
  }
}
</script>

<style scoped>
textarea::-webkit-scrollbar {
  width: 8px;
  height: 8px;
}

textarea::-webkit-scrollbar-track {
  background: #1f2937;
}

textarea::-webkit-scrollbar-thumb {
  background: #4b5563;
  border-radius: 4px;
}

textarea::-webkit-scrollbar-thumb:hover {
  background: #6b7280;
}
</style>
