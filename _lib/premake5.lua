
baseName = path.getbasename(os.getcwd());

project (baseName)
    kind "StaticLib"
    location "../_build"
    targetdir "../_bin/%{cfg.buildcfg}"

    vpaths 
    {
        ["Header Files/*"] = { "include/**.h", "include/**.hpp", "**.h", "**.hpp"},
        ["Source Files/*"] = { "src/**.cpp", "src/**.c", "**.cpp","**.c"},
    }
    files {"**.hpp", "**.h", "**.cpp","**.c"}

    includedirs { "./" }
    includedirs { "./include" }
	
	include_raylib()