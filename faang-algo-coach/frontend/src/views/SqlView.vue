<template>
  <div class="space-y-6">
    <!-- Header -->
    <div class="flex items-center justify-between">
      <div>
        <h1 class="text-3xl font-bold text-gray-800">SQL Practice</h1>
        <p class="text-gray-600 mt-1">Master database queries and joins</p>
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
        <option value="">Select a SQL problem...</option>
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

          <!-- Schema -->
          <div v-if="currentProblem.schema" class="mb-6">
            <h3 class="text-lg font-bold text-gray-800 mb-3">Database Schema</h3>
            <div class="bg-gray-900 text-gray-100 p-4 rounded-lg font-mono text-sm overflow-x-auto">
              <pre>{{ currentProblem.schema }}</pre>
            </div>
          </div>

          <!-- Sample Data -->
          <div v-if="currentProblem.sampleData" class="mb-6">
            <h3 class="text-lg font-bold text-gray-800 mb-3">Sample Data</h3>
            <div class="overflow-x-auto">
              <table class="min-w-full divide-y divide-gray-200 border border-gray-300">
                <thead class="bg-gray-50">
                  <tr>
                    <th
                      v-for="col in currentProblem.sampleData.columns"
                      :key="col"
                      class="px-4 py-2 text-left text-xs font-medium text-gray-700 uppercase"
                    >
                      {{ col }}
                    </th>
                  </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                  <tr v-for="(row, idx) in currentProblem.sampleData.rows" :key="idx">
                    <td
                      v-for="(val, i) in row"
                      :key="i"
                      class="px-4 py-2 text-sm text-gray-700"
                    >
                      {{ val }}
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>

          <!-- Expected Output -->
          <div v-if="currentProblem.expectedOutput">
            <h3 class="text-lg font-bold text-gray-800 mb-3">Expected Output</h3>
            <div class="bg-gray-50 border border-gray-200 rounded-lg p-4 font-mono text-sm">
              <pre>{{ currentProblem.expectedOutput }}</pre>
            </div>
          </div>
        </div>
      </div>

      <!-- Right: SQL Editor & Results -->
      <div class="space-y-6">
        <!-- SQL Editor -->
        <div class="card">
          <h3 class="text-lg font-bold text-gray-800 mb-4">Your SQL Query</h3>

          <div class="bg-gray-900 rounded-lg overflow-hidden">
            <div class="bg-gray-800 text-white px-4 py-2 flex items-center justify-between">
              <span class="text-sm">SQL Editor</span>
              <button @click="formatQuery" class="text-sm px-3 py-1 bg-gray-700 hover:bg-gray-600 rounded transition-colors">
                Format
              </button>
            </div>
            <textarea
              v-model="sqlQuery"
              class="w-full h-64 p-4 font-mono text-sm bg-gray-900 text-gray-100 resize-none focus:outline-none"
              placeholder="SELECT * FROM ..."
              spellcheck="false"
            ></textarea>
          </div>

          <div class="flex gap-4 mt-4">
            <button
              @click="runQuery"
              :disabled="submitting || !sqlQuery.trim()"
              class="btn-secondary flex-1"
            >
              ▶️ Run Query
            </button>
            <button
              @click="submitQuery"
              :disabled="submitting || !sqlQuery.trim()"
              class="btn-success flex-1"
            >
              {{ submitting ? 'Submitting...' : '✓ Submit' }}
            </button>
          </div>
        </div>

        <!-- Query Results -->
        <div v-if="queryResults" class="card">
          <h3 class="text-lg font-bold mb-4" :class="queryResults.success ? 'text-green-700' : 'text-red-700'">
            {{ queryResults.success ? '✓ Query Results' : '✗ Query Failed' }}
          </h3>

          <div v-if="queryResults.success && queryResults.data">
            <div class="overflow-x-auto">
              <table class="min-w-full divide-y divide-gray-200 border border-gray-300">
                <thead class="bg-gray-50">
                  <tr>
                    <th
                      v-for="col in queryResults.data.columns"
                      :key="col"
                      class="px-4 py-2 text-left text-xs font-medium text-gray-700 uppercase"
                    >
                      {{ col }}
                    </th>
                  </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                  <tr v-for="(row, idx) in queryResults.data.rows" :key="idx">
                    <td
                      v-for="(val, i) in row"
                      :key="i"
                      class="px-4 py-2 text-sm text-gray-700"
                    >
                      {{ val }}
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>

            <div v-if="queryResults.correct" class="mt-4 p-4 bg-green-50 border border-green-200 rounded-lg">
              <div class="flex items-center justify-between">
                <div>
                  <p class="font-bold text-green-800">Perfect! Query is correct!</p>
                  <p class="text-sm text-green-700">+{{ currentProblem.wpReward || 50 }} WP | +{{ currentProblem.xpReward || 25 }} XP</p>
                </div>
                <div class="text-3xl">🎉</div>
              </div>
            </div>
          </div>

          <div v-if="!queryResults.success" class="bg-red-50 border border-red-200 rounded-lg p-4">
            <p class="text-red-800 font-mono text-sm">{{ queryResults.error }}</p>
          </div>
        </div>
      </div>
    </div>

    <!-- No Problem Selected -->
    <div v-else-if="!loading" class="card text-center py-12">
      <div class="text-6xl mb-4">🗄️</div>
      <h3 class="text-2xl font-bold text-gray-800 mb-2">Select a SQL Problem</h3>
      <p class="text-gray-600">Choose a problem from the dropdown above to start practicing!</p>
    </div>

    <!-- Loading State -->
    <div v-if="loading" class="text-center py-12">
      <div class="inline-block w-12 h-12 border-4 border-primary-600 border-t-transparent rounded-full animate-spin"></div>
      <p class="mt-4 text-gray-600">Loading SQL problems...</p>
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
const sqlQuery = ref('')
const submitting = ref(false)
const queryResults = ref(null)

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
    const response = await api.getSqlProblems()
    problems.value = response.data || []
  } catch (err) {
    console.error('Failed to fetch SQL problems:', err)

    // Mock data
    problems.value = [
      {
        id: 1,
        title: 'Customers Who Never Order',
        difficulty: 'Easy',
        description: 'Write a SQL query to find all customers who never order anything.',
        schema: `Table: Customers
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+

Table: Orders
+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| customerId  | int  |
+-------------+------+`,
        sampleData: {
          columns: ['id', 'name'],
          rows: [
            [1, 'Alice'],
            [2, 'Bob'],
            [3, 'Charlie']
          ]
        },
        expectedOutput: 'name\n-----\nCharlie',
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
  sqlQuery.value = ''
  queryResults.value = null
}

function formatQuery() {
  const keywords = ['SELECT', 'FROM', 'WHERE', 'JOIN', 'LEFT', 'RIGHT', 'INNER', 'OUTER', 'ON', 'GROUP BY', 'ORDER BY', 'HAVING', 'AS', 'AND', 'OR', 'NOT', 'IN', 'EXISTS']
  let formatted = sqlQuery.value

  keywords.forEach(keyword => {
    const regex = new RegExp(`\\b${keyword}\\b`, 'gi')
    formatted = formatted.replace(regex, keyword)
  })

  sqlQuery.value = formatted
}

async function runQuery() {
  queryResults.value = null
  submitting.value = true

  try {
    await new Promise(resolve => setTimeout(resolve, 500))

    // Mock results
    queryResults.value = {
      success: true,
      data: {
        columns: ['name'],
        rows: [['Charlie']]
      },
      correct: false
    }
  } catch (err) {
    queryResults.value = {
      success: false,
      error: err.message
    }
  } finally {
    submitting.value = false
  }
}

async function submitQuery() {
  queryResults.value = null
  submitting.value = true

  try {
    const response = await api.submitSql(currentProblem.value.id, sqlQuery.value)
    queryResults.value = response.data

    if (response.data.correct) {
      userStore.earnWP(currentProblem.value.wpReward)
      userStore.addXP(currentProblem.value.xpReward)
      userStore.incrementCompletedProblems()
    }
  } catch (err) {
    console.error('Failed to submit query:', err)

    // Mock response
    queryResults.value = {
      success: true,
      correct: true,
      data: {
        columns: ['name'],
        rows: [['Charlie']]
      }
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
