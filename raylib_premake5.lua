
function platform_defines()
    filter { "configurations:Release or configurations:Debug"}
        defines{"PLATFORM_DESKTOP"}
        
    filter { "configurations:ReleaseSDL or configurations:DebugSDL"}
        defines{"PLATFORM_DESKTOP_SDL"}

    filter {"options:graphics=opengl43"}
        defines{"GRAPHICS_API_OPENGL_43"}

    filter {"options:graphics=opengl33"}
        defines{"GRAPHICS_API_OPENGL_33"}

    filter {"options:graphics=opengl21"}
        defines{"GRAPHICS_API_OPENGL_21"}

    filter {"options:graphics=opengl11"}
        defines{"GRAPHICS_API_OPENGL_11"}

    filter {"system:macosx"}
        disablewarnings {"deprecated-declarations"}

    filter {"system:linux"}
        defines {"_GNU_SOURCE"}
-- This is necessary, otherwise compilation will fail since
-- there is no CLOCK_MONOTOMIC. raylib claims to have a workaround
-- to compile under c99 without -D_GNU_SOURCE, but it didn't seem
-- to work. raylib's Makefile also adds this flag, probably why it went
-- unnoticed for so long.
-- It compiles under c11 without -D_GNU_SOURCE, because c11 requires
-- to have CLOCK_MONOTOMIC
-- See: https://github.com/raysan5/raylib/issues/2729

    filter{}
end

function get_raylib_dir()
    if (os.isdir("raylib-master")) then
        return "raylib-master"
    end
    if (os.isdir("../raylib-master")) then
        return "raylib-master"
    end
    return "raylib"
end

function link_raylib()
    links {"raylib"}

    raylib_dir = get_raylib_dir();
    includedirs {"../" .. raylib_dir .. "/src" }
    includedirs {"../" .. raylib_dir .."/src/external" }
    
    platform_defines()

    filter { "configurations:Release or configurations:Debug"}
         includedirs {"../" .. raylib_dir .."/src/external/glfw/include" }
        
    filter { "configurations:ReleaseSDL or configurations:DebugSDL"}
        includedirs {"../SDL2/include" }

    filter "action:vs*"
        defines{"_WINSOCK_DEPRECATED_NO_WARNINGS", "_CRT_SECURE_NO_WARNINGS"}
        dependson {"raylib"}
        links {"raylib.lib"}
        characterset ("MBCS")

    filter "system:windows"
        defines{"_WIN32"}
        links {"winmm", "kernel32", "opengl32", "gdi32"}
        libdirs {"../_bin/%{cfg.buildcfg}"}

    filter "system:linux"
        links {"pthread", "GL", "m", "dl", "rt", "X11"}

    filter "system:macosx"
        links {"OpenGL.framework", "Cocoa.framework", "IOKit.framework", "CoreFoundation.framework", "CoreAudio.framework", "CoreVideo.framework", "AudioToolbox.framework"}

    filter { "action:vs*", "platforms:x64", "configurations:ReleaseSDL or configurations:DebugSDL"}
        libdirs {"../SDL2/lib/x64" }
        links {"SDL2.lib"}

    filter{}

end

function include_raylib()
    raylib_dir = get_raylib_dir();
    includedirs {"../" .. raylib_dir .."/src" }
    includedirs {"../" .. raylib_dir .."/src/external" }
    platform_defines()

    filter { "configurations:Release orconfigurations:Debug"}
         includedirs {"../" .. raylib_dir .."/src/external/glfw/include" }
    filter { "configurations:ReleaseSDL or configurations:DebugSDL"}
        includedirs {"../SDL2/include" }

    filter "action:vs*"
        defines{"_WINSOCK_DEPRECATED_NO_WARNINGS", "_CRT_SECURE_NO_WARNINGS"}

    filter{}
end

project "raylib"
    kind "StaticLib"

    platform_defines()

    location "_build"
    language "C"
    targetdir "_bin/%{cfg.buildcfg}"

    filter { "configurations:ReleaseSDL or configurations:DebugSDL"}
        includedirs {"SDL2/include" }
        
     filter { "action:vs*", "platforms:x64", "configurations:DebugSDL"}
        postbuildcommands { "copy $(SolutionDir)SDL2\\lib\\x64\\SDL2.dll $(SolutionDir)_bin\\DebugSDL" }
     filter { "action:vs*", "platforms:x64", "configurations:ReleaseDL"}
        postbuildcommands { "copy $(SolutionDir)SDL2\\lib\\x64\\SDL2.dll $(SolutionDir)_bin\\ReleaseSDL" }
        
     filter { "action:vs*", "platforms:x86", "configurations:DebugSDL"}
        postbuildcommands { "copy $(SolutionDir)SDL2\\lib\\x86\\SDL2.dll $(SolutionDir)_bin\\DebugSDL" }
     filter { "action:vs*", "platforms:x86", "configurations:ReleaseDL"}
        postbuildcommands { "copy $(SolutionDir)SDL2\\lib\\x86\\SDL2.dll $(SolutionDir)_bin\\ReleaseSDL" }
        
     filter { "NOT action:vs*", "configurations:ReleaseSDL or configurations:DebugSDL"}
        includedirs {"SDL2/include" }
        links{"sdl2"}

    filter "action:vs*"
        defines{"_WINSOCK_DEPRECATED_NO_WARNINGS", "_CRT_SECURE_NO_WARNINGS"}
        characterset ("MBCS")

    filter{}

    raylib_dir = get_raylib_dir();
    print ("Using raylib dir " .. raylib_dir);
    includedirs {raylib_dir .. "/src", raylib_dir .. "/src/external/glfw/include" }
    vpaths
    {
        ["Header Files"] = { raylib_dir .. "/src/**.h"},
        ["Source Files/*"] = { raylib_dir .. "/src/**.c"},
    }
    files {raylib_dir .. "/src/*.h", raylib_dir .. "/src/*.c"}

    removefiles {raylib_dir .. "/src/rcore_*.c"}

    filter { "system:macosx", "files:" .. raylib_dir .. "/src/rglfw.c" }
        compileas "Objective-C"

    filter{}
    
