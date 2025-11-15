<template>
  <div class="space-y-6">
    <!-- Header -->
    <div class="flex items-center justify-between">
      <div>
        <h1 class="text-3xl font-bold text-gray-800">MCQ Quiz</h1>
        <p class="text-gray-600 mt-1">Test your knowledge across multiple topics</p>
      </div>
      <router-link to="/" class="btn-secondary">← Back to Dashboard</router-link>
    </div>

    <!-- Quiz Stats -->
    <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
      <div class="card bg-blue-50 border-2 border-blue-200">
        <div class="text-center">
          <p class="text-sm text-gray-600">Questions Answered</p>
          <p class="text-3xl font-bold text-blue-700">{{ answeredCount }} / {{ totalQuestions }}</p>
        </div>
      </div>

      <div class="card bg-green-50 border-2 border-green-200">
        <div class="text-center">
          <p class="text-sm text-gray-600">Correct</p>
          <p class="text-3xl font-bold text-green-700">{{ correctCount }}</p>
        </div>
      </div>

      <div class="card bg-red-50 border-2 border-red-200">
        <div class="text-center">
          <p class="text-sm text-gray-600">Incorrect</p>
          <p class="text-3xl font-bold text-red-700">{{ incorrectCount }}</p>
        </div>
      </div>

      <div class="card bg-yellow-50 border-2 border-yellow-200">
        <div class="text-center">
          <p class="text-sm text-gray-600">Accuracy</p>
          <p class="text-3xl font-bold text-yellow-700">{{ accuracy }}%</p>
        </div>
      </div>
    </div>

    <!-- Category Filter -->
    <div class="card">
      <div class="flex items-center justify-between">
        <div>
          <h3 class="text-lg font-bold text-gray-800">Category</h3>
          <p class="text-sm text-gray-600">Filter questions by topic</p>
        </div>
        <select
          v-model="selectedCategory"
          @change="fetchQuestions"
          class="input-field max-w-xs"
        >
          <option value="">All Categories</option>
          <option value="algorithms">Algorithms</option>
          <option value="data-structures">Data Structures</option>
          <option value="system-design">System Design</option>
          <option value="databases">Databases</option>
          <option value="java">Java</option>
          <option value="javascript">JavaScript</option>
          <option value="python">Python</option>
          <option value="oop">OOP</option>
        </select>
      </div>
    </div>

    <!-- Question Card -->
    <div v-if="currentQuestion" class="card">
      <div class="flex items-center justify-between mb-6">
        <div>
          <h2 class="text-2xl font-bold text-gray-800">
            Question {{ currentQuestionIndex + 1 }} of {{ questions.length }}
          </h2>
          <div class="flex items-center space-x-2 mt-2">
            <span class="badge bg-blue-100 text-blue-800 text-xs">
              {{ currentQuestion.category }}
            </span>
            <span class="badge text-xs" :class="difficultyClass">
              {{ currentQuestion.difficulty }}
            </span>
          </div>
        </div>

        <!-- Navigation Buttons -->
        <div class="flex gap-2">
          <button
            @click="previousQuestion"
            :disabled="currentQuestionIndex === 0"
            class="px-4 py-2 bg-gray-200 text-gray-800 rounded-lg hover:bg-gray-300 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
          >
            ← Previous
          </button>
          <button
            @click="nextQuestion"
            :disabled="currentQuestionIndex === questions.length - 1"
            class="px-4 py-2 bg-gray-200 text-gray-800 rounded-lg hover:bg-gray-300 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
          >
            Next →
          </button>
        </div>
      </div>

      <!-- Question Text -->
      <div class="mb-6">
        <p class="text-lg text-gray-800 leading-relaxed whitespace-pre-wrap">
          {{ currentQuestion.question }}
        </p>
      </div>

      <!-- Code Block (if present) -->
      <div v-if="currentQuestion.codeSnippet" class="mb-6 bg-gray-900 text-gray-100 p-4 rounded-lg font-mono text-sm overflow-x-auto">
        <pre>{{ currentQuestion.codeSnippet }}</pre>
      </div>

      <!-- Answer Options -->
      <div class="space-y-3 mb-6">
        <div
          v-for="option in currentQuestion.options"
          :key="option.id"
          @click="!isAnswered ? selectAnswer(option.id) : null"
          class="p-4 border-2 rounded-lg cursor-pointer transition-all"
          :class="getOptionClass(option.id)"
        >
          <div class="flex items-center space-x-3">
            <div
              class="w-6 h-6 rounded-full border-2 flex items-center justify-center transition-all"
              :class="selectedAnswer === option.id
                ? 'border-primary-600 bg-primary-600'
                : 'border-gray-300'"
            >
              <div
                v-if="selectedAnswer === option.id"
                class="w-3 h-3 bg-white rounded-full"
              ></div>
            </div>
            <span class="text-gray-800 flex-1">{{ option.text }}</span>

            <!-- Correct/Incorrect Indicator -->
            <div v-if="isAnswered">
              <span v-if="option.id === currentQuestion.correctAnswer" class="text-green-600 text-xl">✓</span>
              <span v-else-if="option.id === selectedAnswer && !isCorrect" class="text-red-600 text-xl">✗</span>
            </div>
          </div>
        </div>
      </div>

      <!-- Submit Button -->
      <button
        v-if="!isAnswered"
        @click="submitAnswer"
        :disabled="!selectedAnswer || submitting"
        class="btn-primary w-full"
      >
        {{ submitting ? 'Submitting...' : 'Submit Answer' }}
      </button>

      <!-- Explanation (shown after answering) -->
      <div v-if="isAnswered" class="space-y-4">
        <!-- Result Banner -->
        <div
          class="p-4 rounded-lg border-2"
          :class="isCorrect
            ? 'bg-green-50 border-green-200'
            : 'bg-red-50 border-red-200'"
        >
          <div class="flex items-center justify-between">
            <div>
              <p class="font-bold" :class="isCorrect ? 'text-green-800' : 'text-red-800'">
                {{ isCorrect ? '✓ Correct!' : '✗ Incorrect' }}
              </p>
              <p class="text-sm" :class="isCorrect ? 'text-green-700' : 'text-red-700'">
                {{ isCorrect ? `+${currentQuestion.wpReward || 10} WP | +${currentQuestion.xpReward || 5} XP` : 'Better luck next time!' }}
              </p>
            </div>
            <div class="text-3xl">
              {{ isCorrect ? '🎉' : '😔' }}
            </div>
          </div>
        </div>

        <!-- Explanation -->
        <div class="bg-blue-50 border border-blue-200 rounded-lg p-4">
          <h4 class="font-bold text-blue-800 mb-2">Explanation:</h4>
          <p class="text-blue-900 leading-relaxed">{{ currentQuestion.explanation }}</p>
        </div>

        <!-- Next Question Button -->
        <button
          v-if="currentQuestionIndex < questions.length - 1"
          @click="nextQuestionAndReset"
          class="btn-primary w-full"
        >
          Next Question →
        </button>
        <button
          v-else
          @click="resetQuiz"
          class="btn-success w-full"
        >
          🔄 Start New Quiz
        </button>
      </div>
    </div>

    <!-- No Questions -->
    <div v-else-if="!loading && questions.length === 0" class="card text-center py-12">
      <div class="text-6xl mb-4">❓</div>
      <h3 class="text-2xl font-bold text-gray-800 mb-2">No Questions Available</h3>
      <p class="text-gray-600">Try selecting a different category</p>
    </div>

    <!-- Loading State -->
    <div v-if="loading" class="text-center py-12">
      <div class="inline-block w-12 h-12 border-4 border-primary-600 border-t-transparent rounded-full animate-spin"></div>
      <p class="mt-4 text-gray-600">Loading questions...</p>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useUserStore } from '../stores/userStore'
