include <settings.scad>

/*
    This is the standard view of a cherry key.
*/
module cherry_mx() {
    $wire_diameter = 1;
    difference () {
        cherry_mx_pcb();
        #cherry_mx_pcb_cutout();
    }
    %difference () {
        cherry_mx_case();
        #cherry_mx_case_cutout();
    }
}

module cherry_mx_pcb() {
    translate([($cherry_mx_units[0]-$cherry_mx_socket_size)/2,($cherry_mx_units[1]-$cherry_mx_socket_size)/2,0])
        cube([$cherry_mx_socket_size, $cherry_mx_socket_size, $wall_thickness+$wire_diameter]);
    cube([$cherry_mx_units[0],$cherry_mx_units[1],$wall_thickness]);
}

module cherry_mx_pcb_cutout() {
    // Cherry Cutouts
    // Central pin
    translate([$cherry_mx_units[0]/2,$cherry_mx_units[1]/2,$wall_thickness+$wire_diameter]) {
        translate([0,0,-$cherry_mx_socket_depth])
            cylinder(h=$cherry_mx_socket_depth,r=$cherry_center_pin_radius);
    // Side pins
        for (x = [-4,4]) {
            translate([x*$cherry_pin_grid_spacing,0,-$cherry_mx_socket_depth])
                cylinder(h=$cherry_mx_socket_depth,r=$cherry_side_pin_radius);
        }
    // Top switch pin
        translate([2*$cherry_pin_grid_spacing,4*$cherry_pin_grid_spacing,-($cherry_mx_socket_depth)])
            cylinder(h=$cherry_mx_socket_depth,r=$cherry_conductor_pin_radius);
    // Bottom switch pin and Diode Hole
        translate([-3*$cherry_pin_grid_spacing,2*$cherry_pin_grid_spacing,-$cherry_mx_socket_depth]) {
            translate($cherry_diode_pin_offset) cube([$cherry_conductor_pin_radius+$cherry_diode_wire_diameter,$cherry_conductor_pin_radius+$cherry_diode_wire_diameter*($cherry_increased_contact ? 2 : 1),$cherry_mx_socket_depth]);
        }
    // Diode cathode cutout
        translate([3*$cherry_pin_grid_spacing,-4*$cherry_pin_grid_spacing,-($wall_thickness+$wire_diameter)/2])
            cylinder(h=$wall_thickness+$wire_diameter,r=$cherry_diode_wire_diameter*3,center=true);
    // Wire Channels
    // Row wire
        translate([0,4*$cherry_pin_grid_spacing,-$wire_diameter/3]) rotate([0,90,0])
            cylinder(h=$cherry_row_cutout_length,d=$wire_diameter,center=true);
    // Column wire
        translate([3*$cherry_pin_grid_spacing,-4*$cherry_pin_grid_spacing,$wire_diameter/3-($wall_thickness+$wire_diameter)]) 
            rotate([90,0,$cherry_rotate_column?90:0])
                translate([0,0,-4*$cherry_pin_grid_spacing])
                    cylinder(h=$cherry_column_cutout_length,d=$wire_diameter,center=true);

    // Diode Channel
        translate([-3*$cherry_pin_grid_spacing,-1*$cherry_pin_grid_spacing-.25,-$cherry_diode_wire_diameter*2])
            cube([$cherry_diode_wire_diameter*4,6*$cherry_pin_grid_spacing+$cherry_diode_wire_diameter*2,$cherry_diode_wire_diameter*4],center=true);
        translate([0,-4*$cherry_pin_grid_spacing,-$cherry_diode_wire_diameter*2])
            cube([6*$cherry_pin_grid_spacing,$cherry_diode_wire_diameter*4,$cherry_diode_wire_diameter*4],center=true);
        translate([-1*$cherry_pin_grid_spacing-$cherry_diode_wire_diameter*2,-4*$cherry_pin_grid_spacing,-$cherry_diode_diameter/2])
            cube([4*$cherry_pin_grid_spacing,$cherry_diode_length,$cherry_diode_diameter],center=true);
        if($cherry_increased_contact) { 
            translate([-0.5*$cherry_pin_grid_spacing,2*$cherry_pin_grid_spacing+$cherry_diode_wire_diameter,-$cherry_diode_wire_diameter*2])
                cube([5*$cherry_pin_grid_spacing,$cherry_diode_wire_diameter*4,$cherry_diode_wire_diameter*4],center=true);
        }

//    union() {
//
//    translate([
//        h_border_width/2 * (borders[3] - borders[2]),
//        v_border_width/2 * (borders[0] - borders[1]),
//        -1
//    ]) {
//        cube([
//            socket_size+h_border_width*(borders[2]+borders[3])+0.02,
//            socket_size+v_border_width*(borders[0]+borders[1])+0.02,
//            2*pcb_thickness
//        ], center=true);
//    }
    }
}

