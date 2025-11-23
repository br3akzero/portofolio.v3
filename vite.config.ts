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
  build: {
    rollupOptions: {
      input: {
        main: resolve(__dirname, 'index.html'),
        projects: resolve(__dirname, 'projects.html'),
        blog: resolve(__dirname, 'blog/index.html'),
        'blog-hello-world': resolve(__dirname, 'blog/hello-world.html'),
        'blog-open-sesame': resolve(__dirname, 'blog/open-sesame.html'),
        'blog-spm-publish': resolve(__dirname, 'blog/spm-publish.html'),
        'blog-react-native-modules': resolve(__dirname, 'blog/react-native-modules.html'),
        'blog-web3-nextjs': resolve(__dirname, 'blog/web3-nextjs.html'),
      },
    },
  },
})
