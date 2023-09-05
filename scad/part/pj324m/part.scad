include <settings.scad>

/*
    Preview the pj324m socket type.
*/
module pj324m() {
    $pj324m_flange_diameter = 6;
    $pj324m_plug_width = 9;
    difference() {
        pj324m_pcb();
        #pj324m_pcb_cutout();
    }
    %difference(){
        pj324m_case();
        #pj324m_case_cutout();
    }
}

module pj324m_pcb() {
    // Socket Base
    cube([$wall_thickness*2+$pj324m_width,$wall_thickness*2+$pj324m_length,$wall_thickness + ($pj324m_height/2+$pj324m_flange_diameter*1/6)]);
    //not sure if the stuff below is required...
//    translate([
//        $wall_thickness,
//        $wall_thickness-$pj324m_flange_length,
//        $wall_thickness+$pj324m_flange_diameter/2
//    ]) rotate([-90,0,0]) intersection() {
//        cylinder(d=$pj324m_flange_diameter+2,$pj324m_flange_length);
//        translate([0,0,$pj324m_flange_length/2]) 
//            cube([$pj324m_flange_diameter+2,$pj324m_flange_diameter/3,$pj324m_flange_length],center=true);
//    }
}

module pj324m_pcb_cutout() {
    translate([$wall_thickness,$wall_thickness,$wall_thickness]) {
    // Socket Cutout 
        cube([$pj324m_width,$pj324m_length,$pj324m_height]);
        // Flange Cutout
        translate([
            $pj324m_width/2,
            $pj324m_length,
            $pj324m_height/2
        ]) rotate([-90,0,0]) 
            cylinder(d=$pj324m_flange_diameter,h=$pj324m_flange_length+$wall_thickness);
        
        for( pin = $pj324m_pins ){
            translate([pin[0]+$pj324m_width/2,pin[1],-$wall_thickness/2]) 
                wire_channel($wall_thickness*2+$pj324m_height);
        }
    }
}

module pj324m_case() {
    // Unused
}

/*
    The cutout made for the audio jack to plug in with.
*/
module pj324m_case_cutout() {
    translate([
        $pj324m_width/2+$wall_thickness,//h_unit/2,
        $pj324m_length+$wall_thickness*2,
        0//plate_thickness/2-pcb_plate_spacing+trrs_flange_diameter/2-2
    ]) rotate([-90,0,0]) {
        cylinder(h=1000, d=$pj324m_plug_width);
        translate([-$pj324m_plug_width/2,-$pj324m_plug_width,0])
            cube([$pj324m_plug_width, $pj324m_plug_width, 1000]);
    }
}

module wire_channel(length=$wall_thickness) {
    translate([0,0,-$wall_thickness]) cylinder(d=$wire_diameter+.1,h=length);
}

//module trrs_plate_footprint(borders=[0,0,0,0]) {
//    translate([h_unit/2,-v_unit/2,0])
//        border_footprint(
//            [h_unit,v_unit], 
//            borders
//        );
//}
//
//module trrs_plate_cutout_footprint() {
//    if (switch_type == "mx") {
//        // MX spacing is sufficient to fit the TRRS socket with no cutout, so we just need plug clearance
//        translate([h_unit/2,-socket_length/2]) {
//            border_footprint(
//                [socket_width,socket_length], 
//                [
//                    1000,
//                    -socket_length,
//                    (trrs_plug_width-socket_width)/2,
//                    (trrs_plug_width-socket_width)/2
//                ]
//            );
//        }
//    } else if (switch_type == "choc") {
//        translate([h_unit/2,-socket_length/2]) {
//            border_footprint(
//                [socket_width,socket_length], 
//                [1000,0,0,0]
//            );
//            border_footprint(
//                [socket_width,socket_length], 
//                [
//                    1000,
//                    -socket_length,
//                    (trrs_plug_width-socket_width)/2,
//                    (trrs_plug_width-socket_width)/2
//                ]
//            );
//        }
//    } else {
//        assert(false, "switch_type is invalid");
//    }
//}
//
//module trrs_plate_base(borders=[0,0,0,0], thickness=plate_thickness) {
//    linear_extrude(thickness, center=true)
//        trrs_plate_footprint(borders);
//}
//
//module trrs_plate_cutout(thickness=plate_thickness) {
//    linear_extrude(thickness+1, center=true)
//        trrs_plate_cutout_footprint();
//}
//
//module trrs_case_cutout() {
//    translate([
//        h_unit/2,
//        0,
//        plate_thickness/2-pcb_plate_spacing+trrs_flange_diameter/2-2
//    ]) rotate([-90,0,0]) {
//        cylinder(h=1000, d=trrs_plug_width);
//        translate([-trrs_plug_width/2,-trrs_plug_width,0])
//            cube([trrs_plug_width, trrs_plug_width, 1000]);
//    }
//}

pj324m();