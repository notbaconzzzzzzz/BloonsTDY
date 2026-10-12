// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function cleanuppaths()
{
	if (!variable_instance_exists(id, "StartingJunc")) StartingJunc = makesimplejunction(Paths[0]);
	for (var i = 0; i < array_length(Paths); i++)
	{
		if (Paths[i].junc == -1)
		{
			if (i == array_length(Paths) - 1) attachfinishjunction(Paths[i]);
			else attachsimplejunction(Paths[i], Paths[i+1]);
		}
	}
	calculatefinishdistjunc(StartingJunc);
	for (var i = 0; i < array_length(Paths); i++)
	{
		calculatefinishdist(Paths[i])
	}
}

function calculatefinishdist(path)
{
	if (path.finishdist != -1) return path.finishdist;
	if (path.junc == -1) attachfinishjunction(path);
	path.finishdist = calculatefinishdistjunc(path.junc) + path.pathlength;
	return path.finishdist;
}

function calculatefinishdistjunc(junc)
{
	switch (junc.kind)
	{
		case jnc.finish: return 0;
		case jnc.one: return calculatefinishdist(junc.p);
		case jnc.rand: {
			var num = 0;
			for (var i = 0; i < array_length(junc.p); i++)
			{
				num += calculatefinishdist(junc.p);
			}
			num /= array_length(junc.p);
			return num;
		}
	}
	return 0;
}

function createstraightlinepath(startx, starty, endx, endy)
{
	array_push(Paths, makestraightlinepath(startx, starty, endx, endy));
}

function createarclinepath(centerx, centery, centerz, startd, endd)
{
	array_push(Paths, makearclinepath(centerx, centery, centerz, startd, endd));
}

function makestraightlinepath(startx, starty, endx, endy)
{
	var dist = point_distance(startx, starty, endx, endy);
	var dir = darctan2(endy - starty, endx - startx);
	return { kind : pth.line, pathlength : dist, finishdist : -1, junc : -1,
		sx : startx, sy : starty, ex : endx, ey : endy,
		dir : dir};
}

function makearclinepath(centerx, centery, centerz, startd, endd)
{
	var dist = centerz * abs(endd - startd) * pi / 180;
	return { kind : pth.arc, pathlength : dist, finishdist : -1, junc : -1,
		cx : centerx, cy : centery, cz : centerz, sd : startd, ed : endd,
		wise : startd < endd};
}

function attachsimplejunction(startpath, endpath)
{
	var j = makesimplejunction(endpath);
	if (is_array(startpath))
	{
		for (var i = 0; i < array_length(startpath); i++)
		{
			startpath[i].junc = j;
		}
		return;
	}
	startpath.junc = j;
}

function attachfinishjunction(startpath)
{
	var j = makefinishjunction();
	if (is_array(startpath))
	{
		for (var i = 0; i < array_length(startpath); i++)
		{
			startpath[i].junc = j;
		}
		return;
	}
	startpath.junc = j;
}


function makesimplejunction(endpath)
{
	if (is_array(endpath))
	{
		return { kind : jnc.rand, p : endpath };
	}
	return { kind : jnc.one, p : endpath };
}

function makefinishjunction()
{
	return { kind : jnc.finish };
}

enum pth
{
	line,
	arc,
}

enum jnc
{
	finish,
	one,
	rand,
}

function pathmovement(m)
{
	while (m > 0)
	{
		if (path == -1)
		{
			return;
		}
		if (path.pathlength <= patht + m)
		{
			if (path.junc.kind == jnc.finish && variable_instance_exists(id, "rad"))
			{
				if (patht + m < path.pathlength + rad)
				{
					patht += m;
					m = 0;
				}
				else
				{
					PlayerModel.lifes -= BloonData.dmg;
					if (GameManager.TrackLoop)
					{
						path = juncchoosepath(TrackManager.StartingJunc);
						patht = -60-rad;
						m = 0;
					}
					else
					{
						path = -1;
						m = 0;
					}
				}
			}
			else
			{
				m -= path.pathlength - patht;
				patht = 0;
				path = juncchoosepath(path.junc);
			}
		}
		else
		{
			patht += m;
			m = 0;
		}
	}
	setposfrompath();
}

function setposfrompath()
{
	if (path == -1) return;
	var strut = getposfrompath(path, patht);
	x = strut.x;
	y = strut.y;
	dir = strut.dir;
	finishdist = strut.finishdist;
	if (variable_instance_exists(id, "Spd"))
	{
		xv = Spd / 60 * dcos(dir);
		yv = Spd / 60 * dsin(dir);
		y -= posoffset;
	}
}

function getposfrompath(path, patht)
{
	var strut = { x : -999, y : -999, dir : 0, finishdist : 999999 };
	if (path == -1) return strut;
	var t = patht / path.pathlength;
	switch (path.kind)
	{
		case pth.line:
			{
				strut.x = path.sx * (1 - t) + path.ex * t;
				strut.y = path.sy * (1 - t) + path.ey * t;
				strut.dir = path.dir;
			}
			break;
		case pth.arc:
			{
				var d = path.sd * (1 - t) + path.ed * t;
				strut.x = path.cx + path.cz * dcos(d);
				strut.y = path.cy + path.cz * dsin(d);
				if (path.wise) strut.dir = d + 90;
				else strut.dir = d - 90;
			}
			break;
		default:
			return;
	}
	strut.finishdist = path.finishdist - patht;
	return strut;
}

