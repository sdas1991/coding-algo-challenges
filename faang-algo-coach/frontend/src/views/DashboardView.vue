<template>
  <div class="space-y-6">
    <!-- Welcome Banner -->
    <div class="bg-gradient-to-r from-primary-600 to-purple-600 rounded-2xl shadow-lg p-8 text-white">
      <div class="flex items-center justify-between">
        <div>
          <h1 class="text-3xl font-bold mb-2">Welcome back, Coder!</h1>
          <p class="text-blue-100 text-lg">Ready to level up your skills today?</p>
        </div>
        <div class="text-6xl animate-bounce-slow">🚀</div>
      </div>
    </div>

    <!-- Daily Goals & Stats -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
      <!-- Daily Goal -->
      <div class="card bg-gradient-to-br from-green-50 to-emerald-50 border-2 border-green-200">
        <div class="flex items-center justify-between mb-4">
          <h3 class="text-lg font-bold text-gray-800">Daily Goal</h3>
          <span class="text-3xl">🎯</span>
        </div>
        <div class="space-y-3">
          <div>
            <div class="flex items-center justify-between text-sm mb-1">
              <span class="text-gray-600">Problems Solved</span>
              <span class="font-bold text-gray-800">
                {{ userStore.dailyGoal.problemsSolved }} / {{ userStore.dailyGoal.target }}
              </span>
            </div>
            <div class="w-full h-3 bg-gray-200 rounded-full overflow-hidden">
              <div
                class="h-full bg-gradient-to-r from-green-500 to-emerald-600 transition-all duration-500"
                :style="{ width: `${dailyGoalProgress}%` }"
              ></div>
            </div>
          </div>
          <div v-if="userStore.dailyGoal.completed" class="text-green-700 font-medium text-center">
            🎉 Daily goal completed!
          </div>
        </div>
      </div>

      <!-- Total Progress -->
      <div class="card bg-gradient-to-br from-blue-50 to-indigo-50 border-2 border-blue-200">
        <div class="flex items-center justify-between mb-4">
          <h3 class="text-lg font-bold text-gray-800">Total Progress</h3>
          <span class="text-3xl">📊</span>
        </div>
        <div class="space-y-2">
          <div class="flex items-center justify-between">
            <span class="text-gray-600">Problems Solved</span>
            <span class="text-2xl font-bold text-blue-700">{{ userStore.completedProblems }}</span>
          </div>
          <div class="flex items-center justify-between">
            <span class="text-gray-600">Total XP</span>
            <span class="text-2xl font-bold text-purple-700">{{ userStore.totalXp }}</span>
          </div>
        </div>
      </div>

      <!-- Achievements -->
      <div class="card bg-gradient-to-br from-yellow-50 to-amber-50 border-2 border-yellow-200">
        <div class="flex items-center justify-between mb-4">
          <h3 class="text-lg font-bold text-gray-800">Achievements</h3>
          <span class="text-3xl">🏆</span>
        </div>
        <div class="space-y-2">
          <div class="flex items-center justify-between">
            <span class="text-gray-600">Badges Earned</span>
            <span class="text-2xl font-bold text-yellow-700">{{ userStore.badges.length }}</span>
          </div>
          <div class="flex items-center justify-between">
            <span class="text-gray-600">Current Streak</span>
            <span class="text-2xl font-bold text-orange-700">{{ userStore.streak }} 🔥</span>
          </div>
        </div>
      </div>
    </div>

    <!-- Algorithm Arenas -->
    <div>
      <div class="flex items-center justify-between mb-6">
        <h2 class="text-2xl font-bold text-gray-800">Algorithm Arenas</h2>
        <span class="text-sm text-gray-600">Choose your challenge</span>
      </div>

      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <ArenaCard
          v-for="arena in arenas"
          :key="arena.name"
          :arena="arena"
        />
      </div>
    </div>

    <!-- Other Practice Areas -->
    <div>
      <h2 class="text-2xl font-bold text-gray-800 mb-6">More Practice</h2>

      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        <!-- SQL Practice -->
        <router-link to="/sql" class="card group cursor-pointer transform hover:scale-105 transition-all">
          <div class="text-center">
            <div class="text-5xl mb-4">🗄️</div>
            <h3 class="text-xl font-bold text-gray-800 mb-2 group-hover:text-primary-600 transition-colors">
              SQL Practice
            </h3>
            <p class="text-sm text-gray-600 mb-4">Master database queries</p>
            <div class="text-sm font-medium text-gray-500">50+ Problems</div>
          </div>
        </router-link>

        <!-- JPA Practice -->
        <router-link to="/jpa" class="card group cursor-pointer transform hover:scale-105 transition-all">
          <div class="text-center">
            <div class="text-5xl mb-4">☕</div>
            <h3 class="text-xl font-bold text-gray-800 mb-2 group-hover:text-primary-600 transition-colors">
              JPA Practice
            </h3>
            <p class="text-sm text-gray-600 mb-4">Hibernate & ORM</p>
            <div class="text-sm font-medium text-gray-500">30+ Problems</div>
          </div>
        </router-link>

        <!-- System Design -->
        <router-link to="/system-design" class="card group cursor-pointer transform hover:scale-105 transition-all">
          <div class="text-center">
            <div class="text-5xl mb-4">🏗️</div>
            <h3 class="text-xl font-bold text-gray-800 mb-2 group-hover:text-primary-600 transition-colors">
              System Design
            </h3>
            <p class="text-sm text-gray-600 mb-4">Architecture at scale</p>
            <div class="text-sm font-medium text-gray-500">25+ Topics</div>
          </div>
        </router-link>

        <!-- MCQ Quiz -->
        <router-link to="/mcq" class="card group cursor-pointer transform hover:scale-105 transition-all">
          <div class="text-center">
            <div class="text-5xl mb-4">❓</div>
            <h3 class="text-xl font-bold text-gray-800 mb-2 group-hover:text-primary-600 transition-colors">
              MCQ Quiz
            </h3>
            <p class="text-sm text-gray-600 mb-4">Test your knowledge</p>
            <div class="text-sm font-medium text-gray-500">200+ Questions</div>
          </div>
        </router-link>
      </div>
    </div>

    <!-- Loading State -->
    <div v-if="loading" class="text-center py-12">
      <div class="inline-block w-12 h-12 border-4 border-primary-600 border-t-transparent rounded-full animate-spin"></div>
      <p class="mt-4 text-gray-600">Loading your dashboard...</p>
    </div>

    <!-- Error State -->
    <div v-if="error" class="card bg-red-50 border-2 border-red-200">
      <div class="text-center py-6">
        <div class="text-4xl mb-4">⚠️</div>
        <p class="text-red-800 font-medium">{{ error }}</p>
        <button @click="fetchData" class="btn-primary mt-4">Retry</button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useUserStore } from '../stores/userStore'
