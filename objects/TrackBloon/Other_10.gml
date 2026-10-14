/// @description Insert description here
// You can write your code in this editor
event_inherited();
if (typeIndex == -1) return;
if (variable_instance_exists(id, "blowtime") && blowtime > 0)
{
	blowt++;
	var t = blowt / blowtime;
	x = bezier(blowx0, blowx1, blowx1, blowx2, t);
	y = bezier(blowy0, blowy1, blowy1, blowy2, t);
	xv = bezier3(blowx1 - blowx0, 0, blowx2 - blowx1, t) / blowtime;
	xy = bezier3(blowy1 - blowy0, 0, blowy2 - blowy1, t) / blowtime;
	if (blowt >= blowtime)
	{
		blowtime = 0;
	}
}
else
{
	pathmovement(Spd / 60);
	if (path == -1)
	{
		if (isCluster)
		{
			var total = 0;
			var node = bloonGroups.l;
			while (!is_instanceof(node, LinkedList))
			{
				var group = node.obj;
				total += group.BloonData.dmg * group.Count;
				node = node.l;
			}
			PlayerModel.lifes -= total;
		}
		else PlayerModel.lifes -= BloonData.dmg;
		instance_destroy();
		hp = 0;
		typeIndex = -1;
		return;
	}
}
if (bloonRegionNode != -1 && !is_undefined(bloonRegionNode))
{
	var newBloonRegion = calculatebloonregion(x, y, IsMoab);
	if (newBloonRegion != bloonRegion)
	{
		bloonRegion = newBloonRegion;
		bloonRegionNode.Migrate(GameManager.bloonRegions[bloonRegion]);
	}
}