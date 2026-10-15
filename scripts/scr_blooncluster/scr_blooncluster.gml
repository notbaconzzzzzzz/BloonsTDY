
function BloonGroup(_typeIndex, _atrs = atr.none, _count = 0, _hp = 0) constructor
{
	typeIndex = _typeIndex;
	if (typeIndex == -1) typeIndex = 0;
	BloonData = DataManager.BloonData[typeIndex];
	type = BloonData.type;
	Atrs = BloonData.atrs;
	Atrs |= _atrs;
	Indentifier = calculateuniquebloonidentifier(typeIndex, Atrs);
	
	Count = _count;

	MaxHp = BloonData.hp;
	Spd = BloonData.spd;
	IsMoab = is_struct(BloonData.moab);
	if (has(Atrs, atr.latex))
	{
		if (IsMoab)
		{
			switch (BloonData.moab.class)
			{
				case 0: MaxHp += 5; break;
				case 1: MaxHp += 25; break;
				case 2: MaxHp += 100; break;
				case 3: MaxHp += 400; break;
				case 4: MaxHp += 1500; break;
			}
		}
		else MaxHp += 1;
	}
	if (has(Atrs, atr.fort))
	{
		if (has(Atrs, atr.hardy))
		{
			MaxHp += 1;
			Atrs |= atr.hard;
		}
		MaxHp *= 2;
	}
	if (has(Atrs, atr.mega)) MaxHp *= 10;
	if (has(Atrs, atr.stream))
	{
		if (IsMoab) Spd += BloonData.moab.stream;
		else Spd += 100;
	}
	
	/*
	if (has(Atrs, atr.regrow))
	{
		if (!variable_instance_exists(id, "regenTimer") || highestRegrow == -1)
		{
			regenTimer = 0;
			highestRegrow = typeIndex;
		}
		if (IsMoab)
		{
			highestRegrow = -1;
		}
	}
	if (!variable_instance_exists(id, "highestValue") || highestValue > typeIndex)
	{
		highestValue = typeIndex;
	}
	if (has(Atrs, atr.clay))
	{
		if (IsMoab)
		{
			clayLockout = 0;
		}
		else
		{
			if (!variable_instance_exists(id, "clayLockout") || !is_int64(clayLockout))
			{
				clayLockout = int64(0);
			}
			if (!variable_instance_exists(id, "highestRegrow")) highestRegrow = typeIndex;
		}
	}*/

	if (has(Atrs, atr.moab)) MaxHp = round(MaxHp * GameManager.MoabHpFactor / 100);
	else if (has(Atrs, atr.hard)) MaxHp = round(MaxHp * GameManager.HardHpFactor / 100);
	Spd = round(Spd * GameManager.SpeedFactor / 100);
	
	hp = [];
	for (var i = 0; i < MaxHp; i++)
	{
		hp[i] = 0;
	}
	if (_hp <= 0) _hp += MaxHp;
	if (_hp < 1) _hp = 1;
	if (_hp > MaxHp) _hp = MaxHp;
	hp[_hp-1] = Count;
	
	if (IsMoab)
	{
		blimp = true;
		if (type == "bob" || type == "bobmega") blimp = false;
		else if (type == "honey1" || type == "honey2" || type == "honey3" || type == "honey4" || type == "honey5") blimp = false;
	}
	else
	{
		blimp = false;
	}
	rad = BloonData.size / 2;
	posoffset = rad * 2 / 3;
	if (blimp) posoffset = rad * 1 / 3;
	if (!blimp && has(Atrs, atr.regrow)) rad *= 1.25;

/*
	if (variable_instance_exists(id, "hp"))
	{
		if (variable_instance_exists(id, "bloonsplitcanthit"))
		{
			if (hasany(Atrs, bloonsplitcanthit))
			{
				hp = 0;
			}
		}
		hp += MaxHp;
	}
	else hp = MaxHp;*/
	
	/*
	if (hp <= 0)
	{
		parentInstances = [];
		if (instance_exists(parent)) array_copy(parentInstances, 1, parent.parentInstances, 0, array_length(parent.parentInstances));
		bloonsplit(variable_instance_exists(id, "bloonsplitcanthit") ? bloonsplitcanthit : atr.none, true);
		return;
	}*/
	
	/*
	if (IsMoab && has(Atrs, atr.hive))
	{
		hiveTimer = 0;
		HiveInterval = 160 * power(1.5, BloonData.moab.class);
		if (has(Atrs, atr.honey)) HiveInterval /= 2;
		if (type == "ddt" || type == "bbt") HiveInterval /= 2;
	}*/
	
	static Combine = function(group)
	{
		Count += group.Count;
		for (var i = 0; i < MaxHp; i++)
		{
			hp[i] += group.hp[i];
		}
	}
}