import ArenaCard from '../components/ArenaCard.vue'
import { api } from '../api/client'

const userStore = useUserStore()
const loading = ref(true)
const error = ref('')

const arenas = ref([
  {
    name: 'arrays',
    displayName: 'Arrays',
    description: 'Master array manipulation and traversal',
    difficulty: 'Easy',
    totalProblems: 15,
    solvedProblems: 0
  },
  {
    name: 'strings',
    displayName: 'Strings',
    description: 'String algorithms and pattern matching',
    difficulty: 'Easy',
    totalProblems: 12,
    solvedProblems: 0
  },
  {
    name: 'linked-lists',
    displayName: 'Linked Lists',
    description: 'Pointer manipulation and list operations',
    difficulty: 'Medium',
    totalProblems: 10,
    solvedProblems: 0
  },
  {
    name: 'stacks-queues',
    displayName: 'Stacks & Queues',
    description: 'LIFO and FIFO data structures',
    difficulty: 'Medium',
    totalProblems: 8,
    solvedProblems: 0
  },
  {
    name: 'trees',
    displayName: 'Trees',
    description: 'Binary trees and traversals',
    difficulty: 'Medium',
    totalProblems: 14,
    solvedProblems: 0
  },
  {
    name: 'graphs',
    displayName: 'Graphs',
    description: 'Graph algorithms and traversals',
    difficulty: 'Hard',
    totalProblems: 12,
    solvedProblems: 0
  },
  {
    name: 'dynamic-programming',
    displayName: 'Dynamic Programming',
    description: 'Optimization and memoization',
    difficulty: 'Hard',
    totalProblems: 18,
    solvedProblems: 0
  },
  {
    name: 'backtracking',
    displayName: 'Backtracking',
    description: 'Recursive problem solving',
    difficulty: 'Hard',
    totalProblems: 10,
    solvedProblems: 0
  },
  {
    name: 'greedy',
    displayName: 'Greedy Algorithms',
    description: 'Optimal choice strategies',
    difficulty: 'Medium',
    totalProblems: 9,
    solvedProblems: 0
  },
  {
    name: 'binary-search',
    displayName: 'Binary Search',
    description: 'Efficient searching techniques',
    difficulty: 'Medium',
    totalProblems: 11,
    solvedProblems: 0
  }
])

const dailyGoalProgress = computed(() => {
  if (userStore.dailyGoal.target === 0) return 0
  return Math.min(100, (userStore.dailyGoal.problemsSolved / userStore.dailyGoal.target) * 100)
})

async function fetchData() {
  loading.value = true
  error.value = ''

  try {
    await Promise.all([
      userStore.fetchUserStats(),
      userStore.fetchDailyGoals(),
      userStore.fetchBadges(),
      fetchArenas()
    ])
  } catch (err) {
    console.error('Failed to fetch dashboard data:', err)
    error.value = 'Failed to load dashboard. Please try again.'
  } finally {
    loading.value = false
  }
}

async function fetchArenas() {
  try {
    const response = await api.getArenas()
    if (response.data && Array.isArray(response.data)) {
      arenas.value = response.data
    }
  } catch (err) {
    console.error('Failed to fetch arenas:', err)
    // Use default arenas on error
  }
}

onMounted(() => {
  fetchData()
})
</script>
