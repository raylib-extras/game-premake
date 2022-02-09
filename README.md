# Raylib Setup using Premake5

This is a premake sript to build games with raylib. Premake works by creating a build system for different platforms to use.
This setup is designed to work with the following platforms/compilers

* Windows - Visual Studio 2019
* Windows - Mingw-w64  https://youtu.be/4hWm8ieg4oM
* Linux - GCC

## Common Instructions
These steps setup the basic source code needed and are applied to all platforms.

### Create a folder for your game
Create a folder for you game. It can be anywhere on your computer.

![image](https://user-images.githubusercontent.com/322174/107884955-7158b000-6eac-11eb-97b7-5605c7ed34d1.png)

### Download the Raylib Sources
Download the raylib source code, from
https://github.com/raysan5/raylib
You can get the zip file or clone the repository in git, both will work the same.
Do not use the folder from the windows installer, it does not have the correct structure.

![image](https://user-images.githubusercontent.com/322174/107884966-7b7aae80-6eac-11eb-9f36-dc48f719a74d.png)

### Copy Raylib into your game folder
Extract the zip file, or copy the cloned raylib repository into a folder named raylib in your game folder. source code.

![image](https://user-images.githubusercontent.com/322174/107884970-833a5300-6eac-11eb-80a8-ae5bae854e94.png)

This folder should contain all the raylib source code files

### Setup your game's project folder
Make a folder for your game project. Inside the folder you just created, place your game's source code - or at least one C or CPP file that has a main function (you can, if you want, place the source file(s) in a subfolder to keep them separate from other stuff. You can name the subfolder anything you want).
In this case, we will be starting with the "advanced game" template from the raylib sources, since it is a great place to start any project from.

If you do not have any source code files on hand, simply copy the code from one of the examples. 
If the generated project can not find the source file(s), it will not be able to build properly!

![image](https://user-images.githubusercontent.com/322174/107885011-b0870100-6eac-11eb-889d-7a39bc5b3cdb.png)

### Download Premake5
Download premake version 5.0 from https://premake.github.io/

![image](https://user-images.githubusercontent.com/322174/107884980-8f261500-6eac-11eb-8800-2bf485d1c2b0.png)

https://premake.github.io/download.html#v5
 
Put the premake5 executable into your game folder.

![image](https://user-images.githubusercontent.com/322174/107884989-964d2300-6eac-11eb-8715-088710243ee5.png)

### Download premake5.lua and premake-2019.bat
Download these two files from this repository
https://github.com/raylib-extras/game-premake

![image](https://user-images.githubusercontent.com/322174/107885001-9fd68b00-6eac-11eb-90b2-04569ec08e50.png)

Copy it into your game folder.


### Setup premake5.lua file
Open the premake5.lua file in notepad++ or some other text editor.
Find the two instances of “YourGame” and replace them with the name of your game project folder.

![image](https://user-images.githubusercontent.com/322174/107885020-b7ae0f00-6eac-11eb-8a20-d0ba0747a51d.png)
![image](https://user-images.githubusercontent.com/322174/107885030-c09ee080-6eac-11eb-8190-b5a2e2a2bec3.png)

Save the file and close it.

## Visual Studio 2019 instructions
These are the instructions for Visual Studio 2019, do these after you do the common steps above.
Note: If you have a newer version of Visual Studio than 2019, it will probably work with that too.

### Download Visual Studio 2019
Get Visual Studio from https://visualstudio.microsoft.com/downloads/
The community edition is free and is perfectly suited for game development with raylib.

![image](https://user-images.githubusercontent.com/322174/107884936-4c643d00-6eac-11eb-8831-78421ff75099.png)

### Install Visual Studio
Run the installer to put Visual Studio 2019 on your computer. See https://docs.microsoft.com/en-us/cpp/build/vscpp-step-0-installation?view=msvc-160 for more info.
Be sure to install the Desktop development with C++ and Universal Windows Platform development workflows.

![image](https://user-images.githubusercontent.com/322174/107884951-6b62cf00-6eac-11eb-8d25-8e6fd3f9fdba.png)

### Run premake-2019.bat
Double click the premake-2019.bat file, or run it from a console.
If you wish to run the .bat file from a console, open Command Prompt (cmd) or Powershell, then go to the folder you placed the .bat file in, type its name and hit Enter. Or just simply drag the file to the console window (you still need to enter that folder inside the console, otherwise the .bat file can not find the premake executable!).

This will generate all the Visual Studio project files for the game. You will end up with a .sln file for your game in the root folder.

![image](https://user-images.githubusercontent.com/322174/107885039-c8f71b80-6eac-11eb-8b04-df2e5c9142a6.png)

The same premake system can be used on linux, just use the command premake5 gmake instead of premake5 vs2019

### Open your .sln file
Double click the sln file to open your game project in Visual Studio. It will include both your game files and the raylib library, all ready to build.
Note: If you have a newer version of Visual Studio installed, you might get a dialog called _Retarget Projects_ when you open the solution. The solution should still be able to compile if you chose to retarget the project.

![image](https://user-images.githubusercontent.com/322174/107885046-d2808380-6eac-11eb-8c67-1cb923303c7b.png)

## MinGW-w64
These are the instructions for Mingw-w64, do these after you do the common steps above. 

### Get a modern version of MinGW-w64
devkit is a great way to get it.
https://github.com/skeeto/w64devkit

### Run premake-mingw.bat
Double click the premake-mingw.bat file, or run it from a console. This will generate all the makefiles for the game. You will end up with a MAKEFILE file for your game in the root folder.

### Build with Mingw-w64
Open a mingw terminal and run make in your game folder. This will build your game into the bin folder.

## Linux GCC
These are the instructions for gcc on linux, do these after you do the common steps above. 

### Run premake
run the command premake5 gmake2. This will generate all the makefiles for the game. You will end up with a MAKEFILE file for your game in the root folder.

### Build with gcc
Run make in a terminal to build your game. This will build your game into the bin folder.

  
## Develop your game.
You can now build, debug, and run your game using your chosen compiler tool chain

![image](https://user-images.githubusercontent.com/322174/107885060-de6c4580-6eac-11eb-87a5-9a209cb03a7a.png)

#Optional
## premake-2019 - OpenGL 4.3.bat
This builds raylib with support for OpenGL 4.3 (requires raylib 4.0)
