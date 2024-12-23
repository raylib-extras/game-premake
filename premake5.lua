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

newoption
{
    trigger = "graphics",
    value = "OPENGL_VERSION",
    description = "version of OpenGL to build raylib against",
    allowed = {
        { "opengl11", "OpenGL 1.1"},
        { "opengl21", "OpenGL 2.1"},
        { "opengl33", "OpenGL 3.3"},
        { "opengl43", "OpenGL 4.3"},
        { "opengles2", "OpenGLES 2.0"},
        { "opengles3", "OpenGLES 3.0"}
    },
    default = "opengl33"
}

newoption
{
    trigger = "backend",
    value = "BACKEND",
    description = "backend to use",
    allowed = {
        { "GLFW", "GLFW"},
        { "SDL2", "SDL2"},
        { "SDL3", "SDL3"},
        { "RLFW", "RLFW"}
    },
    default = "GLFW"
}

function string.starts(String,Start)
    return string.sub(String,1,string.len(Start))==Start
end

function link_to(lib)
    links (lib)
    includedirs ("../"..lib.."/include")
    includedirs ("../"..lib.."/" )
end

function download_progress(total, current)
    local ratio = current / total;
    ratio = math.min(math.max(ratio, 0), 1);
    local percent = math.floor(ratio * 100);
    print("Download progress (" .. percent .. "%/100%)")
end

function check_raylib()
    if(os.isdir("raylib") == false and os.isdir("raylib-master") == false) then
        if(not os.isfile("raylib-master.zip")) then
            print("Raylib not found, downloading from github")
            local result_str, response_code = http.download("https://github.com/raysan5/raylib/archive/refs/heads/master.zip", "raylib-master.zip", {
                progress = download_progress,
                headers = { "From: Premake", "Referer: Premake" }
            })
        end
        print("Unzipping to " ..  os.getcwd())
        zip.extract("raylib-master.zip", os.getcwd())
        os.remove("raylib-master.zip")
    end
end

function use_library(libraryName, githubFolder, repoHead)
    libFolder = libraryName .. "-" .. repoHead
    zipFile = libFolder .. ".zip"

    baseName = path.getbasename(os.getcwd());

    links(libraryName);
    includedirs {"../" .. libFolder .. "/" }
    includedirs {"../" .. libFolder .."/src/" }
    includedirs {"../" .. libFolder .."/include/" }
    

    os.chdir("..")
    
    if(os.isdir(libFolder) == false) then
        if(not os.isfile(zipFile)) then
            print(libraryName .. " not found, downloading from github")
            local result_str, response_code = http.download("https://github.com/" .. githubFolder .. "/archive/refs/heads/" .. repoHead ..".zip", zipFile, {
                progress = download_progress,
                headers = { "From: Premake", "Referer: Premake" }
            })
        end
        print("Unzipping to " ..  os.getcwd())
        zip.extract(zipFile, os.getcwd())
        os.remove(zipFile)
    end

    os.chdir(libFolder)
    
    project (libraryName)
        kind "StaticLib"
        location "./"
        targetdir "../bin/%{cfg.buildcfg}"

        filter "action:vs*"
            buildoptions { "/experimental:c11atomics" }

        vpaths 
        {
            ["Header Files/*"] = { "include/**.h", "include/**.hpp",  "**.h", "**.hpp"},
            ["Source Files/*"] = { "src/**.cpp", "src/**.c", "**.cpp",  "**.c"},
        }
        files {"include/**.hpp", "include/**.h","src/**.hpp", "src/**.h", "src/**.cpp", "src/**.c"}

        includedirs { "./" }
        includedirs { "./src" }
        includedirs { "./include" }

    os.chdir(baseName)
end

function use_Box2dV3()
    use_library("box2d", "erincatto/box2d", "main")
end

workspaceName = path.getbasename(os.getcwd())

if (string.lower(workspaceName) == "raylib") then
    print("raylib is a reserved name. Name your project directory something else.")
    -- Project generation will succeed, but compilation will definitely fail, so just abort here.
    os.exit()
end

workspace (workspaceName)
    configurations { "Debug", "Release"}
    platforms { "x64", "x86", "ARM64"}

    defaultplatform ("x64")

    filter "configurations:Debug"
        defines { "DEBUG" }
        symbols "On"

    filter "configurations:Release"
        defines { "NDEBUG" }
        optimize "On"

    filter { "platforms:x64" }
        architecture "x86_64"

    filter { "platforms:Arm64" }
        architecture "ARM64"

    filter {}

    targetdir "bin/%{cfg.buildcfg}/"

    if(os.isdir("game")) then
        startproject(workspaceName)
    end

cdialect "C17"
cppdialect "C++17"
check_raylib();

include ("raylib_premake5.lua")

if(os.isdir("game")) then
    include ("game")
end

folders = os.matchdirs("*")
for _, folderName in ipairs(folders) do
    if (string.starts(folderName, "raylib") == false and string.starts(folderName, ".") == false) then
        if (os.isfile(folderName .. "/premake5.lua")) then
            print(folderName)
            include (folderName)
        end
    end
end
