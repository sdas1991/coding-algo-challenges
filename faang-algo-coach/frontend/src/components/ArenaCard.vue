<template>
  <router-link
    :to="`/arena/${arena.name}`"
    class="card group cursor-pointer transform hover:scale-105 transition-all duration-200"
  >
    <div class="flex items-start justify-between mb-4">
      <div class="flex-1">
        <h3 class="text-xl font-bold text-gray-800 group-hover:text-primary-600 transition-colors">
          {{ arena.displayName }}
        </h3>
        <p class="text-sm text-gray-600 mt-1">{{ arena.description }}</p>
      </div>

      <!-- Progress Ring -->
      <div class="relative w-16 h-16 ml-4">
        <svg class="transform -rotate-90 w-16 h-16">
          <circle
            cx="32"
            cy="32"
            r="28"
            stroke="currentColor"
            stroke-width="4"
            fill="transparent"
            class="text-gray-200"
          />
          <circle
            cx="32"
            cy="32"
            r="28"
            stroke="currentColor"
            stroke-width="4"
            fill="transparent"
            :stroke-dasharray="circumference"
            :stroke-dashoffset="strokeDashoffset"
            class="progress-ring-circle"
            :class="progressColor"
          />
        </svg>
        <div class="absolute inset-0 flex items-center justify-center">
          <span class="text-sm font-bold text-gray-700">{{ progressPercentage }}%</span>
        </div>
      </div>
    </div>

    <!-- Stats -->
    <div class="grid grid-cols-3 gap-4 mt-4 pt-4 border-t border-gray-200">
      <div>
        <p class="text-xs text-gray-500">Total</p>
        <p class="text-lg font-bold text-gray-800">{{ arena.totalProblems || 0 }}</p>
      </div>
      <div>
        <p class="text-xs text-gray-500">Solved</p>
        <p class="text-lg font-bold text-success">{{ arena.solvedProblems || 0 }}</p>
      </div>
      <div>
        <p class="text-xs text-gray-500">Difficulty</p>
        <span :class="difficultyClass" class="badge text-xs">
          {{ arena.difficulty }}
        </span>
      </div>
    </div>
  </router-link>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  arena: {
    type: Object,
    required: true
  }
})

const circumference = 2 * Math.PI * 28

const progressPercentage = computed(() => {
  if (!props.arena.totalProblems) return 0
  return Math.round((props.arena.solvedProblems / props.arena.totalProblems) * 100)
})

const strokeDashoffset = computed(() => {
  return circumference - (progressPercentage.value / 100) * circumference
})

const progressColor = computed(() => {
  if (progressPercentage.value < 33) return 'text-red-500'
  if (progressPercentage.value < 66) return 'text-yellow-500'
  return 'text-green-500'
})

const difficultyClass = computed(() => {
  const difficulty = props.arena.difficulty?.toLowerCase()
  if (difficulty === 'easy') return 'bg-green-100 text-green-800'
  if (difficulty === 'medium') return 'bg-yellow-100 text-yellow-800'
  if (difficulty === 'hard') return 'bg-red-100 text-red-800'
  return 'bg-gray-100 text-gray-800'
})
</script>
