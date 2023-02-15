$fn = 50;
$fa = 5;
$fs = 1;

fa_small = 6;
fs_small = 0.2;

include <params.scad>;


difference() {
	linear_extrude(height = h_support + h_space)
	    import(file="PCB.dxf", layer="PCB");
	translate([0, 0, h_support + h_space])
	    cube([pcb_L - taille_plots * 2, pcb_l + 1, h_space * 2], center = true);
	translate([0, 0, h_support + h_space])
	    cube([pcb_L + 1, pcb_l - taille_plots * 2, h_space * 2], center = true);
	translate([0, 0, h_support])
	    cube([pcb_L - taille_plots * 2, pcb_l - taille_plots * 2,
		h_support * 2 + 1], center = true);
}
