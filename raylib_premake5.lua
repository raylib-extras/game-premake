-- Copyright (c) 2020-2024 Jeffery Myers
--
--This software is provided "as-is", without any express or implied warranty. In no event 
--will the authors be held liable for any damages arising from the use of this software.

--Permission is granted to anyone to use this software for any purpose, including commercial 
--applications, and to alter it and redistribute it freely, subject to the following restrictions:

--  1. The origin of this software must not be misrepresented; you must not claim that you 
--  wrote the original software. If you use this software in a product, an acknowledgment 
--  in the product documentation would be appreciated but is not required.
--
--  2. Altered source versions must be plainly marked as such, and must not be misrepresented
--  as being the original software.
--
--  3. This notice may not be removed or altered from any source distribution.

function platform_defines()
     filter {"options:backend=GLFW"}
        defines{"PLATFORM_DESKTOP"}

    filter {"options:backend=RLFW"}
        defines{"PLATFORM_DESKTOP_RGFW"}

    filter {"options:backend=SDL2"}
        defines{"PLATFORM_DESKTOP_SDL"}

    filter {"options:backend=SDL3"}
        defines{"PLATFORM_DESKTOP_SDL"}

    filter {"options:graphics=opengl43"}
        defines{"GRAPHICS_API_OPENGL_43"}

    filter {"options:graphics=opengl33"}
        defines{"GRAPHICS_API_OPENGL_33"}

    filter {"options:graphics=opengl21"}
        defines{"GRAPHICS_API_OPENGL_21"}

    filter {"options:graphics=opengl11"}
        defines{"GRAPHICS_API_OPENGL_11"}

    filter {"options:graphics=openges3"}
        defines{"GRAPHICS_API_OPENGL_ES3"}

    filter {"options:graphics=openges2"}
        defines{"GRAPHICS_API_OPENGL_ES2"}

    filter {"system:macosx"}
        disablewarnings {"deprecated-declarations"}

    filter {"system:linux"}
        defines {"_GLFW_X11"}
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
    includedirs {"../" .. raylib_dir .."/src/external/glfw/include" }
    platform_defines()
    
    filter "files:**.dll"
        buildaction "Copy"

    filter "action:vs*"
        defines{"_WINSOCK_DEPRECATED_NO_WARNINGS", "_CRT_SECURE_NO_WARNINGS"}
        dependson {"raylib"}
        links {"raylib.lib"}
        characterset ("MBCS")
        buildoptions { "/Zc:__cplusplus" }

    filter "system:windows"
        defines{"_WIN32"}
        links {"winmm", "gdi32", "opengl32"}
        libdirs {"../bin/%{cfg.buildcfg}"}

    filter "system:linux"
        links {"pthread", "m", "dl", "rt", "X11"}

    filter "system:macosx"
        links {"OpenGL.framework", "Cocoa.framework", "IOKit.framework", "CoreFoundation.framework", "CoreAudio.framework", "CoreVideo.framework", "AudioToolbox.framework"}

    filter {"options:backend=SDL2"}
        includedirs {"../SDL2/include" }

    filter { "system:windows", "options:backend=SDL2", "platforms:x64"}
        libdirs {"../SDL2/lib/x64"}
        links {"SDL2"}
        files "../SDL2/lib/x64/SDL2.dll"

    filter { "system:windows", "options:backend=SDL2", "platforms:x32"}
        libdirs {"../SDL2/lib/x32"}
        links {"SDL2"}
        files "../SDL2/lib/x32/SDL2.dll"

    filter { "system:windows", "options:backend=SDL3", "platforms:x64", "action:vs*"}
        includedirs {"../SDL3/include/SDL3" }
        includedirs {"../SDL3/include" }
        libdirs {"../SDL3/lib/x64"}
        links {"SDL3"}
        files "../SDL3/lib/x64/SDL3.dll"
        
    filter { "system:windows", "options:backend=SDL3", "platforms:x32", "action:vs*"}
        includedirs {"../SDL3/include/SDL3" }
        includedirs {"../SDL3/include" }
        libdirs {"../SDL3/lib/x32"}
        links {"SDL3"}
        files "../SDL3/lib/x32/SDL3.dll"
 
    filter { "system:windows", "options:backend=SDL3", "platforms:x64", "action:gmake*"}
        includedirs {"../SDL3/x86_64-w64-mingw32/include/SDL3" }
        includedirs {"../SDL3/x86_64-w64-mingw32/include" }
        libdirs {"../SDL3/x86_64-w64-mingw32/lib/"}
        libdirs {"../SDL3/x86_64-w64-mingw32/bin/"}
        links {"SDL3"}
        files "../SDL3/x86_64-w64-mingw32/bin/SDL3.dll"

    filter { "system:*nix OR system:macosx", "options:backend=SDL2",  "configurations:Debug OR configurations:Release"}
        links {"SDL2"}

    filter { "system:*nix OR system:macosx", "options:backend=SDL3",  "configurations:Debug OR configurations:Release"}
        links {"SDL3"}

    filter{}
end

function include_raylib()
    raylib_dir = get_raylib_dir();
    includedirs {"../" .. raylib_dir .."/src" }
    includedirs {"../" .. raylib_dir .."/src/external" }
    includedirs {"../" .. raylib_dir .."/src/external/glfw/include" }
    platform_defines()

    filter "action:vs*"
        defines{"_WINSOCK_DEPRECATED_NO_WARNINGS", "_CRT_SECURE_NO_WARNINGS"}

    filter{}
end

project "raylib"
    kind "StaticLib"
    raylib_dir = get_raylib_dir();

    platform_defines()

    location (raylib_dir)
    language "C"
    targetdir "bin/%{cfg.buildcfg}"

    filter {"options:backend=SDL2"}
        includedirs {"SDL2/include" }

     filter {"options:backend=SDL3", "action:vs*"}
        includedirs {"SDL3/include/SDL3" }
        includedirs {"SDL3/include" }
        
    filter { "system:windows", "options:backend=SDL3", "platforms:x64", "action:gmake*"}
        includedirs {"SDL3/x86_64-w64-mingw32/include/SDL3" }
        includedirs {"SDL3/x86_64-w64-mingw32/include" }

    filter "action:vs*"
        defines{"_WINSOCK_DEPRECATED_NO_WARNINGS", "_CRT_SECURE_NO_WARNINGS"}
        characterset ("MBCS")
        buildoptions { "/Zc:__cplusplus" }
    filter{}

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
