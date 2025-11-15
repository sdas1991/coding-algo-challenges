<template>
  <div class="card h-full overflow-y-auto">
    <!-- Problem Header -->
    <div class="mb-6">
      <div class="flex items-start justify-between mb-3">
        <h2 class="text-2xl font-bold text-gray-800">{{ problem.title }}</h2>
        <span
          class="badge text-sm"
          :class="difficultyClass"
        >
          {{ problem.difficulty }}
        </span>
      </div>

      <!-- Tags -->
      <div class="flex flex-wrap gap-2 mb-4">
        <span
          v-for="tag in problem.tags"
          :key="tag"
          class="badge bg-blue-100 text-blue-800 text-xs"
        >
          {{ tag }}
        </span>
      </div>

      <!-- Meta Info -->
      <div class="flex items-center space-x-4 text-sm text-gray-600">
        <div class="flex items-center space-x-1">
          <span class="font-medium">WP Reward:</span>
          <span class="font-bold text-yellow-700">{{ problem.wpReward || 50 }}</span>
        </div>
        <div class="flex items-center space-x-1">
          <span class="font-medium">XP:</span>
          <span class="font-bold text-purple-700">{{ problem.xpReward || 25 }}</span>
        </div>
        <div v-if="problem.acceptanceRate" class="flex items-center space-x-1">
          <span class="font-medium">Acceptance:</span>
          <span class="font-bold text-green-700">{{ problem.acceptanceRate }}%</span>
        </div>
      </div>
    </div>

    <!-- Problem Description -->
    <div class="prose max-w-none mb-6">
      <h3 class="text-lg font-bold text-gray-800 mb-3">Description</h3>
      <div class="text-gray-700 leading-relaxed whitespace-pre-wrap">
        {{ problem.description }}
      </div>
    </div>

    <!-- Examples -->
    <div v-if="problem.examples && problem.examples.length > 0" class="mb-6">
      <h3 class="text-lg font-bold text-gray-800 mb-3">Examples</h3>
      <div class="space-y-4">
        <div
          v-for="(example, index) in problem.examples"
          :key="index"
          class="bg-gray-50 border border-gray-200 rounded-lg p-4"
        >
          <div class="font-medium text-gray-700 mb-2">Example {{ index + 1 }}:</div>

          <div class="space-y-2 font-mono text-sm">
            <div>
              <span class="text-gray-600">Input:</span>
              <div class="bg-white p-2 rounded border border-gray-300 mt-1">
                {{ example.input }}
              </div>
            </div>

            <div>
              <span class="text-gray-600">Output:</span>
              <div class="bg-white p-2 rounded border border-gray-300 mt-1">
                {{ example.output }}
              </div>
            </div>

            <div v-if="example.explanation">
              <span class="text-gray-600">Explanation:</span>
              <div class="text-gray-700 mt-1">
                {{ example.explanation }}
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Constraints -->
    <div v-if="problem.constraints && problem.constraints.length > 0" class="mb-6">
      <h3 class="text-lg font-bold text-gray-800 mb-3">Constraints</h3>
      <ul class="list-disc list-inside space-y-1 text-gray-700">
        <li v-for="(constraint, index) in problem.constraints" :key="index">
          {{ constraint }}
        </li>
      </ul>
    </div>

    <!-- Follow-up -->
    <div v-if="problem.followUp" class="mb-6 p-4 bg-purple-50 border border-purple-200 rounded-lg">
      <h3 class="text-lg font-bold text-purple-800 mb-2">Follow-up</h3>
      <p class="text-purple-900">{{ problem.followUp }}</p>
    </div>

    <!-- Hints Preview -->
    <div v-if="problem.hintsCount > 0" class="mb-6 p-4 bg-yellow-50 border border-yellow-200 rounded-lg">
      <div class="flex items-center justify-between">
        <div>
          <h3 class="text-lg font-bold text-yellow-800">Hints Available</h3>
          <p class="text-sm text-yellow-700">{{ problem.hintsCount }} progressive hints available</p>
        </div>
        <div class="text-2xl">💡</div>
      </div>
    </div>

    <!-- Companies -->
    <div v-if="problem.companies && problem.companies.length > 0" class="mb-4">
      <h3 class="text-sm font-bold text-gray-600 mb-2">Asked by:</h3>
      <div class="flex flex-wrap gap-2">
        <span
          v-for="company in problem.companies"
          :key="company"
          class="badge bg-gray-800 text-white text-xs"
        >
          {{ company }}
        </span>
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  problem: {
    type: Object,
    required: true,
    default: () => ({
      title: 'Problem Title',
      description: 'Problem description',
      difficulty: 'Medium',
      tags: [],
      examples: [],
      constraints: [],
      wpReward: 50,
      xpReward: 25
    })
  }
})

const difficultyClass = computed(() => {
  const difficulty = props.problem.difficulty?.toLowerCase()
  if (difficulty === 'easy') return 'bg-green-100 text-green-800'
  if (difficulty === 'medium') return 'bg-yellow-100 text-yellow-800'
  if (difficulty === 'hard') return 'bg-red-100 text-red-800'
  return 'bg-gray-100 text-gray-800'
})
</script>

<style scoped>
.prose {
  max-width: 100%;
}

::-webkit-scrollbar {
  width: 8px;
}

::-webkit-scrollbar-track {
  background: #f1f5f9;
}

::-webkit-scrollbar-thumb {
  background: #cbd5e1;
  border-radius: 4px;
}

::-webkit-scrollbar-thumb:hover {
  background: #94a3b8;
}
</style>
