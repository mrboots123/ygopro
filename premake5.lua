workspace "YGOPro"
    location "build"
    language "C++"
    objdir "obj"

    USE_IRRKLANG = true
    IRRKLANG_PRO = true

    configurations { "Release", "Debug" }

    filter "system:windows"
        defines { "WIN32", "_WIN32", "WINVER=0x0501", "_IRR_WCHAR_FILESYSTEM" }
        libdirs { "$(DXSDK_DIR)Lib/x86" }
        entrypoint "mainCRTStartup"
        systemversion "latest"
        startproject "ygopro"

    filter "action:vs2015"
        toolset "v140_xp"

    filter "action:vs2017"
        toolset "v141_xp"

    filter "action:vs2019"
        toolset "v141_xp"

    filter "system:bsd"
        defines { "LUA_USE_POSIX" }
        includedirs { "/usr/local/include" }
        libdirs { "/usr/local/lib" }

    filter "system:macosx"
        defines { "LUA_USE_MACOSX" }
        includedirs { "/usr/local/include", "/usr/local/include/*" }
        libdirs { "/usr/local/lib", "/usr/X11/lib" }
        buildoptions { "-stdlib=libc++" }
        links { "OpenGL.framework", "Cocoa.framework", "IOKit.framework" }

    filter "system:linux"
        defines { "LUA_USE_LINUX" }
        buildoptions { "-U_FORTIFY_SOURCE" }

    filter "configurations:Release"
        optimize "Speed"
        targetdir "bin/release"

    filter "configurations:Debug"
        symbols "On"
        defines "_DEBUG"
        targetdir "bin/debug"

    filter { "configurations:Release", "action:vs*" }
        flags { "LinkTimeOptimization" }
        staticruntime "On"
        disablewarnings { "4244", "4267", "4838", "4577", "4819", "4018", "4996", "4477", "4091", "4828", "4800" }

    filter { "configurations:Release", "not action:vs*" }
        symbols "On"
        defines "NDEBUG"
        buildoptions "-march=native"

    filter { "configurations:Debug", "action:vs*" }
        defines { "_ITERATOR_DEBUG_LEVEL=0" }
        disablewarnings { "4819", "4828" }

    filter "action:vs*"
        vectorextensions "SSE2"
        buildoptions { "/utf-8" }
        defines { "_CRT_SECURE_NO_WARNINGS" }
    
    filter "not action:vs*"
        buildoptions { "-fno-strict-aliasing", "-Wno-multichar" }

    filter {"not action:vs*", "system:windows"}
        buildoptions { "-static-libgcc" }

    include "ocgcore"
    include "gframe"
    if os.ishost("windows") then
		include "lua"
		include "event"
		include "freetype"
		include "irrlicht"
		include "sqlite3"
		if IRRKLANG_PRO then
			include "ikpmp3"
		end
    end
