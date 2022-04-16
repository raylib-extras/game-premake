
baseName = path.getbasename(os.getcwd());

project (baseName)
    kind "StaticLib"
    location "../build"
    targetdir "../bin/%{cfg.buildcfg}"
    includedirs { "./"}

    vpaths 
    {
        ["Header Files/*"] = { "**.h"},
        ["Source Files/*"] = { "**.cpp"},
    }
    files {"**.h", "**.cpp"}
	
	setup_raylib()