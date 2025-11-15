import { createRouter, createWebHistory } from 'vue-router'
import DashboardView from '../views/DashboardView.vue'
import AlgoArenaView from '../views/AlgoArenaView.vue'
import SqlView from '../views/SqlView.vue'
import JpaView from '../views/JpaView.vue'
import SystemDesignView from '../views/SystemDesignView.vue'
import McqView from '../views/McqView.vue'

const routes = [
  {
    path: '/',
    name: 'Dashboard',
    component: DashboardView,
    meta: { title: 'Dashboard - FAANG Algo Coach' }
  },
  {
    path: '/arena/:arenaName',
    name: 'AlgoArena',
    component: AlgoArenaView,
    meta: { title: 'Algorithm Arena - FAANG Algo Coach' }
  },
  {
    path: '/sql',
    name: 'SQL',
    component: SqlView,
    meta: { title: 'SQL Practice - FAANG Algo Coach' }
  },
  {
    path: '/jpa',
    name: 'JPA',
    component: JpaView,
    meta: { title: 'JPA Practice - FAANG Algo Coach' }
  },
  {
    path: '/system-design',
    name: 'SystemDesign',
    component: SystemDesignView,
    meta: { title: 'System Design - FAANG Algo Coach' }
  },
  {
    path: '/mcq',
    name: 'MCQ',
    component: McqView,
    meta: { title: 'MCQ Quiz - FAANG Algo Coach' }
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

router.beforeEach((to, from, next) => {
  document.title = to.meta.title || 'FAANG Algo Coach'
  next()
})

export default router
