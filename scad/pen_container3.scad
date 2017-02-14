str1 = "獅子吃肉絲 ♂♀ Lion loves Rose";

module draw_circle_text(radius, font_num, font_sz, font_z, str) {
	step = 360 / font_num;
	len = len(str);

	for (i = [0 : len]) {
	    translate([radius * cos(360 - i * step), radius * sin(360 - i * step), font_z + i * (font_sz / (font_num - 3.8))])
	        rotate([90, 0, 360 - i * step + 90])
	        	linear_extrude(height = 10, center = true, twist = 0)
					text(str[len - i - 1], font = "標楷體", size = font_sz, valign = "center", halign = "center");
	}
}

radius = 35;
circumference = 2 * PI * radius;
font_num = 9;
font_sz = circumference / font_num - 5;

intersection() {
	difference() {
		union() {
			cylinder(h = 110, r = radius, $fn = 100);
			draw_circle_text(radius, font_num, font_sz, 10, str1);
		}
	    translate([0, 0, 1])
	   		cylinder(h = 110, r = radius - 2, $fn = 100);
	}
	cylinder(h = 110, r = radius + 1, $fn = 100);
}

cylinder(h = 2, r = radius + 1, $fn = 100);
