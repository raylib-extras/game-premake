
baseName = path.getbasename(os.getcwd());

project (workspaceName)
    kind "ConsoleApp"
    location "../_build"
    targetdir "../_bin/%{cfg.buildcfg}"

	filter "action:vs*"
        debugdir "$(SolutionDir)"
	filter {}
	
    vpaths 
    {
        ["Header Files/*"] = { "src/**.h", "**.h"},
        ["Source Files/*"] = {"src/**.c", "src/**.cpp","**.c", "**.cpp"},
    }
    files {"**.c", "**.cpp", "**.h"}

    includedirs { "./", "src"}
	link_raylib();