import { api } from '../api/client'

const userStore = useUserStore()

const loading = ref(true)
const questions = ref([])
const currentQuestionIndex = ref(0)
const selectedAnswer = ref(null)
const isAnswered = ref(false)
const isCorrect = ref(false)
const submitting = ref(false)
const selectedCategory = ref('')

const answeredCount = ref(0)
const correctCount = ref(0)
const incorrectCount = ref(0)

const currentQuestion = computed(() => questions.value[currentQuestionIndex.value])

const totalQuestions = computed(() => questions.value.length)

const accuracy = computed(() => {
  if (answeredCount.value === 0) return 0
  return Math.round((correctCount.value / answeredCount.value) * 100)
})

const difficultyClass = computed(() => {
  const difficulty = currentQuestion.value?.difficulty?.toLowerCase()
  if (difficulty === 'easy') return 'bg-green-100 text-green-800'
  if (difficulty === 'medium') return 'bg-yellow-100 text-yellow-800'
  if (difficulty === 'hard') return 'bg-red-100 text-red-800'
  return 'bg-gray-100 text-gray-800'
})

function getOptionClass(optionId) {
  if (!isAnswered.value) {
    return selectedAnswer.value === optionId
      ? 'border-primary-600 bg-primary-50'
      : 'border-gray-200 hover:border-primary-300 hover:bg-gray-50'
  }

  // After answering
  if (optionId === currentQuestion.value.correctAnswer) {
    return 'border-green-500 bg-green-50'
  }

  if (optionId === selectedAnswer.value && !isCorrect.value) {
    return 'border-red-500 bg-red-50'
  }

  return 'border-gray-200 bg-gray-50 opacity-60'
}

