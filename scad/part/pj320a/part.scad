include <settings.scad>

module wire_channel(length = 4, wire_diameter = 2.15) {
    translate([0,0,-1]) cylinder(d=wire_diameter+.1,h=length+2);
}

/* 
    This module previews the part by combining the pcb and pcb cutout parts.
    It also highlights the added case and case cutout parts, so those are visible.
*/
module pj320a(pcb_thickness = 4, wire_diameter = 2.15){
    difference() {
        pj320a_pcb(pcb_thickness, wire_diameter);
        #pj320a_pcb_cutout(pcb_thickness, wire_diameter);
    }
    *%difference(){
        pj320a_case();
        #pj320a_case_cutout();
    }
}

module pj320a_pcb(pcb_thickness, wire_diameter) {
    union() {
        cube([pj320a_socket_width,pj320a_socket_length,pj320a_socket_height-pj320a_flange_diameter*2/3]);
        translate([
            pj320a_socket_width/2,
            pj320a_socket_length-pj320a_flange_length,
            pcb_thickness-2+pj320a_flange_diameter/2
        ]) rotate([-90,0,0]) intersection() {
            cylinder(d=pj320a_flange_diameter+2,pj320a_flange_length);
            translate([0,0,pj320a_flange_length/2]) 
                cube([pj320a_flange_diameter+2,pj320a_flange_diameter/3,pj320a_flange_length],center=true);
        }
    }
}

module pj320a_pcb_cutout(pcb_thickness, wire_diameter) {
    translate([4-pj320a_flange_length,2,2]) 
        cube([pj320a_width,pj320a_length,pj320a_height]);
    // Flange Cutout
    translate([
        pj320a_socket_width/2,
        pj320a_socket_length-1-pj320a_flange_length,
        pj320a_flange_diameter-0.5
    ]) rotate([-90,0,0]) 
        cylinder(d=pj320a_flange_diameter,h=pj320a_flange_length+2);
    
    // Wire Channels
    translate([(pj320a_width-pj320a_pin_spacing)/2+2,4-pj320a_flange_length+0.5,0]) 
        wire_channel(pcb_thickness+pj320a_height-3);
    for (y=[1.8,5.8,9.1]) {
        translate([(pj320a_width+pj320a_pin_spacing)/2+2,4-pj320a_flange_length+y,0]) 
            wire_channel(pcb_thickness+pj320a_height-3);
    }
    
    // Locating Pins
    for (y=[pj320a_length-pj320a_nub_offset,pj320a_length-pj320a_nub_offset-pj320a_nub_spacing]) {
        translate([pj320a_socket_width/2,4-pj320a_flange_length+y,pj320a_nub_height])
            cylinder(d=pj320a_nub_diameter,h=4);
    }
}

module pj320a_case(pcb_thickness, wire_diameter) {
    //Unused
}

module pj320a_case_cutout(pcb_thickness, wire_diameter) {
    translate([
        pj320a_socket_width/2 ,
        pj320a_socket_length,
        pj320a_socket_height/2-2
    ]) rotate([-90,0,0]) {
        cylinder(h=1000, d=pj320a_plug_width);
        translate([-pj320a_plug_width/2,-pj320a_plug_width,0])
            cube([pj320a_plug_width, pj320a_plug_width, 1000]);
    }
}

pj320a();
