/*
    Defaults and options for the Cherry MX key standard.
*/

// These settings should be overwritten by the project, and are for testing purposes.
$fn=12;
$wall_thickness = 2;
$wire_diameter = 2.15;

/* Switch Parameters */
// Switch type
switch_type = "mx";  // [mx, choc]
// Switch orientation (based on LED location)
switch_orientation = "south";  // [north, south]
// Whether to use experimental diode leg contact
use_folded_contact = true; 
/* Advanced Parameters (related to switch size) */
// Switch spacing distance
unit = 19.05;
// Horizontal unit size (18mm for choc keycaps)
h_unit = unit;
// Vertical unit size (17mm for choc keycaps)
v_unit = unit;
// Spacing of grid for MX pins
grid = 1.27;
// Size of socket body
socket_size =
    switch_type == "mx"
    ? 14
    : switch_type == "choc"
        ? 15
        : assert(false, "switch_type is invalid");
// Depth of the socket holes
socket_depth = 3.5;
// Thickness of the plate
plate_thickness =
    switch_type == "mx"
    ? 1.5
    : switch_type == "choc"
        ? 1.3
        : assert(false, "switch_type is invalid");
// Size of the plate cutout
plate_cutout_size =
    switch_type == "mx"
    ? 14
    : switch_type == "choc"
        ? 13.8
        : assert(false, "switch_type is invalid");
// Spacing between the top of the PCB and top of the plate
pcb_plate_spacing =
    switch_type == "mx"
    ? 5
    : switch_type == "choc"
        ? 2.2
        : assert(false, "switch_type is invalid");