function selectAnswer(optionId) {
  selectedAnswer.value = optionId
}

async function submitAnswer() {
  if (!selectedAnswer.value) return

  submitting.value = true

  try {
    const response = await api.submitMcq(currentQuestion.value.id, selectedAnswer.value)

    isCorrect.value = selectedAnswer.value === currentQuestion.value.correctAnswer
    isAnswered.value = true
    answeredCount.value++

    if (isCorrect.value) {
      correctCount.value++
      userStore.earnWP(currentQuestion.value.wpReward || 10)
      userStore.addXP(currentQuestion.value.xpReward || 5)
    } else {
      incorrectCount.value++
    }
  } catch (err) {
    console.error('Failed to submit answer:', err)

    // Mock response
    isCorrect.value = selectedAnswer.value === currentQuestion.value.correctAnswer
    isAnswered.value = true
    answeredCount.value++

    if (isCorrect.value) {
      correctCount.value++
      userStore.earnWP(currentQuestion.value.wpReward || 10)
      userStore.addXP(currentQuestion.value.xpReward || 5)
    } else {
      incorrectCount.value++
    }
  } finally {
    submitting.value = false
  }
}

function previousQuestion() {
  if (currentQuestionIndex.value > 0) {
    currentQuestionIndex.value--
    resetCurrentQuestion()
  }
}

function nextQuestion() {
  if (currentQuestionIndex.value < questions.value.length - 1) {
    currentQuestionIndex.value++
    resetCurrentQuestion()
  }
}

function nextQuestionAndReset() {
  nextQuestion()
}

function resetCurrentQuestion() {
  selectedAnswer.value = null
  isAnswered.value = false
  isCorrect.value = false
}

function resetQuiz() {
  currentQuestionIndex.value = 0
  answeredCount.value = 0
  correctCount.value = 0
  incorrectCount.value = 0
  resetCurrentQuestion()
  fetchQuestions()
}

async function fetchQuestions() {
  loading.value = true

  try {
    const response = await api.getMcqQuestions()
    questions.value = response.data || []
    resetCurrentQuestion()
  } catch (err) {
    console.error('Failed to fetch questions:', err)

    // Mock data
    questions.value = [
      {
        id: 1,
        category: 'algorithms',
        difficulty: 'Easy',
        question: 'What is the time complexity of accessing an element in an array by index?',
        options: [
          { id: 1, text: 'O(1)' },
          { id: 2, text: 'O(n)' },
          { id: 3, text: 'O(log n)' },
          { id: 4, text: 'O(n²)' }
        ],
        correctAnswer: 1,
        explanation: 'Accessing an element in an array by index is a constant time operation O(1) because arrays store elements in contiguous memory locations, allowing direct access via index calculation.',
        wpReward: 10,
        xpReward: 5
      },
      {
        id: 2,
        category: 'data-structures',
        difficulty: 'Medium',
        question: 'Which data structure uses LIFO (Last In First Out) principle?',
        options: [
          { id: 1, text: 'Queue' },
          { id: 2, text: 'Stack' },
          { id: 3, text: 'Linked List' },
          { id: 4, text: 'Tree' }
        ],
        correctAnswer: 2,
        explanation: 'A Stack follows the LIFO (Last In First Out) principle, where the last element added is the first one to be removed. Think of it like a stack of plates - you add and remove from the top.',
        wpReward: 10,
        xpReward: 5
      },
      {
        id: 3,
        category: 'java',
        difficulty: 'Medium',
        question: 'What will be the output of the following code?',
        codeSnippet: `String s1 = "Hello";
String s2 = "Hello";
System.out.println(s1 == s2);`,
        options: [
          { id: 1, text: 'true' },
          { id: 2, text: 'false' },
          { id: 3, text: 'Compilation error' },
          { id: 4, text: 'Runtime error' }
        ],
        correctAnswer: 1,
        explanation: 'The output is true because string literals are stored in the String Pool. Both s1 and s2 reference the same object in the pool, so == comparison returns true. However, for new String() objects, == would return false, and .equals() should be used for content comparison.',
        wpReward: 15,
        xpReward: 8
      }
    ]

    resetCurrentQuestion()
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  fetchQuestions()
})
</script>
