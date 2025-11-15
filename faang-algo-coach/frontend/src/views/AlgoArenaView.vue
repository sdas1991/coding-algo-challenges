<template>
  <div class="space-y-4">
    <!-- Breadcrumb -->
    <div class="flex items-center space-x-2 text-sm text-gray-600">
      <router-link to="/" class="hover:text-primary-600">Dashboard</router-link>
      <span>/</span>
      <span class="font-medium text-gray-800">{{ arenaDisplayName }}</span>
    </div>

    <!-- Problem Selector -->
    <div class="card">
      <div class="flex items-center justify-between">
        <div>
          <h2 class="text-xl font-bold text-gray-800">{{ arenaDisplayName }} Arena</h2>
          <p class="text-sm text-gray-600 mt-1">Select a problem to solve</p>
        </div>
        <select
          v-model="selectedProblemId"
          @change="loadProblem"
          class="input-field max-w-md"
        >
          <option value="">Choose a problem...</option>
          <option
            v-for="problem in problems"
            :key="problem.id"
            :value="problem.id"
          >
            {{ problem.title }} ({{ problem.difficulty }})
          </option>
        </select>
      </div>
    </div>

    <!-- Split View: Problem & Editor -->
    <div v-if="currentProblem" class="grid grid-cols-1 lg:grid-cols-2 gap-6" style="height: calc(100vh - 280px);">
      <!-- Left: Problem View -->
      <div class="h-full">
        <ProblemView :problem="currentProblem" />
      </div>

      <!-- Right: Editor & Controls -->
      <div class="flex flex-col space-y-4 h-full">
        <!-- Code Editor -->
        <div class="flex-1 min-h-0">
          <CodeEditor
            v-model="code"
            :language="selectedLanguage"
            @language-change="handleLanguageChange"
          />
        </div>

        <!-- Action Buttons -->
        <div class="flex items-center justify-between gap-4">
          <button
            @click="runCode"
            :disabled="submitting || !code.trim()"
            class="btn-secondary flex-1"
          >
            <span class="flex items-center justify-center space-x-2">
              <span>▶️</span>
              <span>Run Code</span>
            </span>
          </button>

          <button
            @click="submitSolution"
            :disabled="submitting || !code.trim()"
            class="btn-success flex-1"
          >
            <span class="flex items-center justify-center space-x-2">
              <span>✓</span>
              <span>{{ submitting ? 'Submitting...' : 'Submit Solution' }}</span>
            </span>
          </button>

          <button
            @click="showHints = !showHints"
            class="btn-primary"
          >
            <span class="flex items-center space-x-1">
              <span>💡</span>
              <span>Hints</span>
            </span>
          </button>
        </div>

        <!-- Test Results -->
        <div v-if="testResults" class="card">
          <h3 class="text-lg font-bold mb-3" :class="testResults.passed ? 'text-green-700' : 'text-red-700'">
            {{ testResults.passed ? '✓ All Tests Passed!' : '✗ Some Tests Failed' }}
          </h3>

          <div class="space-y-2">
            <div
              v-for="(test, index) in testResults.tests"
              :key="index"
              class="p-3 rounded-lg border"
              :class="test.passed ? 'bg-green-50 border-green-200' : 'bg-red-50 border-red-200'"
            >
              <div class="flex items-center justify-between mb-2">
                <span class="font-medium" :class="test.passed ? 'text-green-800' : 'text-red-800'">
                  Test Case {{ index + 1 }}
                </span>
                <span :class="test.passed ? 'text-green-600' : 'text-red-600'">
                  {{ test.passed ? '✓ Passed' : '✗ Failed' }}
                </span>
              </div>

              <div v-if="!test.passed" class="text-sm space-y-1">
                <div><span class="text-gray-600">Input:</span> {{ test.input }}</div>
                <div><span class="text-gray-600">Expected:</span> {{ test.expected }}</div>
                <div><span class="text-gray-600">Got:</span> {{ test.actual }}</div>
              </div>
            </div>
          </div>

          <div v-if="testResults.passed" class="mt-4 p-4 bg-gradient-to-r from-green-50 to-emerald-50 border border-green-200 rounded-lg">
            <div class="flex items-center justify-between">
              <div>
                <p class="font-bold text-green-800">Congratulations!</p>
                <p class="text-sm text-green-700">
                  +{{ currentProblem.wpReward }} WP | +{{ currentProblem.xpReward }} XP
                </p>
              </div>
              <div class="text-3xl">🎉</div>
            </div>
          </div>
        </div>

        <!-- Hints Panel (Collapsible) -->
        <div v-if="showHints" class="max-h-96 overflow-y-auto">
          <HintPanel
            :problem-id="currentProblem.id"
            :hints="hints"
            :teach-me-cost="100"
            @unlock-hint="unlockHint"
            @teach-me="requestTeachMe"
          />
        </div>

        <!-- Teach Me Modal -->
        <div v-if="showSolution" class="card bg-purple-50 border-2 border-purple-300">
          <div class="flex items-center justify-between mb-4">
            <h3 class="text-xl font-bold text-purple-800">Complete Solution</h3>
            <button @click="showSolution = false" class="text-purple-600 hover:text-purple-800">✕</button>
          </div>

          <div class="space-y-4">
            <div>
              <h4 class="font-bold text-gray-800 mb-2">Approach:</h4>
              <p class="text-gray-700 leading-relaxed">{{ solution.approach }}</p>
            </div>

            <div>
              <h4 class="font-bold text-gray-800 mb-2">Solution Code:</h4>
              <div class="bg-gray-900 text-gray-100 p-4 rounded-lg font-mono text-sm overflow-x-auto">
                <pre>{{ solution.code }}</pre>
              </div>
            </div>

            <div class="grid grid-cols-2 gap-4">
              <div class="p-3 bg-white rounded-lg border border-gray-200">
                <p class="text-sm text-gray-600">Time Complexity</p>
                <p class="font-bold text-gray-800">{{ solution.timeComplexity }}</p>
              </div>
              <div class="p-3 bg-white rounded-lg border border-gray-200">
                <p class="text-sm text-gray-600">Space Complexity</p>
                <p class="font-bold text-gray-800">{{ solution.spaceComplexity }}</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- No Problem Selected -->
    <div v-else-if="!loading" class="card text-center py-12">
      <div class="text-6xl mb-4">🎯</div>
      <h3 class="text-2xl font-bold text-gray-800 mb-2">Select a Problem to Begin</h3>
      <p class="text-gray-600">Choose a problem from the dropdown above to start coding!</p>
    </div>

    <!-- Loading State -->
    <div v-if="loading" class="text-center py-12">
      <div class="inline-block w-12 h-12 border-4 border-primary-600 border-t-transparent rounded-full animate-spin"></div>
      <p class="mt-4 text-gray-600">Loading problems...</p>
    </div>

    <!-- Error Message -->
    <div v-if="error" class="card bg-red-50 border-2 border-red-200">
      <p class="text-red-800 text-center">{{ error }}</p>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { useUserStore } from '../stores/userStore'
