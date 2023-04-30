
newoption
{
    trigger = "graphics",
    value = "OPENGL_VERSION",
    description = "version of OpenGL to build raylib against",
    allowed = {
        { "opengl11", "OpenGL 1.1"},
        { "opengl21", "OpenGL 2.1"},
        { "opengl33", "OpenGL 3.3"},
        { "opengl43", "OpenGL 4.3"}
    },
    default = "opengl33"
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

    targetdir "_bin/%{cfg.buildcfg}/"

    if(os.isdir("game")) then
        startproject(workspaceName)
    end

    cdialect "C99"
    cppdialect "C++17"
check_raylib();

include ("raylib_premake5.lua")

if(os.isdir("game")) then
    include ("game")
end

folders = os.matchdirs("*")
for _, folderName in ipairs(folders) do
    if (string.starts(folderName, "raylib") == false and string.starts(folderName, "_") == false and string.starts(folderName, ".") == false) then
        if (os.isfile(folderName .. "/premake5.lua")) then
            print(folderName)
            include (folderName)
        end
    end
end
