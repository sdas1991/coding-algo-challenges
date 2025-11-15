import axios from 'axios'

const apiClient = axios.create({
  baseURL: '/api',
  timeout: 30000,
  headers: {
    'Content-Type': 'application/json'
  }
})

// Request interceptor
apiClient.interceptors.request.use(
  (config) => {
    return config
  },
  (error) => {
    return Promise.reject(error)
  }
)

// Response interceptor
apiClient.interceptors.response.use(
  (response) => {
    return response
  },
  (error) => {
    if (error.response) {
      console.error('API Error:', error.response.data)
    } else if (error.request) {
      console.error('Network Error:', error.request)
    } else {
      console.error('Error:', error.message)
    }
    return Promise.reject(error)
  }
)

export default apiClient

// API methods
export const api = {
  // User stats
  getUserStats: () => apiClient.get('/user/stats'),

  // Algorithm arenas
  getArenas: () => apiClient.get('/arenas'),
  getArenaProblems: (arenaName) => apiClient.get(`/arenas/${arenaName}/problems`),
  getProblem: (problemId) => apiClient.get(`/problems/${problemId}`),
  submitSolution: (problemId, data) => apiClient.post(`/problems/${problemId}/submit`, data),
  getHint: (problemId, hintLevel) => apiClient.post(`/problems/${problemId}/hints/${hintLevel}`),
  teachMe: (problemId) => apiClient.post(`/problems/${problemId}/teach`),

  // SQL
  getSqlProblems: () => apiClient.get('/sql/problems'),
  submitSql: (problemId, query) => apiClient.post(`/sql/${problemId}/submit`, { query }),

  // JPA
  getJpaProblems: () => apiClient.get('/jpa/problems'),
  submitJpa: (problemId, code) => apiClient.post(`/jpa/${problemId}/submit`, { code }),

  // System Design
  getSystemDesignProblems: () => apiClient.get('/system-design/problems'),
  submitSystemDesign: (problemId, design) => apiClient.post(`/system-design/${problemId}/submit`, { design }),

  // MCQ
  getMcqQuestions: () => apiClient.get('/mcq/questions'),
  submitMcq: (questionId, answerId) => apiClient.post(`/mcq/${questionId}/submit`, { answerId }),

  // Progress
  getDailyGoals: () => apiClient.get('/progress/daily-goals'),
  getBadges: () => apiClient.get('/progress/badges'),
}
