Clear-Host
Write-Host @"
     ____ ___ _ __     _______ ____    ____    _  _____ ____ _   _
    / ___|_ _| |\ \   / / ____|  _ \  | __ )  / \|_   _/ ___| | | |
    \___ \| || | \ \ / /|  _| | |_) | |  _ \ / _ \ | || |   | |_| |
     ___) | || |__\ V / | |___|  _ <  | |_) / ___ \| || |___|  _  |
    |____/___|_____\_/  |_____|_| \_\ |____/_/   \_\_| \____|_| |_|
"@
Write-Host ""
Write-Host "`nLancement du script...`n"
Start-Sleep -Seconds 2
Clear-Host



$project_name = Read-Host "Nom du projet"
$project_path = Read-Host "Chemin du dossier dans laquelle le projet se trouvera"

Set-Location $project_path

Write-Host "`nInitialisation...`n"
Write-Host "Veuillez bien choisir vue pour la compatibilite avec vue-router.`n`n"
Read-Host "(Appuyez sur Entree pour continuer)"

npm create vite@latest $project_name -- --template vue-ts
Set-Location "$project_path\$project_name"

npm install
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p

# Fichier style.css
@"
@tailwind base;
@tailwind components;
@tailwind utilities;
"@ | Set-Content -Path "src/style.css"

npm install vue-router

# Router
New-Item -ItemType Directory -Path "src/router" -Force
@"
import { createRouter, createWebHistory } from 'vue-router'
import Home from '../views/Home.vue'

const routes = [
  { path: '/', name: 'Home', component: Home },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

export default router
"@ | Set-Content -Path "src/router/index.ts"

# Vue Home
New-Item -ItemType Directory -Path "src/views" -Force
@"
<template>
  <div class='p-4'>
    <h1 class='text-3xl font-bold text-blue-600'>
      Bienvenue sur ta plateforme vite + vue en TypeScript + tailwindcss !
    </h1>
  </div>
</template>
"@ | Set-Content -Path "src/views/Home.vue"

# Supprimer les fichiers inutiles
Remove-Item -Path "src/components/HelloWorld.vue" -Force -ErrorAction SilentlyContinue
Remove-Item -Path "src/App.vue" -Force -ErrorAction SilentlyContinue

# Creer components/Footer.vue
New-Item -ItemType Directory -Path "src/components" -Force
@"
<template>
    footer
</template>

<script setup lang='ts'>

</script>

<style lang='css' scoped>

</style>
"@ | Set-Content -Path "src/components/Footer.vue"

# Creer components/Navbar.vue
@"
<template lang='html'>
    navbar
</template>

<script setup lang='ts'>

</script>

<style lang='css' scoped>

</style>
"@ | Set-Content -Path "src/components/Navbar.vue"

# Creer un nouveau App.vue
@"
<script setup lang='ts'>
  import Navbar from './components/Navbar.vue';
  import Footer from './components/Footer.vue';
</script>

<template>
  <Navbar />
  <router-view></router-view>
  <Footer />
</template>

<style scoped>

</style>
"@ | Set-Content -Path "src/App.vue"

# main.ts
@"
import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import './style.css'

const app = createApp(App)
app.use(router)
app.mount('#app')
"@ | Set-Content -Path "src/main.ts"

Write-Host "`nProjet '$project_name' pret !"
Write-Host "`nPour lancer le projet :"
Write-Host "cd $project_name"
Write-Host "npm run dev"

