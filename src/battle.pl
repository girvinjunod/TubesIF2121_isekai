:- dynamic(current_monster/1).
:- dynamic(special_cooldown/1).
:- dynamic(monster_hp/1).
:- dynamic(monster_maxHP/1).
:- dynamic(monster_atk/1).
:- dynamic(monster_def/1).
:- dynamic(monster_exp/1).
:- dynamic(monster_gold/1).
:- dynamic(monster_turn/1).
:- dynamic(monster_lvl/1).

monster_encounter :-
	acak(0,300,X),
	X < 180,
	setState(battle),
	retractall(special_cooldown(_)),
	asserta(special_cooldown(0)),
	level(Lvl),
	acak(-3, 3, LvlDelta),
	MLvl is Lvl + LvlDelta,
	(
		MLvl < 1, TrueMLvl is 1;
		TrueMLvl is MLvl
	),
	randomize_monster(X, TrueMLvl),
	write('Bertemu '),
	current_monster(Name),
	monster_lvl(Lv),
	write(Name),
	write(' di jalan.'), nl,
	write('Level: '),
	write(Lv),
	nl,nl,
	write('----Battle Start!!----'),nl,nl,
	asserta(monster_turn(0)),
	!.

monster_encounter.

randomize_monster(X, Lvl) :-
	X < 72,
	setState(battle),
	asserta(current_monster('slime')),
	(
		Lvl > 30, MLvl is 30;
		MLvl is Lvl
	),
	HP is 30 * MLvl + 50,
	Atk is 2 * MLvl + 10,
	Def is 2 * MLvl + 20,
	XP is 20 * MLvl + 50,
	Gold is 10 * (MLvl + 1),
	asserta(monster_hp(HP)),
	asserta(monster_maxHP(HP)),
	asserta(monster_atk(Atk)),
	asserta(monster_def(Def)),
	asserta(monster_exp(XP)),
	asserta(monster_lvl(MLvl)),
	asserta(monster_gold(Gold)),
	!.
randomize_monster(X, Lvl) :-
	X < 126,
	setState(battle),
	asserta(current_monster('goblin')),
	(
		Lvl < 5, MLvl is 5;
		Lvl > 35, MLvl is 35;
		MLvl is Lvl
	),
	HP is 25 * MLvl + 80,
	Atk is 10 * MLvl + 25,
	Def is 5 * MLvl + 5,
	XP is 30 * MLvl + 225,
	Gold is 10 * (Lvl + 2),
	asserta(monster_hp(HP)),
	asserta(monster_maxHP(HP)),
	asserta(monster_atk(Atk)),
	asserta(monster_def(Def)),
	asserta(monster_exp(XP)),
	asserta(monster_lvl(MLvl)),
	asserta(monster_gold(Gold)),
	!.
randomize_monster(X, Lvl) :-
	X < 171,
	setState(battle),
	asserta(current_monster('wolf')),
	(
		Lvl < 8, MLvl is 8;
		Lvl > 45, MLvl is 45;
		MLvl is Lvl
	),
	HP is 30 * MLvl + 100,
	Atk is 15 * MLvl + 20,
	Def is 5 * MLvl + 5,
	XP is 55 * MLvl + 325,
	Gold is 10 * (Lvl + 2),
	asserta(monster_hp(HP)),
	asserta(monster_maxHP(HP)),
	asserta(monster_atk(Atk)),
	asserta(monster_def(Def)),
	asserta(monster_exp(XP)),
	asserta(monster_lvl(MLvl)),
	asserta(monster_gold(Gold)),
	!.

randomize_monster(_, Lvl) :-
	setState(battle),
	asserta(current_monster('ghost')),
	(
		Lvl < 15, MLvl is 15;
		Lvl > 70; MLvl is 70;
		MLvl is Lvl
	),
	HP is 20 * MLvl + 150,
	Atk is 20 * MLvl + 2,
	Def is 20 * MLvl + 5,
	XP is 100 * MLvl + 325,
	Gold is 10 * (Lvl + 2),
	asserta(monster_hp(HP)),
	asserta(monster_maxHP(HP)),
	asserta(monster_atk(Atk)),
	asserta(monster_def(Def)),
	asserta(monster_exp(XP)),
	asserta(monster_lvl(MLvl)),
	asserta(monster_gold(Gold)).

