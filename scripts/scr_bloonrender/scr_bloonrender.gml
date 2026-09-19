// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function generatebloonsprite(spriteIndex)
{
	if (!surface_exists(surf))
	{
	    surf = surface_create(800, 800);
	}
	if (!surface_exists(surf2))
	{
	    surf2 = surface_create(800, 800);
	}
	if (ds_map_exists(BloonSprites, spriteIndex))
	{
		sprite_delete(BloonSprites[spriteIndex]);
	}
	var bloonInd = extracttypefromspriteindex(spriteIndex);
	var bloonData = DataManager.BloonData[bloonInd];
	var mods = spriteIndex & atr.spriteindexed;
	mods |= bloonData.atrs & (~atr.spriteindexed);
	var bloonBase = BloonBase;
	var sizeMultipier = 1;
	var baseSize = 128;
	var baseXOrig = 64;
	var baseYOrig = 64;
	var baseXExtra = 0;
	var baseYExtra = 102;
	var overlayStretchX = 1;
	var overlayStretchY = 1;
	var overlayRotate = 0;
	var blimp = false;
	if (has(mods, atr.moab) && !(bloonData.type == "bob" || bloonData.type == "bobmega" || bloonData.type == "honey1" || bloonData.type == "honey2" || bloonData.type == "honey3" || bloonData.type == "honey4" || bloonData.type == "honey5"))
	{
		blimp = true;
	}
	if (blimp)
	{
		bloonBase = BloonBaseMoab;
		sizeMultipier = 1;
		baseSize = 500;
		baseXOrig = 325;
		baseYOrig = 200;
		baseXExtra = -50;
		baseYExtra = 200;
		overlayStretchX = 400 / 128;
		overlayStretchY = 275 / 64;
		overlayRotate = -90;
	}
	else if (has(mods, atr.regrow))
	{
		bloonBase = BloonBaseRegrow;
		sizeMultipier = 160/128;
		baseSize = 160;
		baseXOrig = 90;
		baseYOrig = 60;
		baseXExtra = 0;
		baseYExtra = 100;
		overlayStretchX = 180 / 128;
		overlayStretchY = 1;
		overlayRotate = 0;
	}
	for (var hpstate = 0; hpstate < 5; hpstate += 1)
	{
		drawbloonsprite(spriteIndex, hpstate);
		
		surface_set_target(surf2);
		draw_clear_alpha(c_black, 0);
		var s = bloonData.size;
		s *= sizeMultipier;
		gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
		better_scaling_draw_surface(surf, 400 - 400 * s/baseSize, 400 - 400 * s/baseSize, s/baseSize, s/baseSize, 0, c_white, 1);
		surface_reset_target();
		if (hpstate = 0)
		{
			BloonSprites[? spriteIndex] = sprite_create_from_surface(surf2, 400 - ceil(s*baseXOrig/baseSize), 400 - ceil(s*baseYOrig/baseSize), 2 * ceil(s*baseXOrig/baseSize) + ceil(s*baseXExtra/baseSize), ceil(s*baseYOrig/baseSize) + ceil(s*baseYExtra/baseSize), false, false, ceil(s*baseXOrig/baseSize), ceil(s*baseYOrig/baseSize));
			sprite_set_speed(BloonSprites[? spriteIndex], 0, spritespeed_framespersecond);
		}
		else sprite_add_from_surface(BloonSprites[? spriteIndex], surf2, 400 - ceil(s*baseXOrig/baseSize), 400 - ceil(s*baseYOrig/baseSize), 2 * ceil(s*baseXOrig/baseSize) + ceil(s*baseXExtra/baseSize), ceil(s*baseYOrig/baseSize) + ceil(s*baseYExtra/baseSize), false, false);
		gpu_set_blendmode(bm_normal);
	}
	return BloonSprites[? spriteIndex];
}

