# Components

This directory is for components, things that will have wires running to or from them.

Some example components include the `pj320a TRRS` socket, or a Cherry key.

Directories will have the `.scad` file for the generated part, a `.jsonschema` for all available configurations controlled through the `$extradata`, and occasionally a `README.md`.

TODO: Define the standard for a jsonschema, perhaps using some type of example part? Or a how-to...

TODO: Also, lets have a good think about how some components are meant to poke through the shell! The cutout of a component...
			We could define that with some type of universal module format? Like, `<part_name>_cutout` or something... Or use the extradata?
			Looking through the code, looks like this is already defined, sort of... its the `<part_name>_case_cutout` function for the trrs and for the mcu.
				Also worth noting: The directory format could enable really large and complicated components to be broken up a lot.
					Like, for example, each component could have a normal wire type, and an alternate that uses ethernet wire instead.