randomize_monster(boss) :-
	setState(battle),
	asserta(current_monster('Raja Naga Keri')),
	asserta(monster_hp(2500)),
	asserta(monster_maxHP(2500)),
	asserta(monster_atk(300)),
	asserta(monster_def(200)),
	asserta(monster_exp(0)),
	asserta(monster_lvl(69)),
	asserta(monster_gold(9999)).

randomize_monster(boss2) :-
	setState(battle),
	asserta(current_monster('Raja Naga Demon Keri')),
	asserta(monster_hp(6666)),
	asserta(monster_maxHP(6666)),
	asserta(monster_atk(500)),
	asserta(monster_def(30)),
	asserta(monster_exp(0)),
	asserta(monster_lvl(99)),
	asserta(monster_gold(9999)).

randomize_monster(shopkeeper) :-
	setState(battle),
	asserta(current_monster('Shopkeeper')),
	asserta(monster_hp(9999)),
	asserta(monster_maxHP(9999)),
	asserta(monster_atk(2000)),
	asserta(monster_def(500)),
	asserta(monster_exp(99999)),
	asserta(monster_lvl(999)),
	asserta(monster_gold(99999)).

monster_count_move :-
	monster_turn(T),
	T > 0,
	U is T - 1,
	retractall(monster_turn(_)),
	asserta(monster_turn(U)), !.

monster_count_move :- monster_turn(T), T = 0.

monster_move :-
	monster_turn(T),
	%random(X),
	acak(X),
	X < 0.3,
	T =< 0,
	monster_special,
	monster_count_move, !.

monster_move :-
	monster_atk(X),
	damagePlayer(X),
	monster_count_move, !.

monster_move.

monster_special :-
	write('Hiya monsternya ngambek, terus pake special attack.'), nl,
	monster_atk(Atk),
	Dmg is Atk * 3,
	damagePlayer(Dmg),
	asserta(monster_turn(3)).

damage_monster(Dmg) :-
	monster_hp(HP),
	monster_def(Def),
	DmgMul is 1 - ((0.06 * Def) / (1 + 0.06 * Def)),
	BiasDmg is Dmg * DmgMul,
	NewHP is HP - BiasDmg,
	retractall(monster_hp(HP)),
	asserta(monster_hp(NewHP)),
	nl,
	format('Kamu memberikan ~2f damage ke musuh.', [BiasDmg]), nl,
	(
		NewHP =< 0,
		monster_die;
		NewHP > 0
	),nl.
monster_die :-
	state(battle),
	current_monster('Raja Naga Keri'),
	nl,
	retractall(current_monster(_)),
	retractall(monster_hp(_)),
	retractall(monster_atk(_)),
	retractall(monster_def(_)),
	retractall(monster_exp(_)),
	retractall(monster_gold(_)),
    retractall(monster_turn(_)),
	name(X),
    changephase(X), !.
monster_die :-
	state(battle),
	current_monster('Raja Naga Demon Keri'),
	nl,
	retractall(current_monster(_)),
	retractall(monster_hp(_)),
	retractall(monster_atk(_)),
	retractall(monster_def(_)),
	retractall(monster_exp(_)),
	retractall(monster_gold(_)),
    retractall(monster_turn(_)),
	setState(free),
	name(X),
    finishBoss(X), !.
	
monster_die :-
	state(battle),
	current_monster('Shopkeeper'),
	monster_exp(XP),
	monster_gold(Gold),
	nl, sleep(1),
	write('Shopkeeper'),
	write(' telah dikalahkan.'), nl,nl,
	write('Mendapat '),
	write(XP),
	write(' experience points.'), nl,
	format('Kamu juga mendapatkan ~w gold.', [Gold]),nl,
	earnExp(XP),
	earnGold(Gold),
	retractall(current_monster(_)),
	retractall(monster_hp(_)),
	retractall(monster_atk(_)),
	retractall(monster_def(_)),
	retractall(monster_exp(_)),
	retractall(monster_gold(_)),
	retractall(monster_turn(_)),
	setState(free), !.

