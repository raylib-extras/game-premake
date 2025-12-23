-- Game Premake by Jeffery Myers is marked CC0 1.0. To view a copy of this mark, visit https://creativecommons.org/publicdomain/zero/1.0/

baseName = path.getbasename(os.getcwd());

project (workspaceName)
    kind "ConsoleApp"
    location "./"
    targetdir "../bin/%{cfg.buildcfg}"

    filter "action:vs*"
        debugdir "$(SolutionDir)"

    filter {"action:vs*", "configurations:Release"}
        kind "WindowedApp"
        entrypoint "mainCRTStartup"

    filter{}

    vpaths 
    {
        ["Header Files/*"] = { "include/**.h",  "include/**.hpp", "src/**.h", "src/**.hpp", "**.h", "**.hpp"},
        ["Source Files/*"] = {"src/**.c", "src/**.cpp","**.c", "**.cpp"},
        ["Application Resource Files/*"] = {"src/**.rc", "src/**.ico"},
    }
    files {"**.c", "**.cpp", "**.h", "**.hpp"}

    filter "system:windows"
        files {"src/**.rc", "src/**.ico"}
        resincludedirs { "src/**" }
    filter{}

    filter "files:**.ico"
        buildaction "Embed"

    filter{}

  
    includedirs { "./" }
    includedirs { "src" }
    includedirs { "include" }
    
    link_raylib()
    link_to("staticLib")
-- To link to a lib use link_to("LIB_FOLDER_NAME")