import ProblemView from '../components/ProblemView.vue'
import CodeEditor from '../components/CodeEditor.vue'
import HintPanel from '../components/HintPanel.vue'
import { api } from '../api/client'

const route = useRoute()
const userStore = useUserStore()

const arenaName = computed(() => route.params.arenaName)
const arenaDisplayName = computed(() => {
  return arenaName.value
    .split('-')
    .map(word => word.charAt(0).toUpperCase() + word.slice(1))
    .join(' ')
})

const loading = ref(true)
const error = ref('')
const problems = ref([])
const selectedProblemId = ref('')
const currentProblem = ref(null)
const code = ref('')
const selectedLanguage = ref('java')
const submitting = ref(false)
const testResults = ref(null)
const showHints = ref(false)
const hints = ref([])
const showSolution = ref(false)
const solution = ref(null)

async function fetchProblems() {
  loading.value = true
  error.value = ''

  try {
    const response = await api.getArenaProblems(arenaName.value)
    problems.value = response.data || []

    // Auto-select first problem if available
    if (problems.value.length > 0) {
      selectedProblemId.value = problems.value[0].id
      await loadProblem()
    }
  } catch (err) {
    console.error('Failed to fetch problems:', err)
    error.value = 'Failed to load problems. Please try again.'

    // Mock data for development
    problems.value = [
      {
        id: 1,
        title: 'Two Sum',
        difficulty: 'Easy',
        description: 'Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.',
        tags: ['Array', 'Hash Table'],
        wpReward: 50,
        xpReward: 25,
        hintsCount: 3,
        examples: [
          {
            input: 'nums = [2,7,11,15], target = 9',
            output: '[0,1]',
            explanation: 'Because nums[0] + nums[1] == 9, we return [0, 1].'
          }
        ],
        constraints: [
          '2 <= nums.length <= 10^4',
          '-10^9 <= nums[i] <= 10^9',
          'Only one valid answer exists.'
        ],
        companies: ['Google', 'Amazon', 'Microsoft']
      }
    ]

    selectedProblemId.value = problems.value[0].id
    await loadProblem()
  } finally {
    loading.value = false
  }
}