monster_die :-
    state(tutorial),
	current_monster(Name),
	monster_exp(XP),
	monster_gold(Gold),
	update_active_quest(Name),
	nl,
	write(Name),
	write(' telah dikalahkan.'), nl,nl,
	write('Mendapat '),
	write(XP),
	write(' experience points.'), nl,
	format('Kamu juga mendapatkan ~w gold.', [Gold]),
	earnExp(XP),
	earnGold(Gold),
	retractall(current_monster(_)),
	retractall(monster_hp(_)),
	retractall(monster_atk(_)),
	retractall(monster_def(_)),
	retractall(monster_exp(_)),
	retractall(monster_gold(_)),
    retractall(monster_turn(_)),
	setState(free),
    finishTutorial, !.


monster_die :-
	state(battle),
	current_monster(Name),
	monster_exp(XP),
	monster_gold(Gold),
	nl,
	write(Name),
	write(' telah dikalahkan.'), nl,nl,
	write('Mendapat '),
	write(XP),
	write(' experience points.'), nl,
	format('Kamu juga mendapatkan ~w gold.', [Gold]),nl,
	earnExp(XP),
	earnGold(Gold),
	update_active_quest(Name),
	retractall(current_monster(_)),
	retractall(monster_hp(_)),
	retractall(monster_atk(_)),
	retractall(monster_def(_)),
	retractall(monster_exp(_)),
	retractall(monster_gold(_)),
   retractall(monster_turn(_)),
	setState(free), !.
kabur :-
	state(tutorial),
	write('Masa tutorial udah kabur aja.\n'), !.
kabur :-
	current_monster('Raja Naga Keri'),
	write('Tidak ada kabur, Raja Naga Keri menghadang jalanmu.\n'),
	write('Semangat!!!.\n'), !.
kabur :-
	current_monster('Shopkeeper'),
	write('Tidak ada kabur, kamu tidak bisa lari dari keadilan.\n'),
	write('Tanggung jawab atas perbuatanmu!!.\n'), !.
kabur :-
	state(battle),
	%random(X),
	acak(X),
	(
		X < 0.3,
		write('Kamu berhasil kabur :D.'),
		setState(free), !
	);
	(
		(
			state(battle),
			write('Kamu gagal kabur :\'(.'), nl,
			monster_move,
			battleStats, !
		);
		(
			write('Kamu kan lagi ga battle, mau kabur dari mana? :(.'), !
		)
	).

special_counter :-
	special_cooldown(X),
	X > 0,
	NewX is X - 1,
	retractall(special_cooldown(_)),
	asserta(special_cooldown(NewX)), !.

special_counter.

maling :-
  acak(0, 100, R), !,
  (
	(
	  R < 35,
	  (R < 15, !, Item = kupon_gacha_equipment);
	  (R < 35, !, Item = kupon_gacha_item)
	);
	(Item = potion)
  ),
  write('Berhasil mencuri '), write(Item), write(' dari monster'),nl,
  addToInventory(Item), !.
  
special_attack :-
	state(not_started), !,
	write('Gamenya belom mulai bang, udah attack2 aja.').
special_attack :-
	state(free),
	write('Kamu sedang tidak dalam battle, mau nyerang naon?'), nl, !.
special_attack :-
	special_cooldown(0),
	(
		(
			playerClass(swordsman),
			write('Kamu menggunakan special attack.\n'),nl,
			write('Lionheart!!!'), nl,
			hp(Dmg),
			damage_monster(Dmg)
		), !;
		(
			playerClass(archer),
			attack(Atk),
			write('Kamu menggunakan special attack.\n'),nl, 
			write('Steal!!!'), nl,
			BiasAtk is Atk * 0.5,
			damage_monster(BiasAtk),
			maling
		), !;
		(
			playerClass(sorcerer),
			level(Lvl),
			write('Kamu menggunakan special attack.\n'), nl, 
			write('Ekusupurosion!!!'), nl,
			BatasAtas is (Lvl*1000)+1,
			acak(1, BatasAtas, GachaDmg),
			damage_monster(GachaDmg)
		)
	),
	retractall(special_cooldown(_)),
	asserta(special_cooldown(3)),
	monster_move,
	battleStats, !.

special_attack :-
    special_cooldown(CD),
    CD > 0,
	write('Special attack masih cooldown...'), !.

special_attack :-
    special_cooldown(_).