function drawbloonsprite(spriteIndex, hpstate = 0, onlysurf2 = false)
{
	var bloonInd = extracttypefromspriteindex(spriteIndex);
	var bloonData = DataManager.BloonData[bloonInd];
	var mods = spriteIndex & atr.spriteindexed;
	mods |= bloonData.atrs & (~atr.spriteindexed);
	var moab = has(mods, atr.moab);
	var purple = has(mods, atr.purple);
	var black = has(mods, atr.black) && bloonData.type != "black";
	var white = has(mods, atr.white) && bloonData.type != "white";
	var zebra = bloonData.type == "zebra";
	var rainbow = bloonData.type == "rainbow" || bloonData.type == "honey5";
	var camo = has(mods, atr.camo);
	var camoShades = [];
	if (camo)
	{
		// 93
		camoShades[0] = 0.14; // 80
		camoShades[1] = 0.36; // 68
		camoShades[2] = 0.45; // 50
		camoShades[3] = -0.45; // 100, 93 > 53
		camoShades[4] = 0;
		if (rainbow)
		{
			camoShades[0] = 0.27;
			camoShades[1] = 0.36;
			camoShades[2] = 0.45;
			camoShades[3] = 0.45;
		}
		else if (bloonData.type == "green")
		{
			camoShades[4] = camoShades[0];
			camoShades[0] = 0;
		}
		else if (bloonData.type == "pink")
		{
			camoShades[0] = 1.2;
			camoShades[1] = 1.35;
		}
		else if (bloonData.type == "black")
		{
			camoShades[0] = -0.1;
			camoShades[1] = -0.24;
			camoShades[2] = -0.3;
			camoShades[3] = -0.45;
		}
	}
	var fort = has(mods, atr.fort); // not implemented
	var latex = has(mods, atr.latex);
	var aqua = has(mods, atr.aqua);
	var lead = has(mods, atr.lead);
	var ice = has(mods, atr.ice);
	var ceram = has(mods, atr.ceramic);
	var titan = has(mods, atr.titan);
	var crystal = has(mods, atr.crystal);
	var amber = has(mods, atr.amber);
	var hah = has(mods, atr.hah);
	var kant = has(mods, atr.kant);
	var bob = has(mods, atr.bob);
	var bloonBase = BloonBase;
	var sizeMultipier = 1;
	var baseSize = 128;
	var baseXOrig = 64;
	var baseYOrig = 64;
	var baseXExtra = 0;
	var baseYExtra = 102;
	var overlayStretchX = 1;
	var overlayStretchY = 1;
	var overlayRotate = 0;
	if (crystal) bloonBase = BloonBaseCrystal;
	var blimp = false;
	if (has(mods, atr.moab) && !(bloonData.type == "bob" || bloonData.type == "bobmega" || bloonData.type == "honey1" || bloonData.type == "honey2" || bloonData.type == "honey3" || bloonData.type == "honey4" || bloonData.type == "honey5"))
	{
		blimp = true;
	}
	if (blimp)
	{
		bloonBase = BloonBaseMoab;
		sizeMultipier = 1;
		baseSize = 500;
		baseXOrig = 325;
		baseYOrig = 200;
		baseXExtra = -50;
		baseYExtra = 200;
		overlayStretchX = 400 / 128;
		overlayStretchY = 275 / 64;
		overlayRotate = -90;
		if (crystal) bloonBase = BloonBaseMoabCrystal;
	}
	else if (has(mods, atr.regrow))
	{
		bloonBase = BloonBaseRegrow;
		sizeMultipier = 160/128;
		baseSize = 160;
		baseXOrig = 90;
		baseYOrig = 60;
		baseXExtra = 0;
		baseYExtra = 100;
		overlayStretchX = 180 / 128;
		overlayStretchY = 1;
		overlayRotate = 0;
		if (crystal) bloonBase = BloonBaseCrystalRegrow;
	}
	
	if (onlysurf2) surface_set_target(surf2);
	else surface_set_target(surf);
	draw_clear_alpha(c_black, 0);
	draw_set_color(c_white);
	var col = 0;
	if (rainbow)
	{
		col = make_color_hsv(0, 0, 128);
		draw_sprite_ext(bloonBase, 0, 400, 400, 1, 1, 0, col, 1);
		col = make_color_hsv(0, 0, 255);
		draw_sprite_ext(bloonBase, 1, 400, 400, 1, 1, 0, col, 1);
		gpu_set_colorwriteenable(true, true, true, false);
		gpu_set_blendmode_ext(bm_dest_color, bm_inv_src_alpha);
		for (var i = 0; i < 6; i++)
		{
			var hsv = bloonData.colors[i % array_length(bloonData.colors)];
			col = make_color_hsv(hsv.h/360*255, hsv.s, hsv.v);
			draw_sprite_ext(RainbowPattern, i, 400, 400, overlayStretchX, overlayStretchY, overlayRotate, col, 1);
		}
		gpu_set_blendmode(bm_normal);
		gpu_set_colorwriteenable(true, true, true, true);
	}
	else
	{
		col = make_color_hsv(bloonData.colors[0].h/360*255, bloonData.colors[0].s, bloonData.colors[0].v/2);
		draw_sprite_ext(bloonBase, 0, 400, 400, 1, 1, 0, col, 1);
		col = make_color_hsv(bloonData.colors[0].h/360*255, bloonData.colors[0].s, bloonData.colors[0].v);
		draw_sprite_ext(bloonBase, 1, 400, 400, 1, 1, 0, col, 1);
	}
	
	
	if (amber)
	{
		col = make_color_hsv((bloonData.colors[0].h + 15)/360*255, bloonData.colors[0].s * (255 - bloonData.colors[0].v) / 255, bloonData.colors[0].v / 2 + 255/2);
		gpu_set_colorwriteenable(true, true, true, false);
		gpu_set_blendmode_ext(bm_src_alpha, bm_one);
		draw_sprite_ext(AmberPattern, 0, 400, 400, overlayStretchX, overlayStretchY, overlayRotate, col, 0.333);
		gpu_set_blendmode(bm_normal);
		gpu_set_colorwriteenable(true, true, true, true);
	}
	
	
	if (camo)
	{
		gpu_set_colorwriteenable(true, true, true, false);
		for (var i = 0; i < 5; i++)
		{
			var shade = camoShades[i];
			if (shade == 0) continue;
			if (shade > 1)
			{
				// h: 354, 332, 341
				// s: 71, 92, 79
				// v: 94, 78(84), 69
				//      (1.2) (1.35)
				col = make_color_hsv((bloonData.colors[0].h - 75 * (1.5 - shade))/360*255, bloonData.colors[0].s /*255 - (255 - bloonData.colors[0].s) * (shade - 1.1) * 2.7*/, bloonData.colors[0].v / shade / 1.06);
				draw_sprite_ext(CamoPattern, i, 400, 400, overlayStretchX, overlayStretchY, overlayRotate, col, 1);
			}
			else if (shade > 0)
			{
				draw_sprite_ext(CamoPattern, i, 400, 400, overlayStretchX, overlayStretchY, overlayRotate, c_black, shade);
			}
			else if (shade < 0)
			{
				draw_sprite_ext(CamoPattern, i, 400, 400, overlayStretchX, overlayStretchY, overlayRotate, c_white, -shade);
			}
		}
		gpu_set_colorwriteenable(true, true, true, true);
	}
	
	
	if (bob)
	{
		gpu_set_colorwriteenable(true, true, true, false);
		gpu_set_blendmode(bm_normal);
		draw_sprite_ext(BobPattern, 0, 400, 400, overlayStretchX/2, overlayStretchY/2, overlayRotate, c_black, 1);
		gpu_set_colorwriteenable(true, true, true, true);
	}
	if (zebra)
	{
		gpu_set_colorwriteenable(true, true, true, false);
		gpu_set_blendmode_ext(bm_src_alpha, bm_inv_src_alpha);
		col = make_color_hsv(0/360*255, 0, 16);
		draw_sprite_ext(ZebraPattern, 0, 400, 400, overlayStretchX, overlayStretchY, overlayRotate, col, 1);
		gpu_set_colorwriteenable(true, true, true, true);
		gpu_set_blendmode(bm_normal);
	}
	else if (black && white)
	{
		gpu_set_colorwriteenable(true, true, true, false);
		gpu_set_blendmode_ext(bm_src_alpha, bm_inv_src_alpha);
		col = make_color_hsv(0/360*255, 0, 0);
		draw_sprite_ext(ZebraPattern, 1, 400, 400, overlayStretchX, overlayStretchY, overlayRotate, col, 0.8);
		col = make_color_hsv(0/360*255, 0, 255);
		draw_sprite_ext(ZebraPattern, 2, 400, 400, overlayStretchX, overlayStretchY, overlayRotate, col, 0.8);
		gpu_set_colorwriteenable(true, true, true, true);
		gpu_set_blendmode(bm_normal);
	}
	else if (black)
	{
		gpu_set_colorwriteenable(true, true, true, false);
		gpu_set_blendmode_ext(bm_src_alpha, bm_inv_src_alpha);
		col = make_color_hsv(0/360*255, 0, 0);
		draw_sprite_ext(ZebraPattern, 1, 400, 400, overlayStretchX, overlayStretchY, overlayRotate, col, 0.8);
		gpu_set_colorwriteenable(true, true, true, true);
		gpu_set_blendmode(bm_normal);
	}
	else if (white)
	{
		gpu_set_colorwriteenable(true, true, true, false);
		gpu_set_blendmode_ext(bm_src_alpha, bm_inv_src_alpha);
		col = make_color_hsv(0/360*255, 0, 255);
		draw_sprite_ext(ZebraPattern, 1, 400, 400, overlayStretchX, overlayStretchY, overlayRotate, col, 0.8);
		gpu_set_colorwriteenable(true, true, true, true);
		gpu_set_blendmode(bm_normal);
	}



	if (zebra)
	{
		col = make_color_hsv(0/360*255, 0, 16/2);
		draw_sprite_ext(bloonBase, 3, 400, 400, 1, 1, 0, col, 1);
	}
	
	
	gpu_set_colorwriteenable(true, true, true, false);
	if (kant)
	{
		gpu_set_blendmode_ext(bm_zero, bm_inv_src_alpha);
		draw_sprite_ext(KantPattern, 0, 400, 400, overlayStretchX * 128 / 400, overlayStretchY * 64 / 275, overlayRotate + 90, c_black, 0.1);
		gpu_set_blendmode(bm_normal);
	}
	if (aqua)
	{
		col = make_color_rgb(0, 0, 128);
		gpu_set_blendmode_ext(bm_src_alpha, bm_inv_src_alpha);
		draw_sprite_ext(AquaPattern, 0, 400, 400, overlayStretchX, overlayStretchY, overlayRotate, col, camo ? 0.4 : 0.2);
		gpu_set_blendmode(bm_normal);
	}
	if (ceram)
	{
		col = make_color_hsv(bloonData.colors[0].h/360*255, bloonData.colors[0].s, bloonData.colors[0].v/2);
		gpu_set_blendmode(bm_normal);
		draw_sprite_ext(CeramicPattern, 0, 400, 400, overlayStretchX, overlayStretchY, overlayRotate, col, 1);
	}
	if (lead)
	{
		gpu_set_blendmode_ext(bm_src_alpha, bm_inv_src_alpha);
		draw_sprite_ext(LeadPattern, 0, 400, 400, overlayStretchX, overlayStretchY, overlayRotate, c_black, 0.5);
		gpu_set_blendmode(bm_normal);
	}
	if (titan)
	{
		gpu_set_blendmode_ext(bm_src_alpha, bm_inv_src_alpha);
		draw_sprite_ext(TitanPattern, 0, 400, 400, overlayStretchX, overlayStretchY, overlayRotate, c_black, 0.5);
		gpu_set_blendmode(bm_normal);
	}
	if (ice)
	{
		col = make_color_rgb(239, 255, 255);
		gpu_set_blendmode_ext(bm_src_alpha, bm_inv_src_alpha);
		draw_sprite_ext(IcePattern, 0, 400, 400, overlayStretchX, overlayStretchY, overlayRotate, col, 0.5);
		gpu_set_blendmode(bm_normal);
	}
	if (hah)
	{
		gpu_set_blendmode(bm_normal);
		draw_sprite_ext(HahPattern, 0, 400, 400, overlayStretchX * 128 / 400, overlayStretchY * 64 / 275, overlayRotate + 90, c_red, 0.5);
	}
	gpu_set_colorwriteenable(true, true, true, true);



	if (purple)
	{
		//col = make_color_hsv(bloonData.colors[1].h/360*255, bloonData.colors[1].s, bloonData.colors[1].v);
		var h = ((bloonData.colors[0].h - 80 + 360 + 60 - 240) % 120) - 60 + 240;
		var v = min(bloonData.colors[0].v / 2 + 162, 255);
		var s = max(bloonData.colors[0].s - 16, 0);
		col = make_color_hsv(h/360*255, s, v);
		draw_sprite_ext(bloonBase, 2, 400, 400, 1, 1, 0, col, 1);
	}
	else if (rainbow && !onlysurf2)
	{
		// IMPLEMENT this later, needs to redraw the outline to cover up overlays, but isn't too important
	}
	else
	{
		col = make_color_hsv(bloonData.colors[0].h/360*255, bloonData.colors[0].s, bloonData.colors[0].v/2);
		draw_sprite_ext(bloonBase, 2, 400, 400, 1, 1, 0, col, 1);
	}
	
	if (!onlysurf2 && hpstate > 0)
	{
		if (moab)
		{
			gpu_set_colorwriteenable(true, true, true, false);
			draw_sprite_ext(DamagePatternLatex, hpstate-1, 400, 400, overlayStretchX, overlayStretchY, overlayRotate, c_black, 0.5);
			gpu_set_colorwriteenable(true, true, true, true);
		}
		else if (array_length(bloonData.spawns) < 1)
		{
			gpu_set_blendmode_ext(bm_zero, bm_inv_src_alpha);
			gpu_set_colorwriteenable(false, false, false, true);
			draw_sprite_ext(DamagePatternLatex, hpstate-1, 400, 400, overlayStretchX, overlayStretchY, overlayRotate, c_white, 1);
			gpu_set_blendmode(bm_normal);
			gpu_set_colorwriteenable(true, true, true, true);
		}
		else
		{
			var spawn2 = bloonData.spawns[0].type;
			var ind2 = array_get_index(DataManager.BloonOrd, spawn2);
			var mods2 = mods & atr.allinherit;
			if (ind2 == -1)
			{
				ind2 = array_get_index(DataManager.BloonOrd, string_delete(spawn2, 1, 1));
				mods2 |= getatrfromletter(string_char_at(spawn2, 1));
			}
			var bloonData2 = DataManager.BloonData[ind2];
			mods2 |= bloonData2.atrs;
			mods2 &= ~atr.fort;
			mods2 &= atr.spriteindexed;
			var spriteIndex2 = calculatespriteindex(ind2, mods2);
			drawbloonsprite(spriteIndex2, 0, true);
			surface_reset_target();
			surface_set_target(surf2);
			gpu_set_blendmode_ext(bm_zero, bm_src_alpha);
			gpu_set_colorwriteenable(false, false, false, true);
			draw_sprite_ext(DamagePatternLatex, hpstate-1, 400, 400, overlayStretchX, overlayStretchY, overlayRotate, c_white, 1);
			gpu_set_blendmode(bm_normal);
			gpu_set_colorwriteenable(true, true, true, true);
			surface_reset_target();
			surface_set_target(surf);
			draw_surface(surf2, 0, 0);
		}
	}

	if (!onlysurf2)
	{
		gpu_set_colorwriteenable(true, true, true, false);
		// alternative sheen code (but will require the sheen to be fixed up)
		surface_reset_target();
		surface_set_target(surf2);
		gpu_set_colorwriteenable(true, true, true, true);
		draw_clear_alpha(c_black, 0);
		draw_sprite_ext(bloonBase, 6, 400, 400, 1, 1, 0, c_white, latex ? 0.75 : 0.5); // 1 - (1 - 0.15) / (1 - 0.15 / 4));
		gpu_set_blendmode(bm_subtract);
		draw_sprite_ext(bloonBase, 2, 400, 400, 1, 1, 0, c_white, 1);
		draw_sprite_ext(bloonBase, 3, 400, 400, 1, 1, 0, c_white, 1);
		gpu_set_blendmode(bm_normal);
		draw_sprite_ext(bloonBase, 6, 400, 400, 1, 1, 0, c_white, latex ? 0.25 : 0.15);
		gpu_set_blendmode(bm_subtract);
		draw_sprite_ext(bloonBase, 4, 400, 400, 1, 1, 0, c_white, 1);
		gpu_set_blendmode(bm_normal);
		gpu_set_colorwriteenable(true, true, true, false);
		draw_sprite_ext(bloonBase, 0, 400, 400, 1, 1, 0, c_white, 1);
		surface_reset_target();
		surface_set_target(surf);
		draw_surface(surf2, 0, 0);
			
		//draw_sprite_ext(bloonBase, 6, 400, 400, 1, 1, 0, c_white, 0.15);
		//
		if (latex)
		{
			draw_sprite_ext(bloonBase, 5, 400 - 8, 400 + 4, 1, 1, 0, c_white, 0.5);
		}
		draw_sprite_ext(bloonBase, 5, 400, 400, 1, 1, 0, c_white, 0.75);
	
		if (fort)
		{
			gpu_set_colorwriteenable(true, true, true, true);
			gpu_set_blendmode(bm_normal);
			draw_sprite_ext(FortPattern, hpstate, 400, 400, overlayStretchX, overlayStretchY, overlayRotate, c_white, 1);
		}
	}
	
	gpu_set_colorwriteenable(true, true, true, true);
	surface_reset_target();
}