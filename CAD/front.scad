$fn = 50;
$fa = 5;
$fs = 1;

fa_small = 6;
fs_small = 0.2;

include <params.scad>;

module boite_ext(h = 20, h_o = 5) {
    translate([0, 0, -h + 1]) difference() {
        minkowski() {
	    union() {
		linear_extrude(height = h - 1)
		    import(file="PCB.dxf", layer="box_e");
		translate([-49 - 10 / 2, 0, h - h_o / 2 - 1])
		    cube([10, 10, h_o], center = true);
		translate([54 + 10 / 2, 0, h - h_o / 2 -1 ])
		    cube([10, 10, h_o], center = true);
	    };
	    sphere(r = 1, $fa = fa_small, $fs = fs_small);
	}
	translate([0, 0, h_front]) cube([150, 100, 2], center = true);
    }
}

module boite() {
    h_emp_pcb = h_support + h_space + h_pcb;
    h_int = h_front - 3;
    difference() {
	boite_ext(h = h_front);
	// holes
	translate([-49 - 10 / 2 - 1, 0,  -h_front]) cylinder(h = h_front + 1, d = 5);
	translate([54 + 10 / 2 + 1, 0, -h_front]) cylinder(h = h_front + 1, d = 5);
	// back+PCB space
	translate([0, 0, -h_emp_pcb]) 
		linear_extrude(height = h_emp_pcb + 1)
		    import(file="PCB.dxf", layer="box_i");
	// hole up to top, with 3mm wall
	cube([pcb_L - taille_plots * 2, pcb_l + 1, h_int * 2], center = true);
	cube([pcb_L + 1, pcb_l - taille_plots * 2, h_int * 2], center = true);
	// cable space
	translate([pcb_L / 2 + 8 / 2, 5, -3 / 2]) rotate([90, 0, 0])
	    cylinder(h = pcb_l, d = 3, center = true);
	translate([pcb_L / 2 + 8 / 2, 5, 0]) rotate([90, 0, 0])
	    cube([3, 3, pcb_l], center = true);
	translate([pcb_L / 2 + 8 / 2 + 3 / 2 - 10 / 2, -pcb_l / 2 + 5 + 10 / 2, 0])
	    cube([10, 10, (h_emp_pcb + 5) * 2], center = true);
    }
}

boite();
