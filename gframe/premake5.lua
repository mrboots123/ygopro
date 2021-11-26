include "lzma/."
include "spmemvfs/."

project "ygopro"
    kind "WindowedApp"

    files { "*.cpp", "*.h" }
    includedirs { "../ocgcore" }
    links { "ocgcore", "clzma", "cspmemvfs", "irrlicht", "freetype", "sqlite3", "event" }

    filter "system:windows"
        files "ygopro.rc"
        --excludes "CGUIButton.cpp"
        includedirs { "../irrlicht/include", "../freetype/include", "../event/include", "../sqlite3" }
        links { "lua" }
        if USE_IRRKLANG then
            defines { "YGOPRO_USE_IRRKLANG" }
            links { "irrKlang" }
            includedirs { "../irrklang/include" }
            if IRRKLANG_PRO then
                defines { "IRRKLANG_STATIC" }
                links { "ikpmp3" }
            else
                libdirs { "../irrklang/lib/Win32-visualStudio" }
            end
        end
        links { "opengl32", "ws2_32", "winmm", "gdi32", "kernel32", "user32", "imm32" }
    if IRRKLANG_PRO then
        filter { "system:windows", "not configurations:Debug" }
            libdirs { "../irrklang/lib/Win32-vs2019" }
        filter { "system:windows", "configurations:Debug" }
            libdirs { "../irrklang/lib/Win32-visualStudio-debug" }
    end
    filter { "system:windows", "not action:vs*"}
        includedirs { "/mingw/include/irrlicht", "/mingw/include/freetype2" }
    filter "not action:vs*"
        buildoptions { "-std=c++14", "-fno-rtti" }
    filter "not system:windows"
        includedirs { "/usr/include/irrlicht", "/usr/include/freetype2" }
        excludes { "COSOperator.*" }
        links { "lua5.3-c++", "event_pthreads", "GL", "dl", "pthread" }
    filter "system:linux"
        if USE_IRRKLANG then
            defines { "YGOPRO_USE_IRRKLANG" }
            links { "IrrKlang" }
            linkoptions{ "-Wl,-rpath=./irrklang/bin/linux-gcc-64/" }
            libdirs { "../irrklang/bin/linux-gcc-64" }
            includedirs { "../irrklang/include" }
        end
