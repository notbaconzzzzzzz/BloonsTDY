// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function hitdetection(cx, cy, cr, ordinal, func)
{
	var hits = [];
	var hitsd = [];
	//var off = 50;
	if (ordinal == "radial" || true)
	{
		/*
		off = 50;
		for (var i = 0; i <= ceil(cr); i++)
		{
			hits[i] = [];
			hitsd[i] = [];
		}
		for (var i = 0; i <= 1; i++)
		{
			hits[i] = [];
			hitsd[i] = [];
		}
		off += 1;*/
		for (var reg = 0; reg <= 12; reg++)
		{
			var regx = ((reg - 1) mod 4) * 360;
			var regy = floor((reg - 1) / 4) * 360;
			var regw = 360;
			var regh = 360;
			if (reg != 0)
			{
				if (regx > cx + cr + 34) continue;
				if (regy > cy + cr + 34) continue;
				if (regx + regw < cx - cr - 34) continue;
				if (regy + regh < cy - cr - 34) continue;
			}
			var node = GameManager.bloonRegions[reg].r;
			while (!is_instanceof(node, LinkedList))
			{
				with (node.obj)
				{
					if (hp > 0 && abs(x - cx) <= rad + cr && abs(y - cy) <= rad + cr)
					{
						var dist = sqrt(sqr(x - cx) + sqr(y - cy)) - rad;
						if (dist <= cr)
						{
							var flag = true;
							for (var i = 0; i < array_length(parentInstances); i++)
							{
								if (array_contains(other.hitInstances, parentInstances[i]))
								{
									flag = false;
									break;
								}
							}
							if (flag)
							{
								if (has(Atrs, atr.amber)) dist -= 100000;
								var i;
								for (i = 0; i < array_length(hitsd); i++)
								{
									if (hitsd[i] > dist) break;
								}
								array_insert(hits, i, id);
								array_insert(hitsd, i, dist);
							}
						}
					}
				}
				node = node.r;
			}
		}
		/*
		with (Bloon)
		{
			if (hp > 0 && abs(x - cx) <= rad + cr && abs(y - cy) <= rad + cr)
			{
				var dist = sqrt(sqr(x - cx) + sqr(y - cy)) - rad;
				if (dist <= cr)
				{
					var flag = true;
					for (var i = 0; i < array_length(parentInstances); i++)
					{
						if (array_contains(other.hitInstances, parentInstances[i]))
						{
							flag = false;
							break;
						}
					}
					if (flag)
					{
						if (has(Atrs, atr.amber)) dist -= 100000;
						var i;
						for (i = 0; i < array_length(hitsd); i++)
						{
							if (hitsd[i] > dist) break;
						}
						array_insert(hits, i, id);
						array_insert(hitsd, i, dist);
					}
				}
			}
		}*/
	}
	else
	{
		
	}
	if (func != -1)
	{
		for (var i = 0; i < array_length(hits); i++)
		{
			var inst = hits[i];
			array_push(hitInstances, inst);
			if (func(inst)) break;
		}
	}
}

function bloondetection(cx, cy, cr, ordinal, canhitcamo)
{
	var hit = noone;
	var hitd = 999999;
	//var off = 50;
	if (ordinal == "radial" || true)
	{
		for (var reg = 0; reg <= 12; reg++)
		{
			var regx = ((reg - 1) mod 4) * 360;
			var regy = floor((reg - 1) / 4) * 360;
			var regw = 360;
			var regh = 360;
			if (reg != 0)
			{
				if (regx > cx + cr + 34) continue;
				if (regy > cy + cr + 34) continue;
				if (regx + regw < cx - cr - 34) continue;
				if (regy + regh < cy - cr - 34) continue;
			}
			var node = GameManager.bloonRegions[reg].r;
			while (!is_instanceof(node, LinkedList))
			{
				with (node.obj)
				{
					if (hp > 0 && abs(x - cx) <= rad + cr && abs(y - cy) <= rad + cr)
					{
						var dist = sqrt(sqr(x - cx) + sqr(y - cy)) - rad;
						if (dist <= cr)
						{
							var flag = true;
							if (flag)
							{
								if (canhitcamo || !has(Atrs, atr.camo))
								{
									dist = finishdist;
									if (dist < hitd)
									{
										hit = id;
										hitd = dist;
									}
								}
							}
						}
					}
				}
				node = node.r;
			}
		}
		/*
		with (Bloon)
		{
			if (hp > 0 && abs(x - cx) <= rad + cr && abs(y - cy) <= rad + cr)
			{
				var dist = sqrt(sqr(x - cx) + sqr(y - cy)) - rad;
				if (dist <= cr)
				{
					var flag = true;
					if (flag)
					{
						if (canhitcamo || !has(Atrs, atr.camo))
						{
							dist = finishdist;
							if (dist < hitd)
							{
								hit = id;
								hitd = dist;
							}
						}
					}
				}
			}
		}*/
	}
	else
	{
		
	}
	return hit;
}