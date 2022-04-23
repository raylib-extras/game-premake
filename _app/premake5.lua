
baseName = path.getbasename(os.getcwd());

project (baseName)
    kind "ConsoleApp"
    location "../_build"
    targetdir "../_bin/%{cfg.buildcfg}"

	filter "action:vs*"
        debugdir "$(SolutionDir)"
	filter {}
	
    vpaths 
    {
        ["Header Files/*"] = { "**.h"},
        ["Source Files/*"] = {"**.c", "**.cpp"},
    }
    files {"**.c", "**.cpp", "**.h"}

    includedirs { "./"}
	link_raylib();