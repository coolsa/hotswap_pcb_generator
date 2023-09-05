include <settings.scad>

/* 
    This module previews the part by combining the pcb and pcb cutout parts.
    It also highlights the added case and case cutout parts, so those are visible.
    
    Take a look at the settings.scad to see the parameters that can be changed.
*/
module pj320a(wall_thickness = 2, wire_diameter = 2.15){
    $pj320a_flange_length = 2;
    $pj320a_flange_diameter = 5;
    $wall_thickness = wall_thickness;
    $wire_diameter = wire_diameter;
    $fn = 12;
    difference() {
        pj320a_pcb();
        #pj320a_pcb_cutout();
    }
    %difference(){
        pj320a_case();
        #pj320a_case_cutout();
    }
}

module pj320a_pcb() {
    cube([$pj320a_width + $wall_thickness*2,$pj320a_length + $wall_thickness*2,$wall_thickness + ($pj320a_height/2+$pj320a_flange_diameter*1/6)]);
    // Unsure if below is needed...
//    translate([
//        $pj320a_width/2+$wall_thickness,
//        $pj320a_length+$wall_thickness,
//        $pj320a_height/2+$wall_thickness
//    ]) rotate([-90,0,0]) intersection() {
//        cylinder(d=$pj320a_flange_diameter+$wall_thickness,$pj320a_flange_length);
//        translate([0,0,$pj320a_flange_length/2]) 
//            cube([$pj320a_flange_diameter+$wall_thickness,$pj320a_flange_diameter/3,$pj320a_flange_length],center=true);
//    }
}

/*
    Generate the negative cutout shape for the pj320a trrs plug.
*/
module pj320a_pcb_cutout() {
    translate([$wall_thickness,$wall_thickness,$wall_thickness]) {
        cube([$pj320a_width,$pj320a_length,$pj320a_height]);
        // Flange Cutout
        translate([
            $pj320a_width/2,
            $pj320a_length,
            $pj320a_height/2
        ]) rotate([-90,0,0]) 
            cylinder(d=$pj320a_flange_diameter,h=$pj320a_flange_length+$wall_thickness);
        
        // Wire Channels
        translate([($pj320a_width-$pj320a_pin_spacing)/2,0.5,0]) 
            wire_channel($wall_thickness+$pj320a_height-3);
        for (y=[1.8,5.8,9.1]) {
            translate([($pj320a_width+$pj320a_pin_spacing)/2,y,-$wall_thickness]) 
                wire_channel($wall_thickness+$pj320a_height);
        }
        
        // Locating Pins
        for (y=[$pj320a_length-$pj320a_nub_offset,$pj320a_length-$pj320a_nub_offset-$pj320a_nub_spacing]) {
            translate([$pj320a_width/2,$wall_thickness-$pj320a_nub_offset+y,$pj320a_nub_height-$wall_thickness])
                cylinder(d=$pj320a_nub_diameter,h=4);
        }
    }
}

module pj320a_case() {
    //Unused
}

/*
    This is the shape that is cut-out to enable the plug to work.
*/
module pj320a_case_cutout() {
    translate([$pj320a_plug_width/2,$pj320a_length+$wall_thickness*2,0]) rotate([-90,0,0]) {
        cylinder(h=1000, d=$pj320a_plug_width);
        translate([-$pj320a_plug_width/2,-$pj320a_plug_width,0])
            cube([$pj320a_plug_width, $pj320a_plug_width, 1000]);
    }
}

module wire_channel(length = 4) {
    translate([0,0,-1]) cylinder(d=$wire_diameter+.1,h=length+2);
}


pj320a();
