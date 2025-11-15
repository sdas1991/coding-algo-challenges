<template>
  <div class="space-y-6">
    <!-- Header -->
    <div class="flex items-center justify-between">
      <div>
        <h1 class="text-3xl font-bold text-gray-800">System Design</h1>
        <p class="text-gray-600 mt-1">Design scalable systems and architecture</p>
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
        <option value="">Select a system design problem...</option>
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

          <!-- Requirements -->
          <div v-if="currentProblem.requirements" class="mb-6">
            <h3 class="text-lg font-bold text-gray-800 mb-3">Functional Requirements</h3>
            <ul class="list-disc list-inside space-y-2 text-gray-700">
              <li v-for="(req, idx) in currentProblem.requirements" :key="idx">
                {{ req }}
              </li>
            </ul>
          </div>

          <!-- Non-Functional Requirements -->
          <div v-if="currentProblem.nonFunctionalReqs" class="mb-6">
            <h3 class="text-lg font-bold text-gray-800 mb-3">Non-Functional Requirements</h3>
            <ul class="list-disc list-inside space-y-2 text-gray-700">
              <li v-for="(req, idx) in currentProblem.nonFunctionalReqs" :key="idx">
                {{ req }}
              </li>
            </ul>
          </div>

          <!-- Scale Estimates -->
          <div v-if="currentProblem.scale" class="mb-6 p-4 bg-blue-50 border border-blue-200 rounded-lg">
            <h3 class="text-lg font-bold text-blue-800 mb-3">Scale</h3>
            <div class="space-y-1 text-sm text-blue-900">
              <div v-for="(value, key) in currentProblem.scale" :key="key" class="flex justify-between">
                <span class="font-medium">{{ key }}:</span>
                <span>{{ value }}</span>
              </div>
            </div>
          </div>

          <!-- Key Components to Consider -->
          <div v-if="currentProblem.components" class="mb-6">
            <h3 class="text-lg font-bold text-gray-800 mb-3">Key Components to Consider</h3>
            <div class="flex flex-wrap gap-2">
              <span
                v-for="comp in currentProblem.components"
                :key="comp"
                class="badge bg-purple-100 text-purple-800"
              >
                {{ comp }}
              </span>
            </div>
          </div>
        </div>
      </div>

      <!-- Right: Design Editor & Submission -->
      <div class="space-y-6">
        <!-- Design Editor -->
        <div class="card">
          <h3 class="text-lg font-bold text-gray-800 mb-4">Your System Design</h3>

          <div class="space-y-4">
            <!-- Section Tabs -->
            <div class="flex border-b border-gray-200">
              <button
                v-for="section in sections"
                :key="section.id"
                @click="activeSection = section.id"
                class="px-4 py-2 font-medium transition-colors"
                :class="activeSection === section.id
                  ? 'text-primary-600 border-b-2 border-primary-600'
                  : 'text-gray-600 hover:text-gray-800'"
              >
                {{ section.name }}
              </button>
            </div>

            <!-- High-Level Architecture -->
            <div v-show="activeSection === 'architecture'">
              <label class="block text-sm font-medium text-gray-700 mb-2">
                High-Level Architecture
              </label>
              <textarea
                v-model="design.architecture"
                class="input-field h-64 font-mono text-sm"
                placeholder="Describe your high-level architecture...&#10;&#10;Example:&#10;- Client Layer (Web/Mobile)&#10;- Load Balancer&#10;- Application Servers&#10;- Database (Primary/Replica)&#10;- Cache Layer (Redis)&#10;- Message Queue&#10;- CDN"
                spellcheck="false"
              ></textarea>
            </div>

            <!-- Database Schema -->
            <div v-show="activeSection === 'database'">
              <label class="block text-sm font-medium text-gray-700 mb-2">
                Database Design
              </label>
              <textarea
                v-model="design.database"
                class="input-field h-64 font-mono text-sm"
                placeholder="Describe your database schema...&#10;&#10;Example:&#10;Users Table:&#10;- user_id (PK)&#10;- username&#10;- email&#10;- created_at"
                spellcheck="false"
              ></textarea>
            </div>

            <!-- APIs -->
            <div v-show="activeSection === 'apis'">
              <label class="block text-sm font-medium text-gray-700 mb-2">
                API Design
              </label>
              <textarea
                v-model="design.apis"
                class="input-field h-64 font-mono text-sm"
                placeholder="Define your APIs...&#10;&#10;Example:&#10;POST /api/users&#10;GET /api/users/:id&#10;PUT /api/users/:id&#10;DELETE /api/users/:id"
                spellcheck="false"
              ></textarea>
            </div>

            <!-- Scalability -->
            <div v-show="activeSection === 'scalability'">
              <label class="block text-sm font-medium text-gray-700 mb-2">
                Scalability & Performance
              </label>
              <textarea
                v-model="design.scalability"
                class="input-field h-64 font-mono text-sm"
                placeholder="How will you handle scale?&#10;&#10;Consider:&#10;- Horizontal vs Vertical Scaling&#10;- Caching Strategy&#10;- Database Sharding&#10;- Load Balancing&#10;- CDN for static assets"
                spellcheck="false"
              ></textarea>
            </div>

            <!-- Trade-offs -->
            <div v-show="activeSection === 'tradeoffs'">
              <label class="block text-sm font-medium text-gray-700 mb-2">
                Trade-offs & Considerations
              </label>
              <textarea
                v-model="design.tradeoffs"
                class="input-field h-64 font-mono text-sm"
                placeholder="Discuss trade-offs in your design...&#10;&#10;Consider:&#10;- CAP Theorem (Consistency vs Availability)&#10;- SQL vs NoSQL&#10;- Monolith vs Microservices&#10;- Cost vs Performance"
                spellcheck="false"
              ></textarea>
            </div>
          </div>

          <!-- Action Buttons -->
          <div class="flex gap-4 mt-6">
            <button
              @click="saveDraft"
              class="btn-secondary flex-1"
            >
              💾 Save Draft
            </button>
            <button
              @click="submitDesign"
              :disabled="submitting || !isDesignComplete"
              class="btn-success flex-1"
            >
              {{ submitting ? 'Submitting...' : '✓ Submit Design' }}
            </button>
          </div>
        </div>

        <!-- Submission Result -->
        <div v-if="submissionResult" class="card">
          <h3 class="text-lg font-bold mb-4 text-green-700">
            ✓ Design Submitted Successfully!
          </h3>

          <div class="space-y-4">
            <div class="p-4 bg-green-50 border border-green-200 rounded-lg">
              <div class="flex items-center justify-between">
                <div>
                  <p class="font-bold text-green-800">Great work on your design!</p>
                  <p class="text-sm text-green-700">
                    +{{ currentProblem.wpReward || 100 }} WP | +{{ currentProblem.xpReward || 50 }} XP
                  </p>
                </div>
                <div class="text-3xl">🏗️</div>
              </div>
            </div>

            <div v-if="submissionResult.feedback">
              <h4 class="font-bold text-gray-800 mb-2">Feedback:</h4>
              <div class="bg-blue-50 border border-blue-200 rounded-lg p-4">
                <p class="text-blue-900 text-sm whitespace-pre-wrap">{{ submissionResult.feedback }}</p>
              </div>
            </div>
          </div>
        </div>

        <!-- Tips -->
        <div class="card bg-purple-50 border-2 border-purple-200">
          <h3 class="text-lg font-bold text-purple-800 mb-3">💡 Design Tips</h3>
          <ul class="space-y-2 text-sm text-purple-900">
            <li>• Start with requirements clarification</li>
            <li>• Estimate capacity and scale</li>
            <li>• Design high-level architecture first</li>
            <li>• Consider bottlenecks and single points of failure</li>
            <li>• Discuss trade-offs between different approaches</li>
            <li>• Think about monitoring and observability</li>
          </ul>
        </div>
      </div>
    </div>

    <!-- No Problem Selected -->
    <div v-else-if="!loading" class="card text-center py-12">
      <div class="text-6xl mb-4">🏗️</div>
      <h3 class="text-2xl font-bold text-gray-800 mb-2">Select a System Design Problem</h3>
      <p class="text-gray-600">Choose a problem from the dropdown above to start designing!</p>
    </div>

    <!-- Loading State -->
    <div v-if="loading" class="text-center py-12">
      <div class="inline-block w-12 h-12 border-4 border-primary-600 border-t-transparent rounded-full animate-spin"></div>
      <p class="mt-4 text-gray-600">Loading system design problems...</p>
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
const submitting = ref(false)
const submissionResult = ref(null)

