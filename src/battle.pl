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
	acak(X),
	X < 0.4,
	acak(Y),
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
	randomize_monster(Y, TrueMLvl),
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
	X < 0.5,
	setState(battle),
	asserta(current_monster('slime')),
	HP is 50 * Lvl + 150,
	Atk is 3 * Lvl + 10,
	Def is 10 * Lvl + 100,
	XP is 10 * Lvl + 50,
	Gold is 10 * (Lvl + 1),
	asserta(monster_hp(HP)),
	asserta(monster_maxHP(HP)),
	asserta(monster_atk(Atk)),
	asserta(monster_def(Def)),
	asserta(monster_exp(XP)),
	asserta(monster_lvl(Lvl)),
	asserta(monster_gold(Gold)),
	!.
randomize_monster(X, Lvl) :-
	X < 0.8,
	setState(battle),
	asserta(current_monster('goblin')),
	(
		Lvl < 10, MLvl is 10;
		Lvl > 30, MLvl is 30;
		MLvl is Lvl
	),
	HP is 25 * MLvl + 150,
	Atk is 10 * MLvl + 15,
	Def is 5 * MLvl + 5,
	XP is 35 * MLvl + 225,
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
	X < 0.99,
	setState(battle),
	asserta(current_monster('wolf')),
	(
		Lvl < 15, MLvl is 15;
		Lvl > 45, MLvl is 45;
		MLvl is Lvl
	),
	HP is 30 * MLvl + 150,
	Atk is 15 * MLvl + 20,
	Def is 10 * MLvl + 5,
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
		Lvl < 30, MLvl is 30;
		Lvl > 70; MLvl is 70;
		MLvl is Lvl
	),
	HP is 40 * MLvl + 200,
	Atk is 20 * MLvl + 2,
	Def is 30 * MLvl + 5,
	XP is 100 * MLvl + 325,
	Gold is 10 * (Lvl + 2),
	asserta(monster_hp(HP)),
	asserta(monster_maxHP(HP)),
	asserta(monster_atk(Atk)),
	asserta(monster_def(Def)),
	asserta(monster_exp(XP)),
	asserta(monster_lvl(MLvl)),
	asserta(monster_gold(Gold)).

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
    state(tutorial),
	current_monster(Name),
	monster_exp(XP),
	monster_gold(Gold),
	earnExp(XP),
	earnGold(Gold),
	update_active_quest(Name),
	nl,
	write(Name),
	write(' telah dikalahkan.'), nl,
	write('Mendapat '),
	write(XP),
	write(' experience points.'), nl,
	format('Kamu juga mendapatkan ~w gold.', [Gold]),
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
	current_monster(Name),
	monster_exp(XP),
	monster_gold(Gold),
	earnExp(XP),
	earnGold(Gold),
	update_active_quest(Name),
	nl,
	write(Name),
	write(' telah dikalahkan.'), nl,
	write('Mendapat '),
	write(XP),
	write(' experience points.'), nl,
	format('Kamu juga mendapatkan ~w gold.', [Gold]),nl,
	retractall(current_monster(_)),
	retractall(monster_hp(_)),
	retractall(monster_atk(_)),
	retractall(monster_def(_)),
	retractall(monster_exp(_)),
	retractall(monster_gold(_)),
    retractall(monster_turn(_)),
	setState(free), !.

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

steal :-
  acak(0, 100, R),
  (
	(
	  R < 35,
	  (R < 15, !, Item = kupon_gacha_equipment);
	  (R < 35, !, Item = kupon_gacha_item)
	);
	(Item = potion)
  ),
  addToInventory(Item),
  write('Berhasil mencuri '), write(Item), write(' dari monster'), nl.

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
			steal
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

special_attack :-
	write('Kamu sedang tidak dalam battle, mau nyerang naon?'), nl, !.

attack :-
	special_counter,
	attack(Atk),
	damage_monster(Atk), !,
	write('Kamu menyerang musuh dengan attack insert nama.\n'),
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
		NewHP < 0,
		write('Kamu meninggal.'), nl,
		die, !;
		retractall(hp(_)),
		asserta(hp(NewHP)),
		format('Kamu diserang, menerima ~2f damage.', [BiasDmg]), nl,nl
	).