module cherry_mx_case() {}

module cherry_mx_case_cutout() {
    
}


module switch_socket(borders=[1,1,1,1], rotate_column=false) {
    difference() {
        switch_socket_base(borders);
        switch_socket_cutout(borders, rotate_column);
    }
}

module switch_socket_base(borders=[1,1,1,1]) {
    translate([h_unit/2,-v_unit/2,0]) union() {
        cube([socket_size, socket_size, pcb_thickness], center=true);
//        cube();
//        translate([0,0,border_z_offset * 1])
//            border(
//                [socket_size,socket_size], 
//                borders, 
//                pcb_thickness-2, 
//                h_border_width, 
//                v_border_width
//            );
    }
}

module switch_socket_cutout(borders=[1,1,1,1], rotate_column=false) {
    if (use_folded_contact) {
        mx_improved_socket_cutout(borders, rotate_column);
    } else {
        mx_socket_cutout(borders, rotate_column);
    }
}

module mx_improved_socket_cutout(borders=[1,1,1,1], rotate_column=false) {
    render() translate([h_unit/2,-v_unit/2,0]) rotate([0,0,switch_rotation])
        intersection() {
            union() {
                // Central pin
                translate([0,0,pcb_thickness/2-socket_depth])
                    cylinder(h=pcb_thickness+1,r=2.1);
                // Side pins
                for (x = [-4,4]) {
                    translate([x*grid,0,pcb_thickness/2-socket_depth])
                        cylinder(h=pcb_thickness+1,r=1.05);
                }
                // Top switch pin
                translate([2*grid,4*grid,pcb_thickness/2-socket_depth])
                    cylinder(h=pcb_thickness+1,r=1);
                // Bottom switch pin
                translate([-3*grid,2*grid,-(pcb_thickness+1)/2]) {
                    translate([-.625,-0.75,0]) cube([1.25,1.5,pcb_thickness+1]);
                }
                // Diode cathode cutout
                translate([3*grid,-4*grid,0])
                    cylinder(h=pcb_thickness+1,r=.7,center=true);

                // Wire Channels
                // Row wire
                translate([0,4*grid,pcb_thickness/2-wire_diameter/3]) rotate([0,90,0])
                    cylinder(h=row_cutout_length,d=wire_diameter,center=true);
                // Column wire
                translate([3*grid,-4*grid,-(pcb_thickness/2-wire_diameter/3)]) 
                    rotate([90,0,rotate_column?90:0])
                        translate([0,0,-4*grid])
                        cylinder(h=col_cutout_length,d=wire_diameter,center=true);

                // Diode Channel
                translate([-3*grid,-1*grid-.25,pcb_thickness/2])
                    cube([1,6*grid+.5,2],center=true);
                translate([0,-4*grid,pcb_thickness/2])
                    cube([6*grid,1,2],center=true);
                translate([-1*grid-.5,-4*grid,pcb_thickness/2])
                    cube([4*grid,2,3],center=true);
                translate([-0.5*grid,2*grid+0.25,pcb_thickness/2])
                    cube([5*grid,1,2],center=true);
            }

            translate([
                h_border_width/2 * (borders[3] - borders[2]),
                v_border_width/2 * (borders[0] - borders[1]),
                -1
            ]) {
                cube([
                    socket_size+h_border_width*(borders[2]+borders[3])+0.02,
                    socket_size+v_border_width*(borders[0]+borders[1])+0.02,
                    2*pcb_thickness
                ], center=true);
            }
        }
}


