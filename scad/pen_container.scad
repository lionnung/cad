linear_extrude(height = 100, twist = 90, $fn = 100) {
    difference() {
        offset(r = 5) {
            circle(25, center = true, $fn = 5);
        }
        offset(r = 3) {
            circle(25, center = true, $fn = 5);
        }
    }
}

linear_extrude(height = 3, twist = 5, $fn = 100) {
    offset(r = 4) {
        circle(25, center = true, $fn = 5);
    }
}
