use <threads.scad>

module pattern(radius) {
	difference() {
		cylinder(h = 10, r = radius, center = true, $fn = 6);
		cylinder(h = 11, r = radius - 2, center = true, $fn = 6);
	}
}

module draw_circle_pattern(radius, patt_num, patt_rad) {
	step = 360 / patt_num;
	len = patt_num;

	for (i = [0 : len]) {
	    translate([radius * cos(i * step), radius * sin(i * step), 0])
	        rotate([90, 90, i * step + 90])
	        	pattern(patt_rad);
	}
}

module draw_circle_line(line, radius, patt_num, patt_rad) {
	for (i = [0 : line]) {
		rotate([0, 0, i * (360 / patt_num * 2.5)])
 			translate([0, 0, i * (patt_rad + patt_rad / 2)])
 				draw_circle_pattern(radius, patt_num, patt_rad);
	}
}

radius = 35;
circumference = 2 * PI * radius;
patt_num = 16;
patt_rad = circumference / patt_num / 2 / cos(30);

intersection() {
	union() {
    	draw_circle_line(10, radius, patt_num, patt_rad);
	    translate([0, 0, 101])
	   		cylinder(h = 1, r = radius, $fn = 100);
    }

	difference() {
		cylinder(h = 102, r = radius, $fn = 100);
	    translate([0, 0, 1])
	   		cylinder(h = 102, r = radius - 2, $fn = 100);
	}
}

difference() {
    translate([0, 0, 101])
   		cylinder(h = 1, r = radius, $fn = 100);
    translate([0, 0, 100.5])
   		cylinder(h = 2, r = radius - 3, $fn = 100);
}

difference() {
	cylinder(h = 10, r = radius, $fn = 100);
    translate([0, 0, 1])
   		cylinder(h = 10, r = radius - 2, $fn = 100);
}

cylinder(h = 2, r = radius + 1, $fn = 100);

difference() {
	translate([0, 0, 101.5])
		metric_thread(diameter = radius * 2 - 2.5, pitch = 3, length = 11, internal = false, n_starts = 1);
	translate([0, 0, 100.5])
		cylinder(h = 13, r = radius - 4, $fn = 100);
}

translate([100, 0, 0]) {
	intersection() {
		union() {
	    	draw_circle_line(10, radius, patt_num, patt_rad);
		    translate([0, 0, 65])
		   		cylinder(h = 1, r = radius, $fn = 100);
	    }

		difference() {
			cylinder(h = 66, r = radius, $fn = 100);
		    translate([0, 0, 1])
		   		cylinder(h = 66, r = radius - 2, $fn = 100);
		}
	}

	difference() {
		cylinder(h = 10, r = radius, $fn = 100);
	    translate([0, 0, 1])
	   		cylinder(h = 10, r = radius - 2, $fn = 100);
	}

	translate([0, 0, 65]) {
		difference() {
			cylinder(h = 12, r = radius, $fn = 100);
			translate([0, 0, -0.5])
				metric_thread(diameter = radius * 2 - 1.5, pitch = 3, length = 13, internal = true, n_starts = 1);
		}
	}
}
