/// @description Insert description here
// You can write your code in this editor
Paths = [];
createstraightlinepath(0*60, 8*60, 17*60, 8*60);
createarclinepath(17*60, 11*60, 3*60, -90, 90);
createstraightlinepath(17*60, 14*60, 11*60, 14*60);
createarclinepath(11*60, 11*60, 3*60, 90, 180);
createstraightlinepath(8*60, 11*60, 8*60, 5*60);
createarclinepath(11*60, 5*60, 3*60, 180, 360);
createstraightlinepath(14*60, 5*60, 14*60, 18*60);
cleanuppaths();
needsredraw = true;