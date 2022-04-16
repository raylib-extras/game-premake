
baseName = path.getbasename(os.getcwd());

project (baseName)
    kind "ConsoleApp"
    location "../build"
    targetdir "../bin/%{cfg.buildcfg}"

    vpaths 
    {
        ["Header Files/*"] = { "**.h"},
        ["Source Files/*"] = {"**.c", "**.cpp"},
    }
    files {"**.c", "**.cpp", "**.h"}

    includedirs { "./"}
	setup_raylib();