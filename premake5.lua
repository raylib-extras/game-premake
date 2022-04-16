
function define_C()
    language "C"
end

function define_Cpp()
    language "C++"
end

function string.starts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

function link_to(lib)
	links (lib)
	includedirs ("../"..lib)
end

baseName = path.getbasename(os.getcwd())

workspace (baseName)
    configurations { "Debug", "Release"}
    platforms { "x64", "x86"}

    filter "configurations:Debug"
        defines { "DEBUG" }
        symbols "On"
        
    filter "configurations:Release"
        defines { "NDEBUG" }
        optimize "On"    

    filter { "platforms:x64" }
        architecture "x86_64"
        
    targetdir "bin/%{cfg.buildcfg}/"
	
include ("raylib_premake5.lua")

folders = os.matchdirs("*")

for _, folderName in ipairs(folders) do
	if (folderName ~= "raylib" and folderName ~= "build" and folderName ~= "bin" and string.starts(folderName, "_") == false and string.starts(folderName, ".") == false) then
		print(folderName)
		include (folderName)
	end
end