randomizeFlavorS(X) :-
  X < 40, !,
  (
    (X =:= 0, !, write('Slash'));
    (X =:= 1, !, write('Multislash'));
    (X =:= 2, !, write('Power Stab'));
	(X =:= 3, !, write('Tackle'));
	(X =:= 4, !, write('Pommel Strike'));
	(X =:= 5, !, write('Headbutt'));
	(X =:= 6, !, write('Bladefury'));
	(X =:= 7, !, write('Excalibur'));
	(X =:= 8, !, write('Maim'));
	(X =:= 9, !, write('Lion\'s Song'));
	(X =:= 10, !, write('Demon Cutter'));
	(X =:= 11, !, write('Thunder Cross Split Attack'));
	(X =:= 12, !, write('Slap'));
	(X =:= 13, !, write('Ora Ora Ora Ora Ora Ora Ora Ora'));
	(X =:= 14, !, write('Double Edge'));
	(X =:= 15, !, write('Bash'));
	(X =:= 16, !, write('Beat Up'));
	(X =:= 17, !, write('Piledriver'));
	(X =:= 18, !, write('Elbow Drop'));
	(X =:= 19, !, write('Sword Dance'));
	(X =:= 20, !, write('Body Slam'));
	(X =:= 21, !, write('Flex'));
	(X =:= 22, !, write('Clothesline'));
	(X =:= 23, !, write('Unlimited Blade Works'));
	(X =:= 24, !, write('Perfected Strike'));
	(X =:= 25, !, write('Rampage'));
	(X =:= 26, !, write('Warcry'));
	(X =:= 27, !, write('Intimidate'));
	(X =:= 28, !, write('Blood Rage'));
	(X =:= 29, !, write('Uppercut'));
	(X =:= 30, !, write('Shockwave'));
	(X =:= 31, !, write('Eviscerate'));
	(X =:= 32, !, write('Flurry of Blows'));
	(X =:= 33, !, write('Rushdown'));
	(X =:= 34, !, write('Kick'));
	(X =:= 35, !, write('Desolate'));
	(X =:= 36, !, write('Manifold Strike'));
	(X =:= 37, !, write('Dragon Twister'));
	(X =:= 38, !, write('Falcon Punch'));
	(X =:= 39, !, write('Deathbringer'))).

randomizeFlavorA(X) :-
  X < 40, !,
  (
    (X =:= 0, !, write('Drill Arrow'));
    (X =:= 1, !, write('Multishot'));
    (X =:= 2, !, write('Dragon Arrow'));
	(X =:= 3, !, write('Bonk'));
	(X =:= 4, !, write('Rocket Launcher'));
	(X =:= 5, !, write('Laser Beam'));
	(X =:= 6, !, write('Cupid\'s Arrow'));
	(X =:= 7, !, write('Focus Fire'));
	(X =:= 8, !, write('Headshot'));
	(X =:= 9, !, write('Meteor Arrow'));
	(X =:= 10, !, write('Assassinate'));
	(X =:= 11, !, write('Piercing Shot'));
	(X =:= 12, !, write('Heartseeking Arrow'));
	(X =:= 13, !, write('Bullet Rain'));
	(X =:= 14, !, write('Deadeye'));
	(X =:= 15, !, write('AK-47'));
	(X =:= 16, !, write('Fan the Hammer'));
	(X =:= 17, !, write('Vulcan Cannon'));
	(X =:= 18, !, write('Arrow Rain'));
	(X =:= 19, !, write('Powershot'));
	(X =:= 20, !, write('Megashark'));
	(X =:= 21, !, write('Backstab'));
	(X =:= 22, !, write('Snipershot'));
	(X =:= 23, !, write('Shadow Strike'));
	(X =:= 24, !, write('B.F.G'));
	(X =:= 25, !, write('Dagger Throw'));
	(X =:= 26, !, write('Dagger Spray'));
	(X =:= 27, !, write('Caltrops'));
	(X =:= 28, !, write('Cloak and Dagger'));
	(X =:= 29, !, write('Choke'));
	(X =:= 30, !, write('Cannonball'));
	(X =:= 31, !, write('Bullseye'));
	(X =:= 32, !, write('Booby Trap'));
	(X =:= 33, !, write('Landmine'));
	(X =:= 34, !, write('Shooting Star'));
	(X =:= 35, !, write('Wyvern Piercer'));
	(X =:= 36, !, write('Explosive Arrow'));
	(X =:= 37, !, write('Shackleshot'));
	(X =:= 38, !, write('Frost Arrow'));
	(X =:= 39, !, write('Slingshot'))).

randomizeFlavorM(X) :-
  X < 40, !,
  (
    (X =:= 0, !, write('Fire Ball'));
    (X =:= 1, !, write('Water Torrent'));
    (X =:= 2, !, write('Sandstorm'));
	(X =:= 3, !, write('Meteor'));
	(X =:= 4, !, write('Black Hole'));
	(X =:= 5, !, write('Cataclysm'));
	(X =:= 6, !, write('Frostbite'));
	(X =:= 7, !, write('Banshee Scream'));
	(X =:= 8, !, write('Hex'));
	(X =:= 9, !, write('Curse'));
	(X =:= 10, !, write('Tornado'));
	(X =:= 11, !, write('Sharknado'));
	(X =:= 12, !, write('Earthquake'));
	(X =:= 13, !, write('Avalanche'));
	(X =:= 14, !, write('Spooky Scary Skeletons'));
	(X =:= 15, !, write('Emerald Splash'));
	(X =:= 16, !, write('King Crimson'));
	(X =:= 17, !, write('Solar Beam'));
	(X =:= 18, !, write('Thunderbolt'));
	(X =:= 19, !, write('Blizzard'));
	(X =:= 20, !, write('Spatial Rend'));
	(X =:= 21, !, write('Mana Burn'));
	(X =:= 22, !, write('Lunar Dance'));
	(X =:= 23, !, write('Dark Void'));
	(X =:= 24, !, write('Eruption'));
	(X =:= 25, !, write('Sacred Fire'));
	(X =:= 26, !, write('Malaise'));
	(X =:= 27, !, write('Air Cannon'));
	(X =:= 28, !, write('Locust Swarm'));
	(X =:= 29, !, write('Petrify'));
	(X =:= 30, !, write('Inferno'));
	(X =:= 31, !, write('Cold Snap'));
	(X =:= 32, !, write('Ball Lightning'));
	(X =:= 33, !, write('Tempest Strike'));
	(X =:= 34, !, write('Ragnarok'));
	(X =:= 35, !, write('Deus Ex Machina'));
	(X =:= 36, !, write('Soul Steal'));
	(X =:= 37, !, write('Abyss Grab'));
	(X =:= 38, !, write('Decay'));
	(X =:= 39, !, write('Golem Punch'))).
	
gachaFlavorS :-
  acak(0, 40, R),
  randomizeFlavorS(R).
gachaFlavorA :-
  acak(0, 40, R),
  randomizeFlavorA(R).	
gachaFlavorM :-
  acak(0, 40, R),
  randomizeFlavorM(R).
flavor :-
	(
		(
			playerClass(swordsman),
			gachaFlavorS
		), !;
		(
			playerClass(archer),
			gachaFlavorA
		), !;
		(
			playerClass(sorcerer),
			gachaFlavorM
		)
	).

attack :-
	state(not_started), !,
	write('Gamenya belom mulai bang, udah attack2 aja.').

attack :-
	(state(battle); state(tutorial)), !,
	special_counter,
	write('Kamu menyerang musuh dengan attack '), flavor, nl,
	attack(Atk),
	damage_monster(Atk), !,
	monster_move, 
	battleStats, !.

attack :-
	write('Kamu sedang tidak dalam battle, mau nyerang naon?'), nl, !.

damagePlayer(Dmg) :-
	hp(HP),
	defense(Def),
	DmgMul is 1 - ((0.06 * Def) / (1 + 0.06 * Def)),
	BiasDmg is Dmg * DmgMul,
	NewHP is HP - BiasDmg,
	(
		NewHP < 0.01,
		format('Kamu diserang, menerima ~2f damage.', [BiasDmg]), nl,nl, sleep(1),
		write('Kamu tewas.'), nl, nl,
		die, !;
		retractall(hp(_)),
		asserta(hp(NewHP)),
		format('Kamu diserang, menerima ~2f damage.', [BiasDmg]), nl,nl
	).
