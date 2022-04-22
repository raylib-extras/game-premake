/*
Raylib example file.
This is an example main file for a simple raylib project.
Use this as a starting point or replace it with your code.

For a C++ project simply rename the file to .cpp and run premake 

*/

#include "raylib.h"

int main ()
{
	// set up the window
	InitWindow(1280, 800, "Hello Raylib");
	
	// game loop
	while (!WindowShouldClose())
	{
		// drawing
		BeginDrawing();
		ClearBackground(BLACK);

		DrawText("Hello Raylib", 200,200,20,WHITE);
		
		EndDrawing();
	}

	// cleanup
	CloseWindow();
	return 0;
}