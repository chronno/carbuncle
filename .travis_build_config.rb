# frozen_string_literal: true

CARBUNCLE_GEMS = %w[
  dependencies support core audio doc-ext graphics
  input math scene gui
].freeze

CORE_GEMS = %w[
  mruby-metaprog mruby-pack mruby-sprintf mruby-print mruby-math
  mruby-time mruby-struct mruby-compar-ext mruby-enum-ext
  mruby-string-ext mruby-numeric-ext mruby-array-ext mruby-hash-ext
  mruby-range-ext mruby-proc-ext mruby-symbol-ext mruby-random
  mruby-object-ext mruby-objectspace mruby-fiber mruby-enumerator
  mruby-enum-lazy mruby-toplevel-ext mruby-rational mruby-complex
  mruby-kernel-ext mruby-class-ext mruby-method mruby-eval
  mruby-compiler
].freeze

def add_core_gems(conf)
  CORE_GEMS.each do |gem|
    conf.gem core: gem
  end
end

def add_external_gems(conf)
  conf.gem github: 'yui-knk/mruby-set'
  conf.gem github: 'iij/mruby-regexp-pcre'
end

def add_carbuncle_gems(conf)
  CARBUNCLE_GEMS.each do |name|
    conf.gem File.join(__dir__, 'gems', "carbuncle-#{name}")
  end
  conf.gem File.join(__dir__, 'gems', 'mruby-bin-carbuncle')
end

MRuby::Build.new do |conf|
  conf.toolchain :gcc

  add_core_gems(conf)
  add_external_gems(conf)
  add_carbuncle_gems(conf)

  if ENV['DEBUG'] == 'true'
    conf.enable_test
    conf.enable_debug
    conf.cc.defines = %w[MRB_ENABLE_DEBUG_HOOK]
    conf.gem core: 'mruby-bin-debugger'
  end
end

# MRuby::CrossBuild.new('win32') do |conf|
#   toolchain :gcc
#   conf.cc.command = 'x86_64-w64-mingw32-gcc'
#   conf.cxx.command = 'x86_64-w64-mingw32-g++'
#   conf.linker.command = 'x86_64-w64-mingw32-gcc'
#   conf.archiver.command = 'x86_64-w64-mingw32-ar'
#   conf.linker.libraries += %w[wsock32 ws2_32]
#   conf.exts.executable = '.exe'
#   conf.cc.flags << '-DPCRE_STATIC'
#   conf.linker.flags += %w[-static-libgcc -static-libstdc++]
#   add_core_gems(conf)
#   add_external_gems(conf)
#   add_carbuncle_gems(conf)
# end

MRuby::CrossBuild.new('emscripten') do |conf|
  toolchain :clang
  conf.gembox 'default'
  conf.cc.command = 'emcc'
  conf.cc.flags = [
    '-s ASYNCIFY=1',
    '-s WASM=0',
    '-s USE_GLFW=3',
    '--use-preload-plugins',
    '-s FORCE_FILESYSTEM=1',
    '-O3'
  ]
  conf.exts.executable = '.html'
  conf.linker.command = 'emcc'
  conf.linker.flags = [
    '-s ASYNCIFY=1',
    '-s WASM=0',
    '-s USE_GLFW=3',
    '--use-preload-plugins',
    '-s FORCE_FILESYSTEM=1',
    '-O3'
  ]
  
  conf.archiver.command = 'emar'
  
  add_core_gems(conf)
  add_external_gems(conf)
  add_carbuncle_gems(conf)
end