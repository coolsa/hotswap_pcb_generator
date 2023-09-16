/* MCU Parameters (Default values for Pro Micro) */

// These settings should be overwritten by the project, and are for testing purposes.
$fn=12;
$wall_thickness = 2;
$wire_diameter = 2.15;

$grid_size = 8;
$grid_spacing = 1.6;
// Note: only "bare" has been tested, pins are assumed to work, and pins_reversed is untested entirely, but should work if pins stick out on the same side as the usb.
$promicro_type = "bare";  // [bare, pins, pins_reversed]
$promicro_width = 18;
$promicro_length = 33;
$promicro_height = 4.25;  // Distance from top of PCB to bottom of pin plastic spacers.
$promicro_pcb_thickness = 1.6; // Thickness of actual PCB
$promicro_row_spacing = 15.24;
$promicro_row_count = 2;  // Unused
$promicro_pin_count = 24; // Total amount of pins, evenly divided on both sides
$promicro_pin_pitch = 2.54;
$promicro_pin_offset = 1;  // Offset from the rear of the PCB
$promicro_pin_inset = 1; // Depth from edge of PCB to center of pin
$promicro_pin_depth = 4; // The depth of the wire channels
$promicro_connector_width = 13;  // Width of the connector (for plate cutout)
$promicro_connector_length = 4;  // Distance the connector extends onto the MCU (for plate cutout)
$promicro_connector_height = 8;  // Height of the plug housing
$promicro_connector_offset = 2; // Vertical offset of plug center from PCB center
$promicro_clip_diameter = 1; // Diameter of cylinder that acts as a clip
// These are now defined dynamically as follows
//$promicro_socket_width = $promicro_width+$wall_thickness*2;
//$promicro_socket_length = $promicro_length+$wall_thickness*2;
$promicro_exposed = false;
