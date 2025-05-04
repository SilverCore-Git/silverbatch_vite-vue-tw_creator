Clear-Host
Write-Host "=== Creation projet Vue 3 (JavaScript) sans Tailwind CSS ==="

$project_name = Read-Host "Nom du projet"
$project_path = Read-Host "Chemin complet du dossier parent"

Set-Location $project_path
npm create vite@latest $project_name -- --template vue
Set-Location "$project_path\$project_name"

# Installer les dépendances
npm install

# Ajouter styles personnalisés
"/* Styles personnalisés ici */" | Set-Content "src/style.css"

# Installer Vue Router
npm install vue-router

# Crée les fichiers JS
@"
import { createRouter, createWebHistory } from 'vue-router'
import Home from './views/Home.vue'

const routes = [
  { path: '/', name: 'Home', component: Home, meta: { title: 'Accueil' } }
]

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes,
})

router.beforeEach((to, from, next) => {
  const title = to.meta.title;
  if (title) document.title = title;
  next();
})

export default router;
"@ | Set-Content -Path "src/router.js"

# Crée les dossiers pour les vues et composants
New-Item -ItemType Directory -Path "src/views" -Force
New-Item -ItemType Directory -Path "src/components" -Force

# Home.vue
@"
<template>
  <div class=''>
    <h1 class=''>
      Projet Vue + TypeScript prêt !
    </h1>
  </div>
</template>

<script setup lang='ts'>
</script>
"@ | Set-Content -Path "src/views/Home.vue"

# Composants Navbar et Footer
foreach ($component in @("Navbar", "Footer")) {
  $html = if ($component -eq "Navbar") {
    "<nav class='bg-blue-600 text-white p-4'>
      <h1 class='text-xl font-semibold'>Le Rive Gauche</h1>
    </nav>"
  } else {
    "<footer class='bg-gray-800 text-white text-center p-4'>
      <p>&copy; 2025 Le Rive Gauche</p>
    </footer>"
  }

  $html = $html -replace " class='[^']*'", ""  # Enlève les classes Tailwind si non utilisé

  @"
<template>
  $html
</template>

<script setup>
</script>
"@ | Set-Content -Path "src/components/$component.vue"
}

# App.vue
@"
<script setup>
import Navbar from './components/Navbar.vue'
import Footer from './components/Footer.vue'
</script>

<template>
  <Navbar />
  <router-view />
  <Footer />
</template>
"@ | Set-Content -Path "src/App.vue"

# main.js
@"
import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import './style.css'

const app = createApp(App)
app.use(router)
app.mount('#app')
"@ | Set-Content -Path "src/main.js"

Write-Host "`nProjet '$project_name' (JavaScript) généré avec succès !"