function findorcreategroup(sortedlinkedlist, _typeIndex, _atrs = atr.none)
{
	var indentifier = calculateuniquebloonidentifier(_typeIndex, _atrs);
	var node = sortedlinkedlist.FindOrCreate(indentifier, -1);
	if (node.obj == -1)
	{
		node.obj = new BloonGroup(_typeIndex, _atrs);
	}
	return node.obj;
}

function damageblooncluster(inst)
{
	var outputlist = new SortedLinkedList(true);
	var hits = 0;
	var node = inst.bloonGroups.l;
	while (pierce > 0 && !is_instanceof(node, LinkedList))
	{
		var group = node.obj;
		hits += damagebloongroup(outputlist, group);
		if (group.Count <= 0)
		{
			node.l.r = node.r;
			node.r.l = node.l;
		}
		node = node.l;
	}
	for (var i = 0; i < array_length(afterHit); i++)
	{
		if (afterHit[i](inst, outputlist, id, hits))
		{
			
		}
	}
	inst.bloonGroups.Merge(outputlist);
	node = inst.bloonGroups.l;
	while (!is_instanceof(node, LinkedList))
	{
		var group = node.obj;
		if (group.Count <= 0)
		{
			node.l.r = node.r;
			node.r.l = node.l;
		}
		node = node.l;
	}
	with (inst)
	{
		if (is_instanceof(bloonGroups.l, LinkedList) || bloonGroups.l == -1)
		{
			
		}
		else if (bloonGroups.l.obj != displayGroup)
		{
			displayGroup = bloonGroups.l.obj;
			type = displayGroup.type;
			typeIndex = displayGroup.typeIndex;
			BloonData = displayGroup.BloonData;
			Atrs = displayGroup.Atrs;
			MaxHp = displayGroup.MaxHp;
			IsMoab = displayGroup.IsMoab;
			if (IsMoab)
			{
				blimp = true;
				if (type == "bob" || type == "bobmega") blimp = false;
				else if (type == "honey1" || type == "honey2" || type == "honey3" || type == "honey4" || type == "honey5") blimp = false;
			}
			else
			{
				blimp = false;
			}
			rad = BloonData.size / 2;
			posoffset = rad * 2 / 3;
			if (blimp) posoffset = rad * 1 / 3;
			if (!blimp && has(Atrs, atr.regrow)) rad *= 1.25;
			sprite_index = -1;
		}
	}
}

