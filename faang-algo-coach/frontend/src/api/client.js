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
  // User endpoints
  getUserStatus: () => apiClient.get('/user/status'),
  resetUser: () => apiClient.post('/user/reset'),

  // Problem endpoints
  getProblem: (problemId, userId = 1) => apiClient.get(`/problems/${problemId}?userId=${userId}`),
  getProblemsByCategory: (category, userId = 1) => apiClient.get(`/problems/category/${category}?userId=${userId}`),
  getProblemsByModule: (moduleType, userId = 1) => apiClient.get(`/problems/module/${moduleType}?userId=${userId}`),
  getProblemsByArena: (arena, userId = 1) => apiClient.get(`/problems/arena/${arena}?userId=${userId}`),
  getNextProblem: (moduleType, userId = 1) => apiClient.get(`/problems/next/${moduleType}?userId=${userId}`),
  getSolvedProblems: (category, userId = 1) => apiClient.get(`/problems/solved/${category}?userId=${userId}`),

  // Submission endpoints
  submitAlgo: (data) => apiClient.post('/submit/algo', data),
  submitKnowledge: (data) => apiClient.post('/submit/knowledge', data),
  getHint: (problemId) => apiClient.post(`/hint/${problemId}`),
  teachMe: (problemId) => apiClient.post(`/teach/${problemId}`),

  // Convenience methods for specific module types
  getAlgoProblems: (arena, userId = 1) => apiClient.get(`/problems/arena/${arena}?userId=${userId}`),
  getArenaProblems: (arena, userId = 1) => apiClient.get(`/problems/arena/${arena}?userId=${userId}`),
  getSqlProblems: (userId = 1) => apiClient.get(`/problems/module/SQL?userId=${userId}`),
  getJpaProblems: (userId = 1) => apiClient.get(`/problems/module/JPA?userId=${userId}`),
  getSystemDesignProblems: (userId = 1) => apiClient.get(`/problems/module/SYS_DESIGN?userId=${userId}`),
  getMcqProblems: (userId = 1) => apiClient.get(`/problems/module/MCQ?userId=${userId}`),
  getMcqQuestions: (userId = 1) => apiClient.get(`/problems/module/MCQ?userId=${userId}`),
}
