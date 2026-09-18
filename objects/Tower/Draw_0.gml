/// @description Insert description here
// You can write your code in this editor
draw_set_circle_precision(48);
if ((PlayerModel.hoveredTower == id || PlayerModel.selectedTower == id) && !PlayerModel.tryingtobuytower)
{
	draw_set_color(c_black);
	draw_set_alpha(0.1);
	draw_circle(x, y, detectionrange, false);
}
else if (PlayerModel.showRanges)
{
	draw_set_color(c_black);
	draw_set_alpha(0.05);
	draw_circle(x, y, detectionrange, false);
}
draw_set_alpha(1);