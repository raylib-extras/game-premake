
baseName = path.getbasename(os.getcwd());

project (baseName)
    kind "ConsoleApp"
    location "../_build"
    targetdir "../_bin/%{cfg.buildcfg}"

    vpaths 
    {
        ["Header Files/*"] = { "**.h"},
        ["Source Files/*"] = {"**.c", "**.cpp"},
    }
    files {"**.c", "**.cpp", "**.h"}

    includedirs { "./"}
	link_raylib();