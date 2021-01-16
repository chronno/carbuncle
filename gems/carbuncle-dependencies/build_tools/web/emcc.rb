module Carbuncle
    module Web
      class Emscripten < Carbuncle::Build
        def type
          'Web using Emscripten'
        end
  
        def general_cmake_flags
          return ['-G', '"MinGW Makefiles"'] if /mingw/i.match?(RUBY_PLATFORM)
  
          super
        end
  
        def libraries
          %w[
            raylib freetype physfs tmx soloud
          ]
        end
  
        def toolchain_name
          'emcc'
        end
  
        def soloud_cmake_flags
          [
            '-DSOLOUD_BACKEND_SDL2=OFF',
            '-DSOLOUD_BACKEND_WINMM=ON'
          ]
        end
      end
    end
  end
  