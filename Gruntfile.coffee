gruntConfig = (grunt) ->
  jsPath = "build/ui/mods/com.someonewhoisnobody.pa.PAUnit"

  grunt.initConfig
    #Install Bower dependencies
    bower:
      install:
        options:
          copy: false

    #Manifest Sync
    manifestSync:
      main:
        options:
          primaryManifest: "manifest.json"

    #Clean directories
    clean:
      build: ["build"]
      javascript: [jsPath]
      libs: ["#{jsPath}/libs"]

    #Copy files
    copy:
      javascript:
        expand: true
        cwd: "src/"
        src: "**/*"
        dest: jsPath
      libs:
        expand: true
        cwd: "libs"
        src: "**/*"
        dest: "#{jsPath}/libs"

    #Watch
    watch:
      javascript:
        files: "src/*"
        tasks: ["buildJavascript"]
      manifest:
        files: "manifest.json"
        tasks: ["buildManifests"]

  #Load Grunt tasks
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-bower-task"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-manifest-sync"

  #Register Grunt tasks
  grunt.registerTask "build", ["clean:build", "buildBower", "buildJavascript", "buildManifests"]

  grunt.registerTask "buildBower", ["clean:libs", "bower:install", "copy:libs"]
  grunt.registerTask "buildJavascript", ["clean:javascript", "copy:javascript"]
  grunt.registerTask "buildManifests", ["manifestSync:main"]

module.exports = gruntConfig
