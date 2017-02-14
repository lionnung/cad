function turtle(x, y, angle) = [[x, y], angle];

function get_x(turtle) = turtle[0][0];
function get_y(turtle) = turtle[0][1];
function get_xy(turtle) = turtle[0];
function get_angle(turtle) = turtle[1];

function set_point(turtle, point) = [point, get_angle(turtle)];

function set_x(turtle, x) = [[x, get_y(turtle)], get_angle(turtle)];
function set_y(turtle, y) = [[get_x(turtle), y], get_angle(turtle)];
function set_angle(turtle, angle) = [get_xy(turtle), angle];

function forward(turtle, leng) =
    turtle(
    	get_x(turtle) + leng * cos(get_angle(turtle)),
    	get_y(turtle) + leng * sin(get_angle(turtle)),
    	get_angle(turtle)
    );

function turn(turtle, angle) = [get_xy(turtle), get_angle(turtle) + angle];

module line(point1, point2, width = 1, cap_round = true) {
	angle = 90 - atan((point2[1] - point1[1]) / (point2[0] - point1[0]));
	offset_x = 0.5 * width * cos(angle);
	offset_y = 0.5 * width * sin(angle);

	offset1 = [-offset_x, offset_y];
	offset2 = [offset_x, -offset_y];

	if (cap_round) {
		translate(point1) circle(d = width, $fn = 24);
		translate(point2) circle(d = width, $fn = 24);
	}

	polygon(points = [
		point1 + offset1, point2 + offset1,
		point2 + offset2, point1 + offset2
	]);
}

module polyline(points, width = 1, cap_round = true) {
	module polyline_inner(points, index) {
		if (index < len(points)) {
			line(points[index - 1], points[index], width, cap_round);
			polyline_inner(points, index + 1);
		}
	}

	polyline_inner(points, 1);
}

/*
module turtle_spiral(t_before, times, side_leng, angle, width) {
    if (times != 0) {
        t_after = forward(turn(t_before, angle), side_leng);
        polyline([get_xy(t_before), get_xy(t_after)], width);
        turtle_spiral(t_after, times - 1, side_leng, angle, width);
    }
}

side_leng = 10;
angle = 144;
width = 1;
times = 5;

turtle_spiral(turtle(0, 0, 0), times, side_leng, angle, width);
*/

/*
module turtle_spiral(t_before, side_leng, d_step, min_leng, angle, width) {
    if (side_leng > min_leng) {
        t_after = forward(turn(t_before, angle), side_leng);
        polyline([get_xy(t_before), get_xy(t_after)], width);
        turtle_spiral(t_after, side_leng - d_step, d_step, min_leng, angle, width);
    }
}

side_leng = 50;
d_step = 1;
min_leng = 1;
angle = 90;
width = 1;

turtle_spiral(turtle(0, 0, 0), side_leng, d_step, min_leng, angle, width);
*/

/*
module triangle(t, side_leng, width) {
    angle = 120;

    t_p1 = forward(t, side_leng);
    polyline([get_xy(t), get_xy(t_p1)], width);

    t_p2 = forward(turn(t_p1, angle), side_leng);
    polyline([get_xy(t_p1), get_xy(t_p2)], width);

    t_p3 = forward(turn(t_p2, angle), side_leng);
    polyline([get_xy(t_p2), get_xy(t_p3)], width);
}

module concentric_triangles(t, side_len, len_limit, width) {
    if (side_len >= len_limit) {
        triangle(t, side_len, width);
        next_t = turn(forward(t, side_len / 2), 60);
        concentric_triangles(next_t, side_len / 2, len_limit, width);
    }
}

side_len = 50;
len_limit = 4;
width = 1;
t = turtle(0, 0, 0);

concentric_triangles(t, side_len, len_limit, width);
*/

module triangle(t, side_leng, width) {
    angle = 120;

    t_p1 = forward(t, side_leng);
    polyline([get_xy(t), get_xy(t_p1)], width);

    t_p2 = forward(turn(t_p1, angle), side_leng);
    polyline([get_xy(t_p1), get_xy(t_p2)], width);

    t_p3 = forward(turn(t_p2, angle), side_leng);
    polyline([get_xy(t_p2), get_xy(t_p3)], width);
}

module concentric_triangles(t, side_len, len_limit, width) {
    if (side_len >= len_limit) {
        triangle(t, side_len, width);
        next_t = turn(forward(t, side_len / 2), 60);
        triangle(next_t, side_len / 2, width);

        concentric_triangles(t, side_len / 2, len_limit, width);

        next_t2 = forward(t, side_len / 2);
        concentric_triangles(next_t2, side_len / 2, len_limit, width);

        next_t3 = turn(forward(turn(t, 60), side_len / 2), -60);
        concentric_triangles(next_t3, side_len / 2, len_limit, width);
    }
}

side_len = 50;
len_limit = 4;
width = 1;
t = turtle(0, 0, 0);

concentric_triangles(t, side_len, len_limit, width);
