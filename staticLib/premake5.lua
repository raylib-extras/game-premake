-- Game Premake by Jeffery Myers is marked CC0 1.0. To view a copy of this mark, visit https://creativecommons.org/publicdomain/zero/1.0/

baseName = path.getbasename(os.getcwd());

project (baseName)
    kind "StaticLib"
    location "./"
    targetdir "../bin/%{cfg.buildcfg}"

    vpaths 
    {
        ["Header Files/*"] = { "include/**.h", "include/**.hpp", "**.h", "**.hpp"},
        ["Source Files/*"] = { "src/**.cpp", "src/**.c", "**.cpp","**.c"},
    }
    files {"**.hpp", "**.h", "**.cpp","**.c"}

    includedirs { "./" }
    includedirs { "./src" }
    includedirs { "./include" }

    include_raylib()