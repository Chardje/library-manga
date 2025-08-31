// vite.config.js
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  root: './src',
  cacheDir: './node_modules/.vite', 
  server: {
    host: '0.0.0.0',
    port: 8080,
  },
  build: {
    outDir: './dist',
    emptyOutDir: true,
  },
  plugins: [react()],
})
