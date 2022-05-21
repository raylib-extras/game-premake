
baseName = path.getbasename(os.getcwd());

project (baseName)
    kind "ConsoleApp"
    location "../_build"
    targetdir "../_bin/%{cfg.buildcfg}"

    filter "action:vs*"
        debugdir "$(SolutionDir)"
		
	filter {"action:vs*", "configurations:Release"}
		kind "WindowedApp"
		entrypoint "mainCRTStartup"
		
    filter{}

    vpaths
    {
        ["Header Files/*"] = { "**.h"},
        ["Source Files/*"] = {"**.c", "**.cpp"},
    }
    files {"**.c", "**.cpp", "**.h"}

    includedirs { "./"}
    link_raylib();
	
	-- To link to a lib use link_to("LIB_FOLDER_NAME")