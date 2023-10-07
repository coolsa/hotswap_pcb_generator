/*
    Defaults and options for the Cherry MX key standard.
*/

// These settings should be overwritten by the project, and are for testing purposes.
$fn=12;
$wall_thickness = 2;
$wire_diameter = 2.15;
/* Switch Parameters */
// Switch orientation (based on LED location)
$cherry_switch_orientation = "south";  // [north, south]
// Whether to use experimental diode leg contact
$cherry_increased_contact = true; 
/* Advanced Parameters (related to switch size) */
// Switch spacing distance
$cherry_mx_units = [19.05,19.05];
// Cherry Central Pin Radius
$cherry_center_pin_radius = 2.1;
// Cherry Side Pin Radius
$cherry_side_pin_radius = 1.05;
// Spacing of grid for MX pins
$cherry_pin_grid_spacing = 1.27;
// Cherry Conductor Pin Radius
$cherry_conductor_pin_radius = 1;
// Cherry Diode Pin Offset
$cherry_diode_pin_offset = [-.625,-0.75,0];
// Size of socket body
$cherry_mx_socket_size = 14;
// Depth of the socket holes and cherry pins
$cherry_mx_socket_depth = 3.5;
// Thickness of the plate
$cherry_mx_plate_thickness = 1.5;
// Size of the plate cutout
$cherry_mx_plate_cutout_size = 14;
// Spacing between the top of the PCB and top of the plate
$cherry_mx_pcb_plate_spacing = 5;
// Thickness of the diode wire contacts
$cherry_diode_wire_diameter = 0.25;
$cherry_diode_length = 2;
$cherry_diode_diameter = 1;
$cherry_rotate_column = false;
$cherry_row_cutout_length = $cherry_mx_socket_size;
$cherry_column_cutout_length = $cherry_rotate_column ? $cherry_mx_units[0] : $cherry_mx_units[1];
