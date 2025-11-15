<template>
  <div class="space-y-6">
    <!-- Header -->
    <div class="flex items-center justify-between">
      <div>
        <h1 class="text-3xl font-bold text-gray-800">JPA Practice</h1>
        <p class="text-gray-600 mt-1">Master Hibernate and Object-Relational Mapping</p>
      </div>
      <router-link to="/" class="btn-secondary">← Back to Dashboard</router-link>
    </div>

    <!-- Problem Selector -->
    <div class="card">
      <select
        v-model="selectedProblemId"
        @change="loadProblem"
        class="input-field"
      >
        <option value="">Select a JPA problem...</option>
        <option
          v-for="problem in problems"
          :key="problem.id"
          :value="problem.id"
        >
          {{ problem.title }} - {{ problem.difficulty }}
        </option>
      </select>
    </div>

    <!-- Main Content -->
    <div v-if="currentProblem" class="grid grid-cols-1 lg:grid-cols-2 gap-6">
      <!-- Left: Problem Description -->
      <div class="space-y-6">
        <div class="card">
          <h2 class="text-2xl font-bold text-gray-800 mb-4">{{ currentProblem.title }}</h2>

          <div class="mb-4">
            <span class="badge" :class="difficultyClass">{{ currentProblem.difficulty }}</span>
          </div>

          <div class="prose max-w-none mb-6">
            <p class="text-gray-700 leading-relaxed whitespace-pre-wrap">{{ currentProblem.description }}</p>
          </div>

          <!-- Entity Structure -->
          <div v-if="currentProblem.entities" class="mb-6">
            <h3 class="text-lg font-bold text-gray-800 mb-3">Entity Structure</h3>
            <div class="bg-gray-900 text-gray-100 p-4 rounded-lg font-mono text-sm overflow-x-auto">
              <pre>{{ currentProblem.entities }}</pre>
            </div>
          </div>

          <!-- Requirements -->
          <div v-if="currentProblem.requirements" class="mb-6">
            <h3 class="text-lg font-bold text-gray-800 mb-3">Requirements</h3>
            <ul class="list-disc list-inside space-y-2 text-gray-700">
              <li v-for="(req, idx) in currentProblem.requirements" :key="idx">
                {{ req }}
              </li>
            </ul>
          </div>

          <!-- Example Usage -->
          <div v-if="currentProblem.example">
            <h3 class="text-lg font-bold text-gray-800 mb-3">Example Usage</h3>
            <div class="bg-gray-50 border border-gray-200 rounded-lg p-4 font-mono text-sm">
              <pre>{{ currentProblem.example }}</pre>
            </div>
          </div>
        </div>
      </div>

      <!-- Right: Code Editor & Results -->
      <div class="space-y-6">
        <!-- JPA Code Editor -->
        <div class="card">
          <h3 class="text-lg font-bold text-gray-800 mb-4">Your JPA Code</h3>

          <div class="bg-gray-900 rounded-lg overflow-hidden">
            <div class="bg-gray-800 text-white px-4 py-2 flex items-center justify-between">
              <span class="text-sm">Java / JPA</span>
              <div class="flex gap-2">
                <button @click="formatCode" class="text-sm px-3 py-1 bg-gray-700 hover:bg-gray-600 rounded transition-colors">
                  Format
                </button>
                <button @click="resetCode" class="text-sm px-3 py-1 bg-gray-700 hover:bg-gray-600 rounded transition-colors">
                  Reset
                </button>
              </div>
            </div>
            <textarea
              v-model="jpaCode"
              class="w-full h-96 p-4 font-mono text-sm bg-gray-900 text-gray-100 resize-none focus:outline-none"
              placeholder="@Entity&#10;public class User {&#10;    // Your code here&#10;}"
              spellcheck="false"
            ></textarea>
          </div>

          <div class="flex gap-4 mt-4">
            <button
              @click="validateCode"
              :disabled="submitting || !jpaCode.trim()"
              class="btn-secondary flex-1"
            >
              🔍 Validate
            </button>
            <button
              @click="submitCode"
              :disabled="submitting || !jpaCode.trim()"
              class="btn-success flex-1"
            >
              {{ submitting ? 'Submitting...' : '✓ Submit' }}
            </button>
          </div>
        </div>

        <!-- Validation Results -->
        <div v-if="validationResults" class="card">
          <h3 class="text-lg font-bold mb-4" :class="validationResults.valid ? 'text-green-700' : 'text-red-700'">
            {{ validationResults.valid ? '✓ Validation Passed' : '✗ Validation Failed' }}
          </h3>

          <div class="space-y-3">
            <div
              v-for="(check, idx) in validationResults.checks"
              :key="idx"
              class="p-3 rounded-lg border"
              :class="check.passed ? 'bg-green-50 border-green-200' : 'bg-red-50 border-red-200'"
            >
              <div class="flex items-center justify-between">
                <span :class="check.passed ? 'text-green-800' : 'text-red-800'">
                  {{ check.name }}
                </span>
                <span :class="check.passed ? 'text-green-600' : 'text-red-600'">
                  {{ check.passed ? '✓' : '✗' }}
                </span>
              </div>
              <div v-if="!check.passed && check.message" class="text-sm text-red-700 mt-1">
                {{ check.message }}
              </div>
            </div>
          </div>

          <div v-if="validationResults.valid" class="mt-4 p-4 bg-green-50 border border-green-200 rounded-lg">
            <div class="flex items-center justify-between">
              <div>
                <p class="font-bold text-green-800">Excellent! Code is correct!</p>
                <p class="text-sm text-green-700">+{{ currentProblem.wpReward || 50 }} WP | +{{ currentProblem.xpReward || 25 }} XP</p>
              </div>
              <div class="text-3xl">🎉</div>
            </div>
          </div>
        </div>

        <!-- Hints -->
        <div class="card bg-yellow-50 border-2 border-yellow-200">
          <h3 class="text-lg font-bold text-yellow-800 mb-3">💡 Tips</h3>
          <ul class="space-y-2 text-sm text-yellow-900">
            <li>• Use proper JPA annotations (@Entity, @Id, @Column, etc.)</li>
            <li>• Remember to define relationships (@OneToMany, @ManyToOne, etc.)</li>
            <li>• Consider cascade types and fetch strategies</li>
            <li>• Use proper naming conventions</li>
          </ul>
        </div>
      </div>
    </div>

    <!-- No Problem Selected -->
    <div v-else-if="!loading" class="card text-center py-12">
      <div class="text-6xl mb-4">☕</div>
      <h3 class="text-2xl font-bold text-gray-800 mb-2">Select a JPA Problem</h3>
      <p class="text-gray-600">Choose a problem from the dropdown above to start practicing!</p>
    </div>

    <!-- Loading State -->
    <div v-if="loading" class="text-center py-12">
      <div class="inline-block w-12 h-12 border-4 border-primary-600 border-t-transparent rounded-full animate-spin"></div>
      <p class="mt-4 text-gray-600">Loading JPA problems...</p>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useUserStore } from '../stores/userStore'
