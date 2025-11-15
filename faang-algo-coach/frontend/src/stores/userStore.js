import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import { api } from '../api/client'

export const useUserStore = defineStore('user', () => {
  // State
  const wp = ref(1000)
  const streak = ref(0)
  const level = ref(1)
  const totalXp = ref(0)
  const completedProblems = ref(0)
  const badges = ref([])
  const dailyGoal = ref({
    problemsSolved: 0,
    target: 3,
    completed: false
  })

  // Computed
  const levelProgress = computed(() => {
    const xpForNextLevel = level.value * 100
    const currentLevelXp = totalXp.value % xpForNextLevel
    return (currentLevelXp / xpForNextLevel) * 100
  })

  const streakEmoji = computed(() => {
    if (streak.value === 0) return '💤'
    if (streak.value < 3) return '🔥'
    if (streak.value < 7) return '🔥🔥'
    if (streak.value < 30) return '🔥🔥🔥'
    return '🔥🔥🔥🔥'
  })

  const levelBadge = computed(() => {
    if (level.value < 5) return { name: 'Novice', color: 'gray' }
    if (level.value < 10) return { name: 'Apprentice', color: 'blue' }
    if (level.value < 20) return { name: 'Expert', color: 'purple' }
    if (level.value < 50) return { name: 'Master', color: 'yellow' }
    return { name: 'Grandmaster', color: 'red' }
  })

  // Actions
  async function fetchUserStats() {
    try {
      const response = await api.getUserStats()
      const data = response.data

      wp.value = data.wp || 1000
      streak.value = data.streak || 0
      level.value = data.level || 1
      totalXp.value = data.totalXp || 0
      completedProblems.value = data.completedProblems || 0
    } catch (error) {
      console.error('Failed to fetch user stats:', error)
      // Use default values on error
    }
  }

  async function fetchDailyGoals() {
    try {
      const response = await api.getDailyGoals()
      dailyGoal.value = response.data
    } catch (error) {
      console.error('Failed to fetch daily goals:', error)
    }
  }

  async function fetchBadges() {
    try {
      const response = await api.getBadges()
      badges.value = response.data
    } catch (error) {
      console.error('Failed to fetch badges:', error)
    }
  }

  function spendWP(amount) {
    if (wp.value >= amount) {
      wp.value -= amount
      return true
    }
    return false
  }

  function earnWP(amount) {
    wp.value += amount
  }

  function addXP(amount) {
    totalXp.value += amount
    const newLevel = Math.floor(totalXp.value / 100) + 1
    if (newLevel > level.value) {
      level.value = newLevel
      // Level up bonus
      earnWP(50)
    }
  }

  function incrementStreak() {
    streak.value += 1
  }

  function resetStreak() {
    streak.value = 0
  }

  function incrementCompletedProblems() {
    completedProblems.value += 1
    dailyGoal.value.problemsSolved += 1
    if (dailyGoal.value.problemsSolved >= dailyGoal.value.target) {
      dailyGoal.value.completed = true
    }
  }

  return {
    // State
    wp,
    streak,
    level,
    totalXp,
    completedProblems,
    badges,
    dailyGoal,

    // Computed
    levelProgress,
    streakEmoji,
    levelBadge,

    // Actions
    fetchUserStats,
    fetchDailyGoals,
    fetchBadges,
    spendWP,
    earnWP,
    addXP,
    incrementStreak,
    resetStreak,
    incrementCompletedProblems
  }
})