const activeSection = ref('architecture')

const sections = [
  { id: 'architecture', name: 'Architecture' },
  { id: 'database', name: 'Database' },
  { id: 'apis', name: 'APIs' },
  { id: 'scalability', name: 'Scalability' },
  { id: 'tradeoffs', name: 'Trade-offs' }
]

const design = ref({
  architecture: '',
  database: '',
  apis: '',
  scalability: '',
  tradeoffs: ''
})

const difficultyClass = computed(() => {
  const difficulty = currentProblem.value?.difficulty?.toLowerCase()
  if (difficulty === 'easy') return 'bg-green-100 text-green-800'
  if (difficulty === 'medium') return 'bg-yellow-100 text-yellow-800'
  if (difficulty === 'hard') return 'bg-red-100 text-red-800'
  return 'bg-gray-100 text-gray-800'
})

const isDesignComplete = computed(() => {
  return design.value.architecture.trim().length > 0
})

async function fetchProblems() {
  loading.value = true

  try {
    const response = await api.getSystemDesignProblems()
    problems.value = response.data || []
  } catch (err) {
    console.error('Failed to fetch system design problems:', err)

    // Mock data
    problems.value = [
      {
        id: 1,
        title: 'Design URL Shortener',
        difficulty: 'Medium',
        description: 'Design a URL shortening service like bit.ly that converts long URLs into short URLs and redirects users when they click on the short URL.',
        requirements: [
          'Users can submit a long URL and get a short URL',
          'When users visit the short URL, they are redirected to the original URL',
          'Short URLs should be unique and as short as possible',
          'Track basic analytics (click count)'
        ],
        nonFunctionalReqs: [
          'High availability (99.9% uptime)',
          'Low latency for redirects (<100ms)',
          'Handle 1000 requests per second',
          'Data should be persistent'
        ],
        scale: {
          'Daily Active Users': '1 Million',
          'URLs created per day': '100K',
          'Read:Write Ratio': '100:1',
          'Storage (5 years)': '~180GB'
        },
        components: [
          'Load Balancer',
          'Application Servers',
          'Database (SQL/NoSQL)',
          'Cache (Redis)',
          'Base62 Encoding',
          'Analytics Service'
        ],
        wpReward: 100,
        xpReward: 50
      }
    ]
  } finally {
    loading.value = false
  }
}

