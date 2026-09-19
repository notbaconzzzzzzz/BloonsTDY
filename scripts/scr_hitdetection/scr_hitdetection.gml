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
						/*
						if (has(atr.amber))
						{
							var i;
							for (i = 0; i < array_length(hitsd[0]); i++)
							{
								if (hitsd[0][i] > dist) break;
							}
							array_insert(hits[0], i, id);
							array_insert(hitsd[0], i, dist);
						}
						else
						{
							var j = clamp(floor(dist) + off, 1, array_length(hitsd) - 1)
							var i = 0;
							for (i = 0; i < array_length(hitsd[j]); i++)
							{
								if (hitsd[j][i] > dist) break;
							}
							array_insert(hits[j], i, id);
							array_insert(hitsd[j], i, dist);
						}
						*/
					}
				}
			}
		}
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
		}
	}
	else
	{
		
	}
	return hit;
}