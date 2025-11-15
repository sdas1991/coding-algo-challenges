<template>
  <div class="card">
    <div class="flex items-center justify-between mb-4">
      <h3 class="text-lg font-bold text-gray-800">Hints</h3>
      <div class="flex items-center space-x-2">
        <span class="text-sm text-gray-600">Progressive hints cost WP</span>
      </div>
    </div>

    <!-- Hints List -->
    <div class="space-y-3">
      <div
        v-for="(hint, index) in hints"
        :key="index"
        class="border border-gray-200 rounded-lg overflow-hidden"
      >
        <!-- Hint Header -->
        <div
          class="flex items-center justify-between p-3"
          :class="hint.unlocked ? 'bg-green-50' : 'bg-gray-50'"
        >
          <div class="flex items-center space-x-2">
            <span
              class="w-6 h-6 rounded-full flex items-center justify-center text-xs font-bold"
              :class="hint.unlocked ? 'bg-green-500 text-white' : 'bg-gray-300 text-gray-600'"
            >
              {{ index + 1 }}
            </span>
            <span class="font-medium text-gray-700">Hint {{ index + 1 }}</span>
          </div>

          <!-- Unlock Button -->
          <button
            v-if="!hint.unlocked"
            @click="unlockHint(index)"
            :disabled="loading || userStore.wp < hint.cost"
            class="px-3 py-1 rounded-lg text-sm font-medium transition-colors"
            :class="userStore.wp >= hint.cost
              ? 'bg-yellow-500 text-white hover:bg-yellow-600'
              : 'bg-gray-300 text-gray-500 cursor-not-allowed'"
          >
            <span class="flex items-center space-x-1">
              <span>Unlock</span>
              <span class="font-bold">({{ hint.cost }} WP)</span>
            </span>
          </button>
          <span v-else class="text-green-600 text-sm font-medium">Unlocked</span>
        </div>

        <!-- Hint Content -->
        <div v-if="hint.unlocked" class="p-4 bg-white border-t border-gray-200">
          <p class="text-gray-700 leading-relaxed">{{ hint.content }}</p>
          <div v-if="hint.codeSnippet" class="mt-3 p-3 bg-gray-900 text-gray-100 rounded-lg font-mono text-sm">
            <pre class="whitespace-pre-wrap">{{ hint.codeSnippet }}</pre>
          </div>
        </div>
      </div>
    </div>

    <!-- No Hints Message -->
    <div v-if="hints.length === 0" class="text-center py-8 text-gray-500">
      <p>No hints available for this problem.</p>
      <p class="text-sm mt-2">Try solving it on your own first!</p>
    </div>

    <!-- All Hints Unlocked -->
    <div v-if="allHintsUnlocked && hints.length > 0" class="mt-4 p-4 bg-green-50 border border-green-200 rounded-lg">
      <p class="text-green-800 font-medium text-center">
        All hints unlocked! You've got this!
      </p>
    </div>

    <!-- Teach Me Button -->
    <div class="mt-6 pt-4 border-t border-gray-200">
      <button
        @click="requestTeachMe"
        :disabled="loading"
        class="w-full px-4 py-3 bg-gradient-to-r from-purple-600 to-indigo-600 text-white rounded-lg hover:from-purple-700 hover:to-indigo-700 transition-all font-medium"
      >
        <span class="flex items-center justify-center space-x-2">
          <span>Teach Me (Full Solution)</span>
          <span class="font-bold">({{ teachMeCost }} WP)</span>
        </span>
      </button>
      <p class="text-xs text-gray-500 text-center mt-2">
        Get complete explanation with solution and time/space complexity
      </p>
    </div>

    <!-- Error Message -->
    <div v-if="error" class="mt-4 p-3 bg-red-50 border border-red-200 rounded-lg">
      <p class="text-red-800 text-sm">{{ error }}</p>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import { useUserStore } from '../stores/userStore'

const props = defineProps({
  problemId: {
    type: [Number, String],
    required: true
  },
  hints: {
    type: Array,
    default: () => []
  },
  teachMeCost: {
    type: Number,
    default: 100
  }
})

const emit = defineEmits(['unlock-hint', 'teach-me'])

const userStore = useUserStore()
const loading = ref(false)
const error = ref('')

const allHintsUnlocked = computed(() => {
  return props.hints.length > 0 && props.hints.every(h => h.unlocked)
})

async function unlockHint(index) {
  const hint = props.hints[index]

  if (userStore.wp < hint.cost) {
    error.value = 'Not enough Wisdom Points!'
    setTimeout(() => error.value = '', 3000)
    return
  }

  loading.value = true
  error.value = ''

  try {
    emit('unlock-hint', index)
  } catch (err) {
    error.value = 'Failed to unlock hint. Please try again.'
    console.error('Unlock hint error:', err)
  } finally {
    loading.value = false
  }
}

async function requestTeachMe() {
  if (userStore.wp < props.teachMeCost) {
    error.value = 'Not enough Wisdom Points for full solution!'
    setTimeout(() => error.value = '', 3000)
    return
  }

  loading.value = true
  error.value = ''

  try {
    emit('teach-me')
  } catch (err) {
    error.value = 'Failed to get solution. Please try again.'
    console.error('Teach me error:', err)
  } finally {
    loading.value = false
  }
}
</script>