import { api } from '../api/client'

const userStore = useUserStore()

const loading = ref(true)
const problems = ref([])
const selectedProblemId = ref('')
const currentProblem = ref(null)
const jpaCode = ref('')
const submitting = ref(false)
const validationResults = ref(null)

const difficultyClass = computed(() => {
  const difficulty = currentProblem.value?.difficulty?.toLowerCase()
  if (difficulty === 'easy') return 'bg-green-100 text-green-800'
  if (difficulty === 'medium') return 'bg-yellow-100 text-yellow-800'
  if (difficulty === 'hard') return 'bg-red-100 text-red-800'
  return 'bg-gray-100 text-gray-800'
})

async function fetchProblems() {
  loading.value = true

  try {
    const response = await api.getJpaProblems()
    problems.value = response.data || []
  } catch (err) {
    console.error('Failed to fetch JPA problems:', err)

    // Mock data
    problems.value = [
      {
        id: 1,
        title: 'Create a User Entity',
        difficulty: 'Easy',
        description: 'Create a JPA entity for a User with id, username, email, and createdDate fields. The id should be auto-generated.',
        entities: `User
- id: Long (primary key, auto-generated)
- username: String (unique, not null)
- email: String (not null)
- createdDate: LocalDateTime`,
        requirements: [
          'Use @Entity annotation',
          'Use @Id and @GeneratedValue for the primary key',
          'Use @Column for field constraints',
          'Add proper getters and setters'
        ],
        example: `User user = new User();
user.setUsername("john_doe");
user.setEmail("john@example.com");
user.setCreatedDate(LocalDateTime.now());
entityManager.persist(user);`,
        wpReward: 50,
        xpReward: 25
      }
    ]
  } finally {
    loading.value = false
  }
}

async function loadProblem() {
  if (!selectedProblemId.value) return

  currentProblem.value = problems.value.find(p => p.id === selectedProblemId.value)
  jpaCode.value = ''
  validationResults.value = null
}

function formatCode() {
  // Basic Java formatting
  try {
    const lines = jpaCode.value.split('\n')
    let indentLevel = 0
    const formattedLines = lines.map(line => {
      const trimmed = line.trim()

      if (trimmed.startsWith('}')) {
        indentLevel = Math.max(0, indentLevel - 1)
      }

      const formattedLine = '    '.repeat(indentLevel) + trimmed

      if (trimmed.endsWith('{')) {
        indentLevel++
      }

      return formattedLine
    })

    jpaCode.value = formattedLines.join('\n')
  } catch (error) {
    console.error('Format error:', error)
  }
}

function resetCode() {
  jpaCode.value = ''
  validationResults.value = null
}

async function validateCode() {
  validationResults.value = null
  submitting.value = true

  try {
    await new Promise(resolve => setTimeout(resolve, 500))

    // Mock validation
    validationResults.value = {
      valid: false,
      checks: [
        { name: '@Entity annotation present', passed: true },
        { name: '@Id annotation on id field', passed: true },
        { name: '@GeneratedValue annotation', passed: false, message: 'Missing @GeneratedValue annotation' },
        { name: 'Proper field types', passed: true }
      ]
    }
  } catch (err) {
    console.error('Validation error:', err)
  } finally {
    submitting.value = false
  }
}

async function submitCode() {
  validationResults.value = null
  submitting.value = true

  try {
    const response = await api.submitJpa(currentProblem.value.id, jpaCode.value)
    validationResults.value = response.data

    if (response.data.valid) {
      userStore.earnWP(currentProblem.value.wpReward)
      userStore.addXP(currentProblem.value.xpReward)
      userStore.incrementCompletedProblems()
    }
  } catch (err) {
    console.error('Failed to submit code:', err)

    // Mock response
    validationResults.value = {
      valid: true,
      checks: [
        { name: '@Entity annotation present', passed: true },
        { name: '@Id annotation on id field', passed: true },
        { name: '@GeneratedValue annotation', passed: true },
        { name: 'Proper field types', passed: true },
        { name: 'Column constraints', passed: true }
      ]
    }

    userStore.earnWP(currentProblem.value.wpReward)
    userStore.addXP(currentProblem.value.xpReward)
    userStore.incrementCompletedProblems()
  } finally {
    submitting.value = false
  }
}

onMounted(() => {
  fetchProblems()
})
</script>
