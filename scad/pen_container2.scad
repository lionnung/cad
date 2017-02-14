str1 = "素胚勾勒出青花筆鋒濃轉淡，瓶身描繪的牡丹一如妳初妝，冉冉檀香透過窗心事我了然，宣紙上走筆至此擱一半。釉色渲染仕女圖韻味被私藏，而妳嫣然的一笑如含苞待放，妳的美一縷飄散去到我去不了的地方。天青色等煙雨而我在等妳，炊煙裊裊昇起隔江千萬里，在瓶底書漢隸仿前朝的飄逸，就當我為遇見妳伏筆。天青色等煙雨而我在等妳，月色被打撈起暈開了結局，如傳世的青花瓷自顧自美麗妳眼帶笑意。[農奇威]";
str2 = "色白花青的錦鯉躍然於碗底，臨摹宋體落款時卻惦記著妳，妳隱藏在窯燒裡千年的秘密，極細膩猶如繡花針落地。簾外芭蕉惹驟雨門環惹銅綠，而我路過那江南小鎮惹了妳，在潑墨山水畫裡妳從墨色深處被隱去。天青色等煙雨而我在等妳，炊煙裊裊昇起隔江千萬里，在瓶底書漢隸仿前朝的飄逸，就當我為遇見妳伏筆。天青色等煙雨而我在等妳，月色被打撈起暈開了結局，如傳世的青花瓷自顧自美麗妳眼帶笑意。[農奇威]";

module draw_circle_text(radius, font_num, font_sz, font_z, str) {
	step = 360 / font_num;
	len = len(str);

	for (i = [0 : len]) {
	    translate([radius * cos(360 - i * step), radius * sin(360 - i * step), font_z + i * (font_sz / (font_num - 4))])
	        rotate([90, 0, 360 - i * step + 90])
	        	linear_extrude(height = 10, center = true, twist = 0)
					text(str[len - i - 1], font = "標楷體", size = font_sz, valign = "center", halign = "center");
	}
}

radius = 35;
circumference = 2 * PI * radius;
font_num = 18;
font_sz = circumference / font_num - 5;

intersection() {
	difference() {
		union() {
			cylinder(h = 110, r = radius, $fn = 100);
			draw_circle_text(radius, font_num, font_sz, 8, str1);
		}
	    translate([0, 0, 1])
	   		cylinder(h = 110, r = radius - 2, $fn = 100);
	}
	cylinder(h = 110, r = radius + 1, $fn = 100);
}

cylinder(h = 2, r = radius + 1, $fn = 100);