function juncchoosepath(junc)
{
	switch (junc.kind)
	{
		case jnc.finish: return -1;
		case jnc.one: return junc.p;
		case jnc.rand: return junc.p[irandom(array_length(junc.p)-1)];
	}
	return -1;
}

function getrandombobblowposition(cx, cy, cr, finishdist)
{
	var r = sqrt(random_range(1/4/4, 1)) * cr;
	var d = random(360);
	var sx = cx + r * dcos(d);
	var sy = cy + r * dsin(d);
	return getbobblowposition(sx, sy, min(finishdist - cr, finishdist / 2), max(finishdist + cr, finishdist * 2), max(cr, r + cr / 8), cx, cy, min(cr - r, cr - cr / 8), cr / 8);
}

function getbobblowposition(sx, sy, minfinishdist, maxfinishdist, maxrad, cx, cy, minrad2, tolerance)
{
	var baseweights = [];
	var totalweight = 0;
	for (var i = 0; i < array_length(TrackManager.Paths); i++)
	{
		var path = TrackManager.Paths[i];
		var weight = path.pathlength;
		if (path.finishdist < minfinishdist) weight = 0;
		else if (path.finishdist - path.pathlength > maxfinishdist) weight = 0;
		baseweights[i] = weight;
		totalweight += weight;
	}
	var bestpath = -1;
	var bestt = 0;
	var bestdist = 999999;
	var tries = 0;
	var intolerant = 0;
	while (tries < 100 && intolerant < 10)
	{
		tries++;
		var pickpath = random(totalweight);
		if (pickpath >= totalweight) continue;
		for (var i = 0; i < array_length(baseweights); i++)
		{
			pickpath -= baseweights[i];
			if (pickpath < 0)
			{
				pickpath = TrackManager.Paths[i];
				break;
			}
		}
		var pickt = random(pickpath.pathlength);
		var strut = getposfrompath(pickpath, pickt);
		if (strut.finishdist < minfinishdist || strut.finishdist > maxfinishdist) continue;
		var dist = point_distance(sx, sy, strut.x, strut.y);
		var dist2 = point_distance(cx, cy, strut.x, strut.y);
		if (dist > maxrad || dist2 < minrad2) continue;
		if (dist >= bestdist - tolerance)
		{
			intolerant++;
			continue;
		}
		bestpath = pickpath;
		bestt = pickt;
		bestdist = dist;
	}
	if (bestpath == -1) bestpath = juncchoosepath(TrackManager.StartingJunc);
	return { path : bestpath, t : bestt, x : sx, y : sy };
}

function calculatebloonregion(_x, _y, ismoab = false)
{
	if (ismoab) return 0;
	return 1 + clamp(floor(_x / 360), 0, 3) + 4 * clamp(floor(_y / 360), 0, 2);
}

function drawpaths(w)
{
	for (var i = 0; i < array_length(Paths); i++)
	{
		var p = Paths[i];
		switch (p.kind)
		{
			case pth.line:
				{
					var dx = p.ex - p.sx;
					var dy = p.ey - p.sy;
					var d = dy;
					dy = dx;
					dx = -d;
					d = sqrt(sqr(dx) + sqr(dy));
					dx /= d;
					dy /= d;
					dx *= w/2;
					dy *= w/2;
					draw_primitive_begin(pr_trianglestrip);
					draw_vertex(p.sx + dx, p.sy + dy);
					draw_vertex(p.sx - dx, p.sy - dy);
					draw_vertex(p.ex + dx, p.ey + dy);
					draw_vertex(p.ex - dx, p.ey - dy);
					draw_primitive_end();
					draw_circle(p.sx - 0.5, p.sy - 0.5, w/2 - 1, false);
					draw_circle(p.ex - 0.5, p.ey - 0.5, w/2 - 1, false);
				}
				break;
			case pth.arc:
				{
					var pieces = ceil(min(48, max(abs(p.ed - p.sd) / 7.5, p.pathlength / 30)));
					draw_primitive_begin(pr_trianglestrip);
					for (var j = 0; j <= pieces; j++)
					{
						var d = p.sd + clamp(p.ed - p.sd, -360, 360) * j / pieces;
						draw_vertex(p.cx + (p.cz - w/2) * dcos(d), p.cy + (p.cz - w/2) * dsin(d));
						draw_vertex(p.cx + (p.cz + w/2) * dcos(d), p.cy + (p.cz + w/2) * dsin(d));
					}
					draw_primitive_end();
					if (abs(p.ed - p.sd) < 360)
					{
						draw_circle(p.cx + p.cz * dcos(p.sd) - 0.5, p.cy + p.cz * dsin(p.sd) - 0.5, w/2 - 1, false);
						draw_circle(p.cx + p.cz * dcos(p.ed) - 0.5, p.cy + p.cz * dsin(p.ed) - 0.5, w/2 - 1, false);
					}
				}
				break;
		}
	}
}