#!/usr/bin/env node
const esbuild = require('esbuild')
const { sassPlugin } = require('esbuild-sass-plugin')

const watchPlugin = {
  name: 'watch-plugin',
  setup(build) {
    build.onStart(() => console.log('Build starting...'))
    build.onEnd((result) => {
      if (result.errors.length > 0) {
        console.log('Build errored.')
        result.errors.forEach((e) => console.log(e))
      } else {
        console.log('Build finished successfully.')
      }
    })
  }
}

esbuild
  .context({
    entryPoints: ['./app/javascript/main.mjs'],
    bundle: true,
    outfile: './app/assets/builds/main.js',
    minify: process.argv.includes('--minify')
  })
  .then((context) => {
    if (process.argv.includes('--watch')) {
      context.watch()
    } else {
      context.rebuild().then(() => {
        context.dispose()
      })
    }
  })
  .catch(() => process.exit(1))