module mx_socket_cutout(borders=[1,1,1,1], rotate_column=false) {
    render() translate([h_unit/2,-v_unit/2,0]) rotate([0,0,switch_rotation])
        intersection() {
            union() {
                // Central pin
                translate([0,0,pcb_thickness/2-socket_depth])
                    cylinder(h=pcb_thickness+1,r=2.1);
                // Side pins
                for (x = [-4,4]) {
                    translate([x*grid,0,pcb_thickness/2-socket_depth])
                        cylinder(h=pcb_thickness+1,r=1.05);
                }
                // Top switch pin
                translate([2*grid,4*grid,pcb_thickness/2-socket_depth])
                    cylinder(h=pcb_thickness+1,r=1);
                // Bottom switch pin
                translate([-3*grid,2*grid,(pcb_thickness+1)/2])
                    rotate([180+diode_pin_angle,0,0])
                        cylinder(h=pcb_thickness+1,r=.7);
                // Diode cathode cutout
                translate([3*grid,-4*grid,0])
                    cylinder(h=pcb_thickness+1,r=.7,center=true);

                // Wire Channels
                // Row wire
                translate([0,4*grid,pcb_thickness/2-wire_diameter/3]) rotate([0,90,0])
                    cylinder(h=row_cutout_length,d=wire_diameter,center=true);
                // Column wire
                translate([3*grid,-4*grid,-(pcb_thickness/2-wire_diameter/3)]) 
                    rotate([90,0,rotate_column?90:0])
                        translate([0,0,-4*grid])
                        cylinder(h=col_cutout_length,d=wire_diameter,center=true);

                // Diode Channel
                translate([-3*grid,-1*grid-.25,pcb_thickness/2])
                    cube([1,6*grid+.5,2],center=true);
                translate([0,-4*grid,pcb_thickness/2])
                    cube([6*grid,1,2],center=true);
                translate([-1*grid-.5,-4*grid,pcb_thickness/2])
                    cube([4*grid,2,3],center=true);
            }

            translate([
                h_border_width/2 * (borders[3] - borders[2]),
                v_border_width/2 * (borders[0] - borders[1]),
                -1
            ]) {
                cube([
                    socket_size+h_border_width*(borders[2]+borders[3])+0.02,
                    socket_size+v_border_width*(borders[0]+borders[1])+0.02,
                    2*pcb_thickness
                ], center=true);
            }
        }
}

module choc_socket_cutout(borders=[1,1,1,1], rotate_column=false) {
    render() translate([h_unit/2,-v_unit/2,0]) rotate([0,0,switch_rotation])
        intersection() {
            union() {
                // Central pin
                translate([0,0,pcb_thickness/2-socket_depth])
                    cylinder(h=pcb_thickness+1,d=3.5);
                // Side pins
                for (x = [-5.5,5.5]) {
                    translate([x,0,pcb_thickness/2-socket_depth])
                        cylinder(h=pcb_thickness+1,r=1.05);
                }
                // Top switch pin
                translate([0,5.9,pcb_thickness/2-socket_depth])
                    cylinder(h=pcb_thickness+1,r=1);
                // Bottom switch pin
                translate([5,3.8,(pcb_thickness+1)/2])
                    rotate([180+diode_pin_angle,0,0])
                        cylinder(h=pcb_thickness+1,r=.7);
                // Diode cathode cutout
                translate([-3.125,-3.8,0])
                    cylinder(h=pcb_thickness+1,r=.7,center=true);

                // Wire Channels
                // Row wire
                translate([0,5.9,pcb_thickness/2-wire_diameter/3]) rotate([0,90,0])
                    cylinder(h=row_cutout_length,d=wire_diameter,center=true);
                // Column wire
                translate([-3.125,-3.8,-(pcb_thickness/2-wire_diameter/3)]) 
                    rotate([90,0,rotate_column?90:0])
                        cylinder(h=col_cutout_length,d=wire_diameter,center=true);

                // Diode Channel
                translate([-3.125,0,pcb_thickness/2])
                    cube([1,7.6,2],center=true);
                translate([.75,3.8,pcb_thickness/2])
                    cube([8.5,1,2],center=true);
                translate([-3.125,1.8,pcb_thickness/2])
                    cube([2,5,3.5],center=true);
            }

            translate([
                h_border_width/2 * (borders[3] - borders[2]),
                v_border_width/2 * (borders[0] - borders[1]),
                -1
            ]) {
                cube([
                    socket_size+h_border_width*(borders[2]+borders[3])+0.02,
                    socket_size+v_border_width*(borders[0]+borders[1])+0.02,
                    2*pcb_thickness
                ], center=true);
            }
        }
}

module switch_plate_footprint(borders=[1,1,1,1]) {
    translate([h_unit/2,-v_unit/2,0])
        border_footprint(
            [socket_size,socket_size], 
            borders, 
            h_border_width, 
            v_border_width
        );
}

module switch_plate_cutout_footprint() {
    translate([h_unit/2,-v_unit/2,0]) {
        square([plate_cutout_size, plate_cutout_size],center=true);
    }
}

module switch_plate_base(borders=[1,1,1,1], thickness=plate_thickness) {
    linear_extrude(thickness, center=true)
        switch_plate_footprint(borders);
}

module switch_plate_cutout(thickness=plate_thickness) {
    linear_extrude(thickness+1, center=true)
        switch_plate_cutout_footprint();
}

cherry_mx();
//switch_socket();
//#switch_plate_cutout_footprint();