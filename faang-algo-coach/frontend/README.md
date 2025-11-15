# FAANG Algo Coach Frontend

A gamified Vue 3 + Vite + TailwindCSS frontend for mastering FAANG-level algorithms, SQL, JPA, and system design.

## Features

- **Gamification**: WP (Wisdom Points), XP, levels, streaks, and badges
- **10 Algorithm Arenas**: Arrays, Strings, Linked Lists, Stacks/Queues, Trees, Graphs, DP, Backtracking, Greedy, Binary Search
- **SQL Practice**: Interactive SQL query editor with validation
- **JPA Practice**: Hibernate and ORM challenges
- **System Design**: Architecture design with multi-section editor
- **MCQ Quiz**: Multiple-choice questions with instant feedback
- **Progressive Hints**: Unlock hints with WP
- **Code Editor**: Built-in code editor with syntax highlighting
- **Responsive Design**: Mobile-friendly layout
- **Offline-First**: All assets bundled locally

## Tech Stack

- **Vue 3** - Progressive JavaScript framework
- **Vite** - Next-generation frontend tooling
- **Vue Router** - Official router for Vue.js
- **Pinia** - State management for Vue
- **TailwindCSS** - Utility-first CSS framework
- **Axios** - HTTP client for API calls

## Project Structure

```
frontend/
├── index.html                 # Entry point
├── package.json               # Dependencies
├── vite.config.js            # Vite configuration
├── tailwind.config.js        # Tailwind configuration
├── postcss.config.js         # PostCSS configuration
└── src/
    ├── main.js               # Vue app initialization
    ├── App.vue               # Root component
    ├── router/
    │   └── index.js          # Route definitions
    ├── stores/
    │   └── userStore.js      # Pinia store for user state
    ├── api/
    │   └── client.js         # Axios client and API methods
    ├── components/
    │   ├── AppHeader.vue     # Global header with stats
    │   ├── ArenaCard.vue     # Algorithm arena card
    │   ├── CodeEditor.vue    # Code editor component
    │   ├── HintPanel.vue     # Progressive hints panel
    │   └── ProblemView.vue   # Problem description view
    ├── views/
    │   ├── DashboardView.vue      # Main dashboard
    │   ├── AlgoArenaView.vue      # Algorithm practice
    │   ├── SqlView.vue            # SQL practice
    │   ├── JpaView.vue            # JPA practice
    │   ├── SystemDesignView.vue   # System design
    │   └── McqView.vue            # MCQ quiz
    └── assets/
        └── styles/
            └── main.css      # Tailwind imports and custom styles
```

## Setup Instructions

### Prerequisites

- Node.js 18+ and npm

### Installation

1. Navigate to the frontend directory:
   ```bash
   cd faang-algo-coach/frontend
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Start development server:
   ```bash
   npm run dev
   ```

4. Open your browser and visit:
   ```
   http://localhost:5173
   ```

### Build for Production

```bash
npm run build
```

The built files will be in the `dist/` directory.

### Preview Production Build

```bash
npm run preview
```

## Routes

- `/` - Dashboard with all arenas and stats
- `/arena/:arenaName` - Algorithm practice for specific arena
- `/sql` - SQL practice
- `/jpa` - JPA practice
- `/system-design` - System design challenges
- `/mcq` - MCQ quiz

## API Integration

The frontend proxies API requests to the backend service:

- Development: `/api` → `http://backend-service:8080`
- Configured in `vite.config.js`

## State Management

User state is managed with Pinia (`stores/userStore.js`):

- **WP (Wisdom Points)**: Currency for unlocking hints
- **XP**: Experience points for leveling up
- **Level**: User's current level
- **Streak**: Days of consecutive practice
- **Completed Problems**: Total problems solved
- **Daily Goals**: Progress toward daily targets

## Gamification System

- **Earn WP**: Solve problems, complete challenges
- **Spend WP**: Unlock hints, get full solutions
- **Earn XP**: Solve problems, level up gets bonus WP
- **Streak**: Maintain daily practice for bonuses
- **Badges**: Unlock achievements
- **Progress Rings**: Visual progress indicators on arena cards

## Customization

### Colors

Edit `tailwind.config.js` to customize the color scheme:

```javascript
theme: {
  extend: {
    colors: {
      primary: { /* your colors */ },
      success: '#10b981',
      warning: '#f59e0b',
      danger: '#ef4444',
    }
  }
}
```

### API Endpoint

Change backend URL in `vite.config.js`:

```javascript
proxy: {
  '/api': {
    target: 'http://your-backend-url',
    changeOrigin: true,
  }
}
```

## Development Notes

- All components use Composition API with `<script setup>`
- Responsive design with Tailwind breakpoints (sm, md, lg)
- Error handling with try-catch and fallback to mock data
- Local storage for saving drafts (System Design)
- Debounced API calls where appropriate

## Browser Support

- Chrome (latest)
- Firefox (latest)
- Safari (latest)
- Edge (latest)

## License

MIT
