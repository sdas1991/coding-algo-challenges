<template>
  <header class="bg-white shadow-md sticky top-0 z-50">
    <div class="container mx-auto px-4 py-4 max-w-7xl">
      <div class="flex items-center justify-between">
        <!-- Logo and Title -->
        <router-link to="/" class="flex items-center space-x-3 group">
          <div class="w-10 h-10 bg-gradient-to-br from-primary-600 to-purple-600 rounded-lg flex items-center justify-center transform group-hover:scale-110 transition-transform">
            <span class="text-white text-xl font-bold">FA</span>
          </div>
          <div>
            <h1 class="text-2xl font-bold text-gradient">FAANG Algo Coach</h1>
            <p class="text-xs text-gray-500">Level up your coding game</p>
          </div>
        </router-link>

        <!-- Stats Bar -->
        <div class="flex items-center space-x-6">
          <!-- WP Counter -->
          <div class="flex items-center space-x-2 bg-yellow-50 px-4 py-2 rounded-lg border-2 border-yellow-200">
            <div class="w-8 h-8 bg-gradient-to-br from-yellow-400 to-yellow-600 rounded-full flex items-center justify-center">
              <span class="text-white text-sm font-bold">W</span>
            </div>
            <div>
              <p class="text-xs text-gray-600 font-medium">Wisdom Points</p>
              <p class="text-lg font-bold text-yellow-700">{{ userStore.wp }}</p>
            </div>
          </div>

          <!-- Streak -->
          <div class="flex items-center space-x-2 bg-orange-50 px-4 py-2 rounded-lg border-2 border-orange-200">
            <div class="text-2xl animate-pulse-slow">{{ userStore.streakEmoji }}</div>
            <div>
              <p class="text-xs text-gray-600 font-medium">Streak</p>
              <p class="text-lg font-bold text-orange-700">{{ userStore.streak }} days</p>
            </div>
          </div>

          <!-- Level Badge -->
          <div class="flex items-center space-x-2 bg-purple-50 px-4 py-2 rounded-lg border-2 border-purple-200">
            <div class="w-12 h-12 bg-gradient-to-br from-purple-500 to-indigo-600 rounded-full flex items-center justify-center relative">
              <span class="text-white text-xl font-bold">{{ userStore.level }}</span>
              <div class="absolute -bottom-1 -right-1 w-4 h-4 bg-green-500 rounded-full border-2 border-white"></div>
            </div>
            <div>
              <p class="text-xs text-gray-600 font-medium">{{ userStore.levelBadge.name }}</p>
              <div class="w-24 h-2 bg-gray-200 rounded-full overflow-hidden mt-1">
                <div
                  class="h-full bg-gradient-to-r from-purple-500 to-indigo-600 transition-all duration-500"
                  :style="{ width: `${userStore.levelProgress}%` }"
                ></div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </header>
</template>

<script setup>
import { useUserStore } from '../stores/userStore'

const userStore = useUserStore()
</script>