function damagebloongroup(outputlist, group)
{
	if (has(cantHits, atr.camo) && has(group.Atrs, atr.camo))
	{
		return 0;
	}
	dmg = damage;
	dmgmult = damagemult;
	for (var i = 0; i < array_length(cond); i++)
	{
		cond[i](group, id);
	}
	dmg = round(dmg * dmgmult);
	var mibpiercepenalty = 0;
	if (cantHits & (group.Atrs & ~atr.camo & ~atr.clay) != atr.none)
	{
		if (mibratio > 0)
		{
			if (dmg > 1) dmg = ceil(dmg * mibratio / 100);
			else mibpiercepenalty = ceil(100 / mibratio) - 1;
		}
		else
		{
			playcanthitsound(cantHits & group.Atrs);
			dmg = 0;
			if (destroyoncanthit)
			{
				pierce = 0;
				return 0;
			}
		}
	}
	var hitCount;
	if (has(group.Atrs, atr.amber) && forgivingamber < 1)
	{
		hitCount = 0;
		var hasKant = has(group.Atrs, atr.kant);
		while (hitCount < group.Count)
		{
			if (hasKant)
			{
				if (pierce < 2) { pierce = 0; break; }
				pierce -= 1;
			}
			pierce = floor(pierce * forgivingamber);
			pierce -= 1 + mibpiercepenalty;
			hitCount += 1;
			if (pierce <= 0) break;
		}
	}
	else if (has(group.Atrs, atr.kant))
	{
		hitCount = min(pierce / (2 + mibpiercepenalty), group.Count);
		pierce -= ceil(hitCount) * (2 + mibpiercepenalty);
		hitCount = ceil(hitCount - 1 / (2 + mibpiercepenalty));
		if (hitCount <= 0) playbloonsound(blnsnd.hitkant);
	}
	else
	{
		hitCount = min(ceil(pierce / (1 + mibpiercepenalty)), group.Count);
		pierce -= hitCount * (1 + mibpiercepenalty);
	}
	var flag = false;
	/*
	if (has(cantHits, atr.clay) && has(inst.Atrs, atr.clay))
	{
		if (!is_int64(inst.clayLockout))
		{
			if (inst.clayLockout <= inst.MaxHp - inst.hp)
			{
				flag = true;
				if (mibratio > 0)
				{
					if (dmg > 1) dmg = ceil(dmg * mibratio / 100);
					else pierce -= ceil(100 / mibratio) - 1;
				}
				else
				{
					with (inst)
					{
						var heal = floor(25 * power(3, (is_struct(BloonData.moab) ? BloonData.moab.class : 0) - 1));
						if (heal + other.dmg > MaxHp - clayLockout) heal = MaxHp - clayLockout - other.dmg;
						if (heal + hp > MaxHp) heal = MaxHp - hp;
						hp += heal;
						clayLockout += heal + other.dmg;
					}
					playbloonsound(blnsnd.hitclay);
					dmg = 0;
					if (cantHits & (inst.Atrs & ~atr.camo & ~atr.clay) != atr.none)
					{
						if (destroyoncanthit)
						{
							pierce = 0;
							return true;
						}
					}
				}
			}
		}
		else
		{
			var highre = variable_instance_exists(inst, "highestRegrow") ? inst.highestRegrow : -1;
			if (highre == inst.typeIndex) highre = -1;
			var growinto = getregrownext(inst.typeIndex, highre, variable_instance_exists(inst, "regrowdisambig") ? inst.regrowdisambig : -1, inst.BloonData);
			if (inst.highestRegrow >= inst.typeIndex && growinto != -1 && inst.clayLockout & (int64(1) << growinto) == 0)
			{
				flag = true;
				if (mibratio > 0)
				{
					if (dmg > 1) dmg = ceil(dmg * mibratio / 100);
					else pierce -= ceil(100 / mibratio) - 1;
				}
				else
				{
					with (inst)
					{
						clayLockout |= int64(1) << growinto;
						typeIndex = growinto;
						type = DataManager.BloonOrd[typeIndex];
						BloonData = DataManager.BloonData[typeIndex];
						var tempAtrs = Atrs;
						Atrs = BloonData.atrs;
						Atrs |= tempAtrs & atr.allinherit;
						if (GameManager.InheritanceMode)
						{
							Atrs |= tempAtrs & atr.extrainherit;
							if (has(Atrs, atr.moab)) Atrs |= tempAtrs & atr.extramoabinherit;
							if (has(tempAtrs, atr.indigo)) Atrs |= atr.indigo;
							if (!hasany(Atrs, atr.lead | atr.aqua | atr.crystal))
							{
								var temp = -1;
								var totalTemp = 0;
								if (has(tempAtrs, atr.lead))
								{
									totalTemp++;
									if (random(totalTemp) <= 1) temp = 0;
								}
								if (has(tempAtrs, atr.aqua))
								{
									totalTemp++;
									if (random(totalTemp) <= 1) temp = 1;
								}
								if (has(tempAtrs, atr.crystal))
								{
									totalTemp++;
									if (random(totalTemp) <= 1) temp = 2;
								}
								if (temp == 0) Atrs |= atr.lead;
								else if (temp == 1) Atrs |= atr.aqua;
								else if (temp == 2) Atrs |= atr.crystal;
							}
							if (has(tempAtrs, atr.black) && !has(Atrs, atr.lead)) Atrs |= atr.black;
							if (has(tempAtrs, atr.white) && !has(Atrs, atr.aqua)) Atrs |= atr.white;
							if (has(tempAtrs, atr.purple) && !has(Atrs, atr.crystal)) Atrs |= atr.purple;
						}

						MaxHp = BloonData.hp;
						Spd = BloonData.spd;
						if (has(Atrs, atr.latex))
						{
							if (has(Atrs, atr.moab))
							{
								switch (is_struct(BloonData.moab) ? BloonData.moab.class : 1)
								{
									case 0: MaxHp += 5; break;
									case 1: MaxHp += 25; break;
									case 2: MaxHp += 100; break;
									case 3: MaxHp += 400; break;
									case 4: MaxHp += 1500; break;
								}
							}
							else MaxHp += 1;
						}
						if (has(Atrs, atr.fort))
						{
							if (has(Atrs, atr.hardy))
							{
								MaxHp += 1;
								Atrs |= atr.hard;
							}
							MaxHp *= 2;
						}
						if (has(Atrs, atr.mega)) MaxHp *= 10;
						if (has(Atrs, atr.stream))
						{
							if (is_struct(BloonData.moab)) Spd += BloonData.moab.stream;
							else Spd += 100;
						}
						if (has(Atrs, atr.clay))
						{
							if (IsMoab)
							{
								clayLockout = 0;
							}
							else
							{
								if (!variable_instance_exists(id, "clayLockout") || !is_int64(clayLockout))
								{
									clayLockout = int64(0);
								}
								if (!variable_instance_exists(id, "highestRegrow")) highestRegrow = typeIndex;
							}
						}

						if (has(Atrs, atr.moab)) MaxHp = round(MaxHp * GameManager.MoabHpFactor / 100);
						else if (has(Atrs, atr.hard)) MaxHp = round(MaxHp * GameManager.HardHpFactor / 100);
						Spd = round(Spd * GameManager.SpeedFactor / 100);

						if (has(Atrs, atr.moab))
						{
							blimp = true;
							if (type == "bob" || type == "bobmega") blimp = false;
							else if (type == "honey1" || type == "honey2" || type == "honey3" || type == "honey4" || type == "honey5") blimp = false;
						}
						else
						{
							blimp = false;
						}
						rad = BloonData.size / 2;

						hp = MaxHp;
						var sprind = calculatespriteindex(typeIndex, Atrs);
						var spr = BloonRenderer.BloonSprites[? sprind];
						if (is_undefined(spr))
						{
							sprite_index = -1;
							if (!array_contains(BloonRenderer.drawQueue, sprind)) array_push(BloonRenderer.drawQueue, sprind);
						}
						else sprite_index = spr;
						if (has(Atrs, atr.regrow)) rad *= 1.25;
					}
					playbloonsound(blnsnd.hitclay);
					dmg = 0;
					if (cantHits & (inst.Atrs & ~atr.camo & ~atr.clay) != atr.none)
					{
						if (destroyoncanthit)
						{
							pierce = 0;
							return true;
						}
					}
				}
			}
		}
	}*/
	if (has(group.Atrs, atr.hah))
	{
		if (dmg >= 25) dmg = floor(dmg / 5);
		else dmg = floor(sqrt(dmg));
	}
	if (has(group.Atrs, atr.titan))
	{
		if (dmg > 0)
		{
			dmg -= 1;
			if (dmg <= 0) playbloonsound(blnsnd.hittitan);
		}
	}
	if (dmg > 0)
	{
		playbloonsound(getdmgsound(group.Atrs));
		var hitRemain = hitCount;
		for (var i = group.MaxHp; i >= 1; i--)
		{
			if (group.hp[i-1] > 0)
			{
				if (group.hp[i-1] >= hitRemain)
				{
					resolvebloongroup(outputlist, i - dmg, hitRemain, cantHits, group.typeIndex, group.Atrs);
					group.hp[i-1] -= hitRemain;
					group.Count -= hitRemain;
					hitRemain = 0;
					break;
				}
				else
				{
					resolvebloongroup(outputlist, i - dmg, group.hp[i-1], cantHits, group.typeIndex, group.Atrs);
					hitRemain -= group.hp[i-1];
					group.Count -= group.hp[i-1];
					group.hp[i-1] = 0;
				}
			}
		}
	}
	return hitCount;
}

