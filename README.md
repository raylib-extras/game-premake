# Raylib Setup using Premake5
### Visual Studio 2019 instructions

## Download Visual Studio 2019
Get Visual Studio from https://visualstudio.microsoft.com/downloads/
The community edition is free and is perfectly suited for game development with raylib.

![image](https://user-images.githubusercontent.com/322174/107884936-4c643d00-6eac-11eb-8831-78421ff75099.png)

## Install Visual Studio
Run the installer to put Visual Studio 2019 on your computer. See https://docs.microsoft.com/en-us/cpp/build/vscpp-step-0-installation?view=msvc-160 for more info.
Be sure to install the Desktop development with C++ and Universal Windows Platform development workflows.

![image](https://user-images.githubusercontent.com/322174/107884951-6b62cf00-6eac-11eb-8d25-8e6fd3f9fdba.png)

## Create a folder for your game
Create a folder for you game. It can be anywhere on your computer.

![image](https://user-images.githubusercontent.com/322174/107884955-7158b000-6eac-11eb-97b7-5605c7ed34d1.png)

## Download the Raylib Sources
Download the raylib source code, from
https://github.com/raysan5/raylib
You can get the zip file or clone the repository in git, both will work the same.
Do not use the folder from the windows installer, it does not have the correct structure.

![image](https://user-images.githubusercontent.com/322174/107884966-7b7aae80-6eac-11eb-9f36-dc48f719a74d.png)

## Copy Raylib into your game folder
Extract the zip file, or copy the cloned raylib repository into a folder named raylib in your game folder. source code.

![image](https://user-images.githubusercontent.com/322174/107884970-833a5300-6eac-11eb-80a8-ae5bae854e94.png)
This folder should contain all the raylib 

## Download Premake5
Download premake version 5.0 from https://premake.github.io/

![image](https://user-images.githubusercontent.com/322174/107884980-8f261500-6eac-11eb-8800-2bf485d1c2b0.png)

https://premake.github.io/download.html#v5
 
Put the premake5. Exe into your game folder.

![image](https://user-images.githubusercontent.com/322174/107884989-964d2300-6eac-11eb-8715-088710243ee5.png)

## Download the premake5.lua file from raylibExras
Download the premake5.lua and premake-2019.bat files from this repository
https://github.com/raylib-extras/game-premake

![image](https://user-images.githubusercontent.com/322174/107885001-9fd68b00-6eac-11eb-90b2-04569ec08e50.png)
Copy them into your game folder.

## Setup your game's source code
Make a folder for your actual game’s source code. In this case we will be starting with the “advanced game” template from the raylib sources, since it is a great place to start any project from. Be sure to copy at least one C or CPP file that has a main function into this folder. If you are unsure what to do , simply copy the code from one of the examples.

![image](https://user-images.githubusercontent.com/322174/107885011-b0870100-6eac-11eb-889d-7a39bc5b3cdb.png)

## Setup premake5.lua file
Open the premake5.lua file in notepad++ or some other text editor (regular notepad is fine).
Find the two instances of “YourGame” and replace them with the name of your game project.

![image](https://user-images.githubusercontent.com/322174/107885020-b7ae0f00-6eac-11eb-8a20-d0ba0747a51d.png)
![image](https://user-images.githubusercontent.com/322174/107885030-c09ee080-6eac-11eb-8190-b5a2e2a2bec3.png)
Save the file and close it.

## Run premake-2019.bat
Double click the premake-2019.bat file, or run it from a console. This will generate all the visual studio project files for the game. You will end up with a .sln file for your game in the root folder.

![image](https://user-images.githubusercontent.com/322174/107885039-c8f71b80-6eac-11eb-8b04-df2e5c9142a6.png)

The same premake system can be used on linux, just use the command premake5 gmake instead of premake5 vs2019

## Open your .sln file
Double click the sln file to open your game project in Visual Studio. It will include both your game files and the raylib library, all ready to build.

![image](https://user-images.githubusercontent.com/322174/107885046-d2808380-6eac-11eb-8c67-1cb923303c7b.png)
  
## Develop your game.
You can now build, debug, and run your game from Visual Studio. 

![image](https://user-images.githubusercontent.com/322174/107885060-de6c4580-6eac-11eb-87a5-9a209cb03a7a.png)

 



