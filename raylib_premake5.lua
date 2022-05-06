newoption
{
    trigger = "opengl43",
    description = "use OpenGL 4.3"
}

function platform_defines()
    defines{"PLATFORM_DESKTOP"}
    if (_OPTIONS["opengl43"]) then
        defines{"GRAPHICS_API_OPENGL_43"}
    else
        defines{"GRAPHICS_API_OPENGL_33"}
    end
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
    platform_defines()

    filter "action:vs*"
        defines{"_WINSOCK_DEPRECATED_NO_WARNINGS", "_CRT_SECURE_NO_WARNINGS"}
        dependson {"raylib"}
        links {"raylib.lib"}
        characterset ("MBCS")

    filter "system:windows"
        defines{"_WIN32"}
        links {"winmm", "kernel32", "opengl32", "kernel32", "gdi32"}
        libdirs {"../_bin/%{cfg.buildcfg}"}

    filter "system:linux"
        links {"pthread", "GL", "m", "dl", "rt", "X11"}

    filter{}
end

function include_raylib()
    raylib_dir = get_raylib_dir();
    includedirs {"../" .. raylib_dir .."/src" }
    platform_defines()

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
