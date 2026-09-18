/// @description Insert description here
// You can write your code in this editor
datafileread();
Difficulty = "Normal";
StartingMoney = 650;
StartingLifes = 150;
StartRound = 1;
EndRound = 80;
CostFactor = 100;
SpeedFactor = 100;
SpawnRateFactor = 100;
SpawnAmountFactor = 100;
MoabHpFactor = 100;
HardHpFactor = 100;
BloonIncomeFactor = 100;
RoundIncomeFactor = 100;
FarmIncomeFactor = 100;
AllIncomeFactor = 100;
LifeIncomeFactor = 100;
LifeSlowThreshold = 1000;
LifeSlowFactor = 10;
MaxLifes = 5000;
HoneyBloons = false;
TrackLoop = false;

bloonIncomeMult = 100; // 51+: 80,  61+: 50,  86+: 34,  101+: 20,  121+: 10
roundIncomeMult = 100; // 51+: 120, 61+: 150, 86+: 200, 101+: 300, 121+: 500
farmIncomeMult = 100; // 0:		100R : 80,		1,000R : 60,	10,000R : 40,	100,000R : 20,	1,000,000R : 0
						//  0-10	+10/1 ~10
						// 10:		200R : 80,		1,000R : 60,	10,000R : 40,	100,000R : 20,	1,000,000R : 0
						//  10-30	+30/2 ~15		+100/2 ~50
						// 30:		500R : 80,		2,000R : 60,	10,000R : 40,	100,000R : 20,	1,000,000R : 0
						//  30-60	+50/3 ~16.6		+300/3 ~100		+1,000/3 ~333.3
						// 60:		1,000R : 80,	5,000R : 60,	20,000R : 40,	100,000R : 20,	1,000,000R : 0
						//  60-100	+150/4 ~37.5	+500/4 ~125		+3,000/4 ~750	+10,000/4 ~2500
						// 100:		2,500R : 80,	10,000R : 60,	50,000R : 40,	200,000R : 20,	1,000,000R : 0
						//  100-150	+250/5 ~50		+1,500/5 ~300	+5,000/5 ~1000	+30,000/5 ~6000	+100,000/5 ~20000
						// 150:		5,000R : 80,	25,000R : 60,	100,000R : 40,	500,000R : 20,	2,000,000R : 0

debug = false;
gameSpeed = 0;
bloonSounds = array_create(blnsnd.TOTAL_COUNT, 0);
for (var i = 0; i < blnsnd.TOTAL_COUNT; i++)
{
	bloonSoundVariations[i] = array_create(array_length(LocalizeManager.BloonSounds[i].s), 1);
}

resetround();

music = audio_play_sound(LocalizeManager.MusicTracks[irandom(array_length(LocalizeManager.MusicTracks)-1)], 1000, false);