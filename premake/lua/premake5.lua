project "lua"
    kind "StaticLib"

    files { "*.c", "*.h", "*.hpp" }
    removefiles { "lua.c", "luac.c" }

    filter "action:vs*"	
        buildoptions { "/TP" }

    filter "not action:vs*"	
        buildoptions { "-x c++" }