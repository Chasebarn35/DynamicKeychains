font = "Liberation Mono:style=bold";
letter_size = 40;
height = 20;
hdt=1.5;
border = 6.5;
fString = "ALAN";
bString = "TH23";

textlen = max(len(fString),len(bString));

box_width = letter_size*textlen*.75;
box_height = letter_size*1.5;

module triangle(zX=0,zY=0,x,y,sc,h){
	polygon(points = [[zX,zY],[x*sc,zY],[zX,y*sc]]);
}

union(){
	difference(){
		union(){
			linear_extrude(height){
				fillet2d(8)
				rounding2d(4)
				union(){
				triangle(0,0,-1,-1,box_height/2,height);
				triangle(0,0,-1,1,box_height/2,height);
				translate([box_width/2,box_height/2 - border,0])
					square([box_width,2*border],center=true);
				translate([box_width/2,- box_height/2 + border,0])
					square([box_width,2*border],center=true);
				translate([box_width,0,0])
					square([2*border,box_height],center=true);
				}

			}
		}
		linear_extrude(height,10){
			translate([-box_height/4,0,0])
				circle(r=5,$fn=25);
		}
	}
	translate([0,0,height/2]){
		linear_extrude(hdt){
			translate([box_width/2,0,0])
			square([box_width,box_height],center=true);
		}
	translate([0,0,hdt])
	color([1,0,0])
	linear_extrude(height/2 - hdt,10){
		rounding2d(1)
		text(bString,size=letter_size,font=font,halign="left",valign="center",$fn=64,spacing=.85);
	}
	mirror([0,0,1])
	color([0,0,1])
	linear_extrude(height/2,10){
		mirror([1,0,0])
		rounding2d(1)
		text(fString,size=letter_size,font=font,halign="right",valign="center",$fn=64,spacing=.85);
	}
	}
}


module fillet2d(r) {
    offset(r = -r) offset(delta = r) children(0);
}

module rounding2d(r) {
    offset(r = r) offset(delta = -r) children(0);
}

