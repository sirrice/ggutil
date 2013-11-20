# => SRC FOLDER
#
toast
  folders:
    'src/util': 'util'

  # EXCLUDED FOLDERS (optional)
  exclude: [
  ]

  # => VENDORS (optional)
  vendors: [
    #'vendor/js/d3.min.js',
    #'vendor/js/jquery.min.js',
    'vendor/js/json2.js',
    'vendor/js/underscore.min.js'
  ]


  # => OPTIONS (optional, default values listed)
  # bare: false
  #packaging: false
  #expose: 'window'
  minify: false

  # => HTTPFOLDER (optional), RELEASE / DEBUG (required)
  httpfolder: '../js/'
  release: 'build/compiled/ggutil.js'
  debug: 'build/compiled/ggutil-debug.js'



