
baseName = path.getbasename(os.getcwd());

project (baseName)
    kind "StaticLib"
    location "../_build"
    targetdir "../_bin/%{cfg.buildcfg}"
    includedirs { "./", "./include"}

    vpaths 
    {
        ["Header Files/*"] = { "**.h"},
        ["Source Files/*"] = { "**.cpp","**.c"},
    }
    files {"**.h", "**.cpp","**.c"}
	
	include_raylib()