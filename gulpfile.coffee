'use strict'

gulp = require 'gulp'
clean = require 'gulp-clean'
browserSync = require 'browser-sync'
browserify = require 'browserify'
imagemin = require 'gulp-imagemin'

gulp.task 'build', ['clean', 'scripts', 'images'], ->
  gulp.src ['app/index.html']
    .pipe gulp.dest 'build'

gulp.task 'clean', ->
  gulp.src ['build'], read: false
    .pipe clean force: true

gulp.task 'browser-sync', ->
  browserSync
    files: './build/**/*'
    server:
      baseDir: './build'

gulp.task 'scripts', ->
  browserify './app/scripts/main.coffee', debug: true
  .transform 'jstify',
    templateOpts: interpolate: /\{\{(.+?)\}\}/g
  .transform 'coffeeify'
  .transform 'debowerify'
  .transform global: true, 'uglifyify'
  .bundle()
  .pipe source 'main.js'
  .pipe gulp.dest 'build/scripts'

gulp.task 'images', ->
  gulp.src ['app/images/*.jpg', 'app/images/*.png']
    .pipe imagemin
      optimizationLeven: 3
      progressive: true
      interlaced: true
    .pipe gulp.dest 'build/images'

gulp.task 'default', ['build']

gulp.task 'serve', ['build', 'browser-sync'], ->
  gulp.watch ['./app/scripts/*.coffee', './app/templates/*.html'], ['scripts']
  gulp.watch ['./app/images/*.jpg', './app/images/*.png'], ['images']
