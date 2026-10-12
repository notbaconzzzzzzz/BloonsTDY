function fixang(num)
{
	if (num < -180) return (num + 180) % 360 + 180;
	return (num + 180) % 360 - 180;
}


function bezier(x1, x2, x3, x4, blend)
{
	return lerp(bezier3(x1, x2, x3, blend), bezier3(x2, x3, x4, blend), blend);
}

function bezier3(x1, x2, x3, blend)
{
	return lerp(lerp(x1, x2, blend), lerp(x2, x3, blend), blend);
}