# Components / Parts

This directory is for components, things that will have wires running to or from them.

Some example components include the `pj320a TRRS` socket, or a Cherry key.

Directories will have the `part.scad` file for the generated part, `settings.scad` for all controlled functions, a `.jsonschema` for all available configurations controlled through the `$extradata` (UNSURE, PERHAPS NOT), and occasionally a `README.md` for complicated files.

Parts follow this standard:
	The folder is named `<part>`.
	`<part>_pcb()` `<part>_pcb_cutout()` `<part>_case()` `<part>_case_cutout()` `<part>_dimensions()`
TODO: Define the standard for a jsonschema, perhaps using some type of example part? Or a how-to...

TODO: Also, lets have a good think about how some components are meant to poke through the shell! The cutout of a component...
			We could define that with some type of universal module format? Like, `<part_name>_cutout` or something... Or use the extradata?
			Looking through the code, looks like this is already defined, sort of... its the `<part_name>_case_cutout` function for the trrs and for the mcu.
				Also worth noting: The directory format could enable really large and complicated components to be broken up a lot.
					Like, for example, each component could have a normal wire type, and an alternate that uses ethernet wire instead.

TODO: Move all parts to a new generation format, which will be like follows:
				For each part of the generation, the shell and the pcb, there will be 2 functions. one will be additive, and one will be subtractive.
				They will both be positive, but one should be used as a `difference()` operation.
					For example, the pj320a would have 4 functions: `pj320a_pcb()`, `pj320a_pcb_cutout()`, `pj320a_case()`, and `pj320a_case_cutout()`
			The reasoning for this is so that we can have a two-pass generation for everything.
				This would be an additive stage and a subtractive stage.
					Additive would take all the parts, the pcb plate, etc, and put them into one huge combined mass.
					Subtractive would follow, combine the negatives all into a huge thing and then `difference()` these two.
			This also means that we don't really need to add the plate onto a part, parts can be totally isolated and not need any prereq tools.

			Hindsight: Might be a good idea to have some plate interactions as part of it... not sure how that would be done, but it may be needed.
			so `pj320a_plate` and `pj320a_plate_cutout` could be needed...
				Hindsight there: May not be possible, as centering the part to the plate is something that is needed.
					and because I'd like it so that we do that *after* making the part, I don't think we can really do it.
						We can include plate modifiers in the creation of the shape though.

						Actually, may be possible if convert the `switch_type` to `$switch_type`, so that way parts can still have some control over this...

						Or have some alignment code? Not really sure how to proceed there...

TODO: find a way to standardize the switches and their units... Not sure how to go about doing that.

		Some thoughts on this: I could add a function that calls the returns the `[x,y,z] dimensions of the part, as offsets from the origin.
			This would enable some automatic spacing of things, so that way switches and their plate sizes and the case could be generated.
			As the switch dimensions are less important now, this would be useful, I think... Over complicated? We shall see!

TODO: Make parts not dependent on the pcb height or plate stuffs. Or see if this is actually needed...
				Could make it, if needed, defined in the jsonschema call format, so that way the function calls can have those as inputs.

TODO: Parts should have an option to add more material to the base plate, perhaps a nested `[[-x,+x],[-y,+y]]` type thing, with an extra cube?

TODO: Working on the cherry key made me realize some things: theres a space between the bottom of the pcb and the top.
				This is is important for somethings, i.e. the gap between the faceplate and the pcb, which has some spacers for the screw standoffs...
				This is important to keeping the keys in place and such... how can it work, with more dynamic parts?
				Would I need a cutout, or special functions for the parts, that can output the maximum height above and below the pcb thats needed?
				Or should the case and case cutout do this? This is a bit tough, but I'm sure the details can be hammered out without any issue.
				How would the border of the case be done? Especially in a 3d pcb, which would need a lot of oversight.
				Since each part is a specific function that can be called in isolation, with special `$variables` passed, these could be used in an external project.
				I want to be able to bring in the old keyboards into this project though, so that way there's a larger quantity of reference materials.
				So everything should be as backwards compatible as possible, which is so much added difficulty...
				But this feels like it should be possible, to implement, and to do well enough that most things could be defined in some json file and converted to SCAD.
				Let's try and figure what the heirarchy would look like...
