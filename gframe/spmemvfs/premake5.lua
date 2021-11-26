project "cspmemvfs"
    kind "StaticLib"
    files { "*.c", "*.h" }

    filter "system:windows"
        includedirs { "../../sqlite3" }