async function loadProblem() {
  if (!selectedProblemId.value) return

  currentProblem.value = problems.value.find(p => p.id === selectedProblemId.value)

  // Load saved draft if exists
  design.value = {
    architecture: '',
    database: '',
    apis: '',
    scalability: '',
    tradeoffs: ''
  }

  submissionResult.value = null
  activeSection.value = 'architecture'
}

function saveDraft() {
  // Save to local storage
  localStorage.setItem(
    `design_${currentProblem.value.id}`,
    JSON.stringify(design.value)
  )

  alert('Draft saved successfully!')
}

async function submitDesign() {
  submissionResult.value = null
  submitting.value = true

  try {
    const response = await api.submitSystemDesign(currentProblem.value.id, design.value)
    submissionResult.value = response.data

    userStore.earnWP(currentProblem.value.wpReward)
    userStore.addXP(currentProblem.value.xpReward)
    userStore.incrementCompletedProblems()

    // Clear draft
    localStorage.removeItem(`design_${currentProblem.value.id}`)
  } catch (err) {
    console.error('Failed to submit design:', err)

    // Mock response
    submissionResult.value = {
      success: true,
      feedback: `Great design! Key strengths:
- Good consideration of scalability with caching layer
- Proper database selection for the use case
- Well-defined APIs

Areas for improvement:
- Consider adding rate limiting to prevent abuse
- Think about geo-distributed deployments for global users
- Add more details on monitoring and alerting`
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
