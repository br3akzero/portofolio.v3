import { defineConfig } from 'vite'
import { resolve } from 'path'

export default defineConfig({
  appType: 'mpa',
  server: {
    open: true,
  },
  plugins: [
    {
      name: 'rewrite-clean-urls',
      configureServer(server) {
        server.middlewares.use((req, _res, next) => {
          const url = req.url || ''

          // Handle /blog -> /blog/index.html
          if (url === '/blog' || url === '/blog/') {
            req.url = '/blog/index.html'
          }
          // Handle /blog/post-name -> /blog/post-name.html
          else if (url.startsWith('/blog/') && !url.endsWith('.html') && !url.includes('.')) {
            req.url = url + '.html'
          }
          // Handle /projects -> /projects.html
          else if (url === '/projects' || url === '/projects/') {
            req.url = '/projects.html'
          }

          next()
        })
      },
    },
  ],
  root: 'src',
  build: {
    outDir: '../dist',
    rollupOptions: {
      input: {
        main: resolve(__dirname, 'src/index.html'),
        projects: resolve(__dirname, 'src/projects.html'),
        blog: resolve(__dirname, 'src/blog/index.html'),
        'blog-spyscope': resolve(__dirname, 'src/blog/spyscope.html'),
        'blog-update-2025': resolve(__dirname, 'src/blog/update-2025.html'),
        'blog-hello-world': resolve(__dirname, 'src/blog/hello-world.html'),
        'blog-open-sesame': resolve(__dirname, 'src/blog/open-sesame.html'),
        'blog-spm-publish': resolve(__dirname, 'src/blog/spm-publish.html'),
        'blog-react-native-modules': resolve(__dirname, 'src/blog/react-native-modules.html'),
        'blog-web3-nextjs': resolve(__dirname, 'src/blog/web3-nextjs.html'),
      },
    },
  },
  publicDir: '../public',
})
