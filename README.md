### This branch is under heavy development!

This is intended to create a more generalized pcb generator for many other projects, outside of keyboards.

Mainly, I wish to modify the files so that I can create a version of Slime VR that is really easy to modify and stuff.

The project is really cool, so being able to do keyboards and more would be excellent.

Current Task:
	Move files and such around to have a more modular file structure.

General TODOS:
	Modify the layout scad files to be a bit more generalized, so components and such are dynamically loaded.
		This may mean generating a couple of files, but we'll see when we get to that...

	Refactor all components to have some specific function calls for generation.

	Create jsonschemas for each of these, for better modular generation.

	Refactor the generator code to be able to take a list of parameters and generate the PCB with minimal polishing.l