async function loadProblem() {
  if (!selectedProblemId.value) return

  try {
    const response = await api.getProblem(selectedProblemId.value)
    currentProblem.value = response.data
    code.value = ''
    testResults.value = null
    showHints.value = false
    showSolution.value = false

    // Load hints
    hints.value = [
      { unlocked: false, cost: 10, content: '', codeSnippet: '' },
      { unlocked: false, cost: 20, content: '', codeSnippet: '' },
      { unlocked: false, cost: 30, content: '', codeSnippet: '' }
    ]
  } catch (err) {
    console.error('Failed to load problem:', err)
    // Use selected problem from list
    currentProblem.value = problems.value.find(p => p.id === selectedProblemId.value)

    hints.value = [
      {
        unlocked: false,
        cost: 10,
        content: 'Think about using a hash map to store values you\'ve seen.',
        codeSnippet: ''
      },
      {
        unlocked: false,
        cost: 20,
        content: 'For each number, check if (target - number) exists in your hash map.',
        codeSnippet: 'Map<Integer, Integer> map = new HashMap<>();'
      },
      {
        unlocked: false,
        cost: 30,
        content: 'Store the index of each number as you iterate through the array.',
        codeSnippet: 'map.put(nums[i], i);'
      }
    ]
  }
}

function handleLanguageChange(newLang) {
  selectedLanguage.value = newLang
}

async function runCode() {
  testResults.value = null
  submitting.value = true

  try {
    // Simulate test run (replace with actual API call)
    await new Promise(resolve => setTimeout(resolve, 1000))

    testResults.value = {
      passed: false,
      tests: [
        { passed: true, input: '[2,7,11,15], 9', expected: '[0,1]', actual: '[0,1]' },
        { passed: false, input: '[3,2,4], 6', expected: '[1,2]', actual: '[0,2]' }
      ]
    }
  } catch (err) {
    error.value = 'Failed to run code. Please try again.'
  } finally {
    submitting.value = false
  }
}

async function submitSolution() {
  testResults.value = null
  submitting.value = true

  try {
    const response = await api.submitSolution(currentProblem.value.id, {
      code: code.value,
      language: selectedLanguage.value
    })

    testResults.value = response.data

    if (response.data.passed) {
      userStore.earnWP(currentProblem.value.wpReward)
      userStore.addXP(currentProblem.value.xpReward)
      userStore.incrementCompletedProblems()
    }
  } catch (err) {
    console.error('Failed to submit solution:', err)

    // Mock response
    testResults.value = {
      passed: true,
      tests: [
        { passed: true, input: '[2,7,11,15], 9', expected: '[0,1]', actual: '[0,1]' },
        { passed: true, input: '[3,2,4], 6', expected: '[1,2]', actual: '[1,2]' }
      ]
    }

    userStore.earnWP(currentProblem.value.wpReward)
    userStore.addXP(currentProblem.value.xpReward)
    userStore.incrementCompletedProblems()
  } finally {
    submitting.value = false
  }
}

async function unlockHint(index) {
  const hint = hints.value[index]

  if (userStore.spendWP(hint.cost)) {
    try {
      const response = await api.getHint(currentProblem.value.id, index + 1)
      hints.value[index] = {
        ...hint,
        unlocked: true,
        content: response.data.content,
        codeSnippet: response.data.codeSnippet || ''
      }
    } catch (err) {
      console.error('Failed to unlock hint:', err)
      // Use mock hint
      hints.value[index].unlocked = true
    }
  }
}

async function requestTeachMe() {
  const cost = 100

  if (!userStore.spendWP(cost)) {
    error.value = 'Not enough Wisdom Points!'
    setTimeout(() => error.value = '', 3000)
    return
  }

  try {
    const response = await api.teachMe(currentProblem.value.id)
    solution.value = response.data
    showSolution.value = true
  } catch (err) {
    console.error('Failed to get solution:', err)

    // Mock solution
    solution.value = {
      approach: 'Use a hash map to store the complement of each number. For each number, check if its complement exists in the map.',
      code: `public int[] twoSum(int[] nums, int target) {
    Map<Integer, Integer> map = new HashMap<>();
    for (int i = 0; i < nums.length; i++) {
        int complement = target - nums[i];
        if (map.containsKey(complement)) {
            return new int[] { map.get(complement), i };
        }
        map.put(nums[i], i);
    }
    throw new IllegalArgumentException("No solution");
}`,
      timeComplexity: 'O(n)',
      spaceComplexity: 'O(n)'
    }
    showSolution.value = true
  }
}

onMounted(() => {
  fetchProblems()
})
</script>