function resolvebloongroup(outputlist, hp, Count, bloonsplitcanthit, typeIndex, Atrs, BloonData = -1)
{
	if (hp > 0)
	{
		var group = findorcreategroup(outputlist, typeIndex, Atrs);
		group.Count += Count;
		group.hp[hp-1] += Count;
		return;
	}
	if (BloonData == -1)
	{
		BloonData = DataManager.BloonData[typeIndex];
		playbloonsound(getpopsound(BloonData, Atrs));
	}
	var giveValue = Count;
	/*
	if (highestValue >= typeIndex)
	{
		giveValue = 1;
	}
	else
	{
		if (highestValue == -1) giveValue = -1;
		else giveValue = 0;
	}*/
	if (giveValue > 0)
	{
		var m = 1 * GameManager.BloonIncomeFactor * GameManager.AllIncomeFactor;
		PlayerModel.bloonFrac += m * giveValue;
		PlayerModel.money += floor(PlayerModel.bloonFrac / 10000);
		PlayerModel.bloonFrac -= floor(PlayerModel.bloonFrac / 10000) * 10000;
	}
	
	
	if (is_struct(BloonData.moab))
	{
		hp = 0;
		//hp = ceil(hp / tot);
	}
	for (var i = 0; i < array_length(BloonData.spawns); i++)
	{
		var t = BloonData.spawns[i].type;
		var mods = int64(0);
		var bloonInd = array_get_index(DataManager.BloonOrd, t);
		if (bloonInd == -1)
		{
			mods |= getatrfromletter(string_char_at(t, 1));
			t = string_delete(t, 1, 1);
			bloonInd = array_get_index(DataManager.BloonOrd, t);
		}
		var bloonData = DataManager.BloonData[bloonInd];
		mods |= Atrs & atr.inherit;
		var ismoab = is_struct(bloonData.moab);
		var isbob = has(bloonData.atrs, atr.bob);
		if (isbob && has(Atrs, atr.stream)) { mods |= atr.camo; mods |= atr.regrow; }
		if (has(Atrs, atr.fort) && hasany(bloonData.atrs, atr.canfort))
		{
			mods |= atr.fort;
			if (isbob) mods |= atr.latex;
		}
		if (has(Atrs, atr.camo) && (!has(bloonData.atrs, atr.moab) || hasany(bloonData.atrs, atr.bob | atr.honey))) mods |= atr.camo;
		if (has(Atrs, atr.hive) && hasany(bloonData.atrs, atr.canhive)) mods |= atr.hive;
		if (GameManager.InheritanceMode)
		{
			mods |= Atrs & atr.extrainherit;
			if (ismoab) mods |= Atrs & atr.extramoabinherit;
			if (has(Atrs, atr.indigo) && typeIndex != 37 && typeIndex != 39) mods |= atr.indigo;
			if (!hasany(bloonData.atrs, atr.lead | atr.aqua | atr.crystal))
			{
				var temp = -1;
				var totalTemp = 0;
				if (has(Atrs, atr.lead))
				{
					totalTemp++;
					if (random(totalTemp) <= 1) temp = 0;
				}
				if (has(Atrs, atr.aqua))
				{
					totalTemp++;
					if (random(totalTemp) <= 1) temp = 1;
				}
				if (has(Atrs, atr.crystal))
				{
					totalTemp++;
					if (random(totalTemp) <= 1) temp = 2;
				}
				if (temp == 0) mods |= atr.lead;
				else if (temp == 1) mods |= atr.aqua;
				else if (temp == 2) mods |= atr.crystal;
			}
			if (has(Atrs, atr.black) && !has(bloonData.atrs | mods, atr.lead)) mods |= atr.black;
			if (has(Atrs, atr.white) && !has(bloonData.atrs | mods, atr.aqua)) mods |= atr.white;
			if (has(Atrs, atr.purple) && !has(bloonData.atrs | mods, atr.crystal)) mods |= atr.purple;
		}
		
		mods |= bloonData.atrs;
		/*
		var vari = {parent : id, type : t, Atrs : mods, hp : hp, bloonsplitcanthit : canthit};
		vari.finishdist = finishdist;
		if (has(Atrs, atr.regrow) || has(bloonData.atrs | mods, atr.clay))
		{
			if (variable_instance_exists(id, "regenTimer")) vari.regenTimer = regenTimer;
			if (variable_instance_exists(id, "highestRegrow")) vari.highestRegrow = highestRegrow;
			else vari.highestRegrow = typeIndex;
			if (variable_struct_exists(BloonData.spawns[i], "disambig"))
			{
				vari.regrowdisambig = BloonData.spawns[i].disambig;
			}
			else if (variable_instance_exists(id, "regrowdisambig"))
			{
				vari.regrowdisambig = regrowdisambig;
			}
		}
		if (variable_instance_exists(id, "clayLockout") && !IsMoab && hasany(bloonData.atrs | mods, atr.clay | atr.regrow))
		{
			vari.clayLockout = clayLockout;
		}*/
		
		var normalcount = BloonData.spawns[i].amt;
		var actualcount = normalcount;
		if (has(Atrs, atr.bob | atr.fort))
		{
			actualcount = floor(actualcount * 4 / 3);
		}
		if (has(Atrs, atr.ustuffed))
		{
			actualcount = actualcount * 2;
		}
		else if (has(Atrs, atr.ostuffed))
		{
			if (variable_struct_exists(BloonData.spawns[i], "overstuffedAmt")) actualcount = floor(BloonData.spawns[i].overstuffedAmt * actualcount / normalcount);
			else actualcount = floor(actualcount * 3 / 2);
		}
		normalcount *= Count;
		actualcount *= Count;
		
		
		var MaxHp = bloonData.hp;
		if (has(mods, atr.latex))
		{
			if (ismoab)
			{
				switch (bloonData.moab.class)
				{
					case 0: MaxHp += 5; break;
					case 1: MaxHp += 25; break;
					case 2: MaxHp += 100; break;
					case 3: MaxHp += 400; break;
					case 4: MaxHp += 1500; break;
				}
			}
			else MaxHp += 1;
		}
		if (has(mods, atr.fort))
		{
			if (has(mods, atr.hardy))
			{
				MaxHp += 1;
				mods |= atr.hard;
			}
			MaxHp *= 2;
		}
		if (has(mods, atr.mega)) MaxHp *= 10;
	
		/*
		if (has(Atrs, atr.regrow))
		{
			if (!variable_instance_exists(id, "regenTimer") || highestRegrow == -1)
			{
				regenTimer = 0;
				highestRegrow = typeIndex;
			}
			if (IsMoab)
			{
				highestRegrow = -1;
			}
		}
		if (!variable_instance_exists(id, "highestValue") || highestValue > typeIndex)
		{
			highestValue = typeIndex;
		}
		if (has(Atrs, atr.clay))
		{
			if (IsMoab)
			{
				clayLockout = 0;
			}
			else
			{
				if (!variable_instance_exists(id, "clayLockout") || !is_int64(clayLockout))
				{
					clayLockout = int64(0);
				}
				if (!variable_instance_exists(id, "highestRegrow")) highestRegrow = typeIndex;
			}
		}*/

		if (has(mods, atr.moab)) MaxHp = round(MaxHp * GameManager.MoabHpFactor / 100);
		else if (has(mods, atr.hard)) MaxHp = round(MaxHp * GameManager.HardHpFactor / 100);
		
		var newHp = MaxHp + hp;
		if (hasany(mods, bloonsplitcanthit))
		{
			newHp = MaxHp;
		}
		
		/*
		if (giveValue > 0)
		{
			if (j >= normalcount) vari.highestValue = -1;
			else vari.highestValue = highestValue;
		}
		else if (giveValue == 0)
		{
			if (bloonData.downstream[highestValue])
			{
				vari.highestValue = highestValue;
				giveValue = -1;
			}
			else vari.highestValue = -1;
		}
		else
		{
			vari.highestValue = -1;
		}*/
		
		resolvebloongroup(outputlist, newHp, actualcount, bloonsplitcanthit, bloonInd, mods, bloonData);
	}
}