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


Write-Host @"
     ____ ___ _ __     _______ ____    ____    _  _____ ____ _   _
    / ___|_ _| |\ \   / / ____|  _ \  | __ )  / \|_   _/ ___| | | |
    \___ \| || | \ \ / /|  _| | |_) | |  _ \ / _ \ | || |   | |_| |
     ___) | || |__\ V / | |___|  _ <  | |_) / ___ \| || |___|  _  |
    |____/___|_____\_/  |_____|_| \_\ |____/_/   \_\_| \____|_| |_|
"@
Write-Host ""
Write-Host ""

Write-Host "Le chemin d'access ne dois pas se finir par un / ou un \ !"
Write-Host ""

$project_name = Read-Host "Nom du projet"
$project_path = Read-Host "Chemin du dossier dans laquelle le projet se trouvera"

Set-Location $project_path

Write-Host "`nInitialisation...`n"
Write-Host "Veuillez bien choisir vue pour la compatibilite avec vue-router.`n`n"
Read-Host "(Appuyez sur Entree pour continuer)"

npm create vite@latest $project_name -- --template vue-ts
Set-Location "$project_path\$project_name"

# Installer les dépendances
npm install
npm install -D tailwindcss @tailwindcss/vite postcss autoprefixer

# Configuration de vite.config.ts pour inclure le plugin Tailwind CSS
@"
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import tailwindcss from '@tailwindcss/vite'

// https://vite.dev/config/
export default defineConfig({
  plugins: [
    vue(),
    tailwindcss(),
  ],
})
"@ | Set-Content -Path "vite.config.ts"

# ajout des credits dans index.html
@"
<!-- projet initialisé avec silverbatch => https://www.silvercore.fr -->
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <link rel="icon" type="image/svg+xml" href="/vite.svg" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title></title>
  </head>
  <body>
    <div id="app"></div>
    <script type="module" src="/src/main.ts"></script>
  </body>
</html>
"@ | Set-Content -Path "index.html"

# Fichier style.css avec importation de Tailwind CSS
@"
@import 'tailwindcss';
"@ | Set-Content -Path "src/style.css"

npm install vue-router

# Router
@"
import { createRouter, createWebHistory } from 'vue-router'
import Home from './views/Home.vue'

const routes = [
  { path: '/', name: 'Home', component: Home },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

export default router
"@ | Set-Content -Path "src/router.ts"

# Vue Home
New-Item -ItemType Directory -Path "src/views" -Force
@"
<template>
  <div class='p-4 flex justify-center items-center bg-gray-100' style="height: 76vh;">
    <h1 class='text-2xl font-bold text-blue-600'>
      Bienvenue sur ta plateforme vite + vue en TypeScript + tailwindcss !
    </h1>
  </div>
</template>

<script setup lang="ts">

</script>

<style scoped>

</style>

"@ | Set-Content -Path "src/views/Home.vue"

# Supprimer les fichiers inutiles
Remove-Item -Path "src/components/HelloWorld.vue" -Force -ErrorAction SilentlyContinue
Remove-Item -Path "src/App.vue" -Force -ErrorAction SilentlyContinue

# Creer components/Footer.vue
New-Item -ItemType Directory -Path "src/components" -Force
@"
<template>
    <footer class="bg-gray-800 text-white py-8">
      <div class="container mx-auto text-center">
        <!-- Texte du footer -->
        <p class="text-sm">© 2025 MonSite. Tous droits réservés.</p>
  
        <!-- Liens du footer -->
        <div class="mt-4">
          <a href="/privacy" class="text-white hover:text-gray-400 mx-2">Politique de confidentialité</a>
          <a href="/terms" class="text-white hover:text-gray-400 mx-2">Conditions d'utilisation</a>
          <a href="/contact" class="text-white hover:text-gray-400 mx-2">Contact</a>
        </div>
  
        <!-- Réseaux sociaux -->
        <div class="mt-4">
          <a href="https://facebook.com" target="_blank" class="text-white hover:text-gray-400 mx-2">
            <svg class="w-6 h-6 inline-block" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 2c-2.21 0-4 1.79-4 4 0 1.1.4 2.1 1.04 2.83l-1.72.94c-.35-.58-.93-1.04-1.63-1.21l-.43-.07c-.79 0-1.5.5-1.77 1.22l-1.03.35c-.12-.39-.18-.81-.18-1.26 0-2.21 1.79-4 4-4s4 1.79 4 4c0 .45-.07.87-.18 1.26l-1.03-.35c-.27-.72-.98-1.22-1.77-1.22l-.43.07c-.7.17-1.28.63-1.63 1.21l-1.72-.94C14.4 8.1 14 7.1 14 6c0-2.21 1.79-4 4-4z"></path>
            </svg>
          </a>
          <a href="https://twitter.com" target="_blank" class="text-white hover:text-gray-400 mx-2">
            <svg class="w-6 h-6 inline-block" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M23 3a10.1 10.1 0 0 1-2.828 1.07A4.75 4.75 0 0 0 22.5 1.5a9.47 9.47 0 0 1-3.001 1.147A4.738 4.738 0 0 0 16.46.5a4.63 4.63 0 0 0-4.612 4.551c0 .364.032.722.095 1.062C7.724 5.928 4.1 3.9 1.64 1.225a4.688 4.688 0 0 0-.626 2.331c0 1.613.824 3.045 2.076 3.873a4.693 4.693 0 0 1-2.118-.587v.06c0 2.246 1.597 4.137 3.728 4.575a4.615 4.615 0 0 1-2.106.078c.59 1.78 2.313 3.08 4.341 3.115a9.363 9.363 0 0 1-5.69 1.988c-.369 0-.74-.021-1.105-.062a13.077 13.077 0 0 0 7.02 2.065c8.416 0 13.03-6.976 12.79-13.26a9.07 9.07 0 0 0 2.179-2.33c-.799.35-1.66.58-2.53.74z"></path>
            </svg>
          </a>
        </div>
      </div>
    </footer>
  </template>
  
  <script setup lang="ts">
  // Pas de script nécessaire pour cet exemple de footer
  </script>
  
  <style scoped>
  /* Ajout de styles personnalisés si nécessaire */
  </style>
  
"@ | Set-Content -Path "src/components/Footer.vue"

# Creer components/Navbar.vue
@"
<template>
    <nav class="bg-gray-800 p-4">
      <div class="container mx-auto flex justify-between items-center">
        <!-- Logo ou nom du site -->
        <div class="text-white text-2xl font-bold">
          MonSite
        </div>
  
        <!-- Menu de navigation -->
        <div class="hidden md:flex space-x-6">
          <a href="/" class="text-white hover:text-gray-300">Accueil</a>
          <a href="/about" class="text-white hover:text-gray-300">À propos</a>
          <a href="/services" class="text-white hover:text-gray-300">Services</a>
          <a href="/contact" class="text-white hover:text-gray-300">Contact</a>
        </div>
  
        <!-- Menu hamburger pour mobile -->
        <div class="md:hidden">
          <button @click="toggleMenu" class="text-white">
            <svg class="w-6 h-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path>
            </svg>
          </button>
        </div>
      </div>
  
      <!-- Menu mobile -->
      <div v-if="isMenuOpen" class="md:hidden bg-blue-700 p-4 space-y-4">
        <a href="/" class="text-white hover:text-gray-300 block">Accueil</a>
        <a href="/about" class="text-white hover:text-gray-300 block">À propos</a>
        <a href="/services" class="text-white hover:text-gray-300 block">Services</a>
        <a href="/contact" class="text-white hover:text-gray-300 block">Contact</a>
      </div>
    </nav>
  </template>
  
  <script setup lang="ts">
  import { ref } from 'vue';
  
  const isMenuOpen = ref(false);
  
  const toggleMenu = () => {
    isMenuOpen.value = !isMenuOpen.value;
  };
  </script>
  
  <style scoped>
  /* Styles personnalisés si nécessaire */
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
import router from './router.ts'
import './style.css'

const app = createApp(App)
app.use(router)
app.mount('#app')
"@ | Set-Content -Path "src/main.ts"

Write-Host "`nProjet '$project_name' pret !"
Write-Host "`nPour lancer le projet :"
Write-Host "cd $project_name"
Write-Host "npm run dev"

