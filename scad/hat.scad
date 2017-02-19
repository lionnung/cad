r1 = 3.5;
h1 = 11;
r2 = 5;
h2 = 13;

module cut() {
	difference() {
		cylinder(r = r1, h = h1, center = true, $fn = 100);
		union() {
			translate([0, -(r1 + 1.85), 0])
				cube([r1 * 2, r1 * 2, h1 + 2], center = true);
			translate([0, r1 + 1.85, 0])
				cube([r1 * 2, r1 * 2, h1 + 2], center = true);
		}
	}
}

module hat(r, h) {
	hull() {
		cylinder(r = r, h = h, center = false, $fn = 100);
		translate([15, 0, 0])
			cylinder(r = r - 3, h = h, center = false, $fn = 100);
	}
}

difference() {
	difference() {
		union() {
			cylinder(r = r2, h = h2, center = false, $fn = 100);
			hat(r2, h2);
			hat(r2 + 1, 2);
		}
		translate([0, 0, h1 / 2 + (h2 - h1) + .01])
			cut();
	}
	translate([0, 0, h2 - 3 + .01])
		cylinder(r = r1, h = 3, center = false, $fn = 100);
}
