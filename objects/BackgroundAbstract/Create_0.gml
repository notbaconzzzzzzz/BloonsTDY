/// @description Insert description here
// You can write your code in this editor
RightRate = -1;
DownRate = 0.5;
OrigX = room_width;
OrigY = 0;
BandWidth = 384;
ScrollSpeed = 2;
BandCount = 11;
LightCount = 12;
DarkCount = 0; // 12
hue = random_range(0, 255);
for (var i = 0; i <= BandCount; i++)
{
	hue = (hue + 255 * random_range(0.25, 0.75)) mod 255;
	colors[i] = make_color_hsv(hue, 16, 192);
}
offset = 0;
count = BandCount;
light = true;