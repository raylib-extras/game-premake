
baseName = path.getbasename(os.getcwd());

project (workspaceName)
  	kind "ConsoleApp"
    location "../_build"
    targetdir "../_bin/%{cfg.buildcfg}"
	
    filter "configurations:Release"
		kind "WindowedApp"
		entrypoint "mainCRTStartup"

	filter "action:vs*"
        debugdir "$(SolutionDir)"
		
	filter {"action:vs*", "configurations:Release"}
			kind "WindowedApp"
			entrypoint "mainCRTStartup"
	filter {}
	
    vpaths 
    {
        ["Header Files/*"] = { "src/**.h", "**.h"},
        ["Source Files/*"] = {"src/**.c", "src/**.cpp","**.c", "**.cpp"},
    }
    files {"**.c", "**.cpp", "**.h"}

    includedirs { "./", "src"}
	link_raylib();
	
	-- To link to a lib use link_to("LIB_FOLDER_NAME")