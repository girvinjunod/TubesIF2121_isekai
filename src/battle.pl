:- dynamic(current_monster/1).
:- dynamic(special_cooldown/1).
:- dynamic(monster_hp/1).
:- dynamic(monster_atk/1).
:- dynamic(monster_def/1).
:- dynamic(monster_exp/1).
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
	write('Encountered '),
	current_monster(Name),
	monster_lvl(Lv),
	write(Name),
	write(' in the fields.'), nl,
	write('Level: '),
	write(Lv),
	asserta(monster_turn(0)),
	!.

monster_encounter.

randomize_monster(X, Lvl) :-
	X < 0.5,
	setState(battle),
	asserta(current_monster('slime')),
	HP is 5 * Lvl + 5,
	Atk is 3 * Lvl + 2,
	Def is 2 * Lvl + 1,
	XP is 25 * Lvl + 150,
	asserta(monster_hp(HP)),
	asserta(monster_atk(Atk)),
	asserta(monster_def(Def)),
	asserta(monster_exp(XP)),
	asserta(monster_lvl(Lvl)),
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
	HP is 10 * MLvl + 3,
	Atk is 4 * MLvl + 2,
	Def is 4 * MLvl + 1,
	XP is 35 * MLvl + 225,
	asserta(monster_hp(HP)),
	asserta(monster_atk(Atk)),
	asserta(monster_def(Def)),
	asserta(monster_exp(XP)),
	asserta(monster_lvl(MLvl)),
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
	HP is 15 * MLvl + 5,
	Atk is 8 * MLvl + 2,
	Def is 10 * MLvl + 5,
	XP is 55 * MLvl + 325,
	asserta(monster_hp(HP)),
	asserta(monster_atk(Atk)),
	asserta(monster_def(Def)),
	asserta(monster_exp(XP)),
	asserta(monster_lvl(MLvl)),
	!.

randomize_monster(_, Lvl) :-
	setState(battle),
	asserta(current_monster('ghost')),
	(
		Lvl < 30, MLvl is 30;
		Lvl > 70; MLvl is 70;
		MLvl is Lvl
	),
	HP is 50 * MLvl + 5,
	Atk is 20 * MLvl + 2,
	Def is 30 * MLvl + 5,
	XP is 100 * MLvl + 325,
	asserta(monster_hp(HP)),
	asserta(monster_atk(Atk)),
	asserta(monster_def(Def)),
	asserta(monster_exp(XP)),
	asserta(monster_lvl(MLvl)).

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
	monster_count_move,
	!.

monster_move :-
	monster_atk(X),
	damagePlayer(X),
	monster_count_move.

monster_special :-
	monster_atk(atk),
	dmg is atk * 3,
	damagePlayer(dmg),
	asserta(monster_turn(3)).

damage_monster(Dmg) :-
	monster_hp(HP),
	monster_def(Def),
	DmgMul is 1 - ((0.06 * Def) / (1 + 0.06 * Def)),
	BiasDmg is Dmg * DmgMul,
	NewHP is HP - BiasDmg,
	retractall(monster_hp(HP)),
	asserta(monster_hp(NewHP)),
	write('You dealt '),
	write(BiasDmg),
	write(' damage.'), nl,
	(
		NewHP =< 0,
		monster_die;
		NewHP > 0
	).

monster_die :-
	current_monster(Name),
	monster_exp(XP),
	earnExp(XP),
	update_active_quest(Name),
	write(Name),
	write(' has been defeated.'), nl,
	write('Gained '),
	write(XP),
	write(' Experience points.'),
	retractall(current_monster(_)),
	retractall(monster_hp(_)),
	retractall(monster_atk(_)),
	retractall(monster_def(_)),
	retractall(monster_exp(_)),
	setState(free),
	!.

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
			write('Kamu gagal kabur :\'(.'), !
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
  write('Stolen '), write(Item), write(' from monster'), nl.

special_attack :-
	special_cooldown(0),
	(
		(
			playerClass(swordsman),
			write('Lionheart!!!'), nl,
			hp(Dmg),
			damage_monster(Dmg)
		), !;
		(
			playerClass(archer),
			attack(Atk),
			write('Steal!!!'), nl,
			BiasAtk is Atk * 0.5,
			damage_monster(BiasAtk),
			steal
		), !;
		(
			playerClass(sorcerer),
			write('Ekusupurosion!!!'), nl,
			acak(0, 999, GachaDmg),
			damage_monster(GachaDmg)
		)
	),
	retractall(special_cooldown(_)),
	asserta(special_cooldown(3)),
	!.

special_attack :-
	write('You can\'t use that now, that\'d be cheating...').

attack :-
	special_counter,
	state(battle),
	attack(Atk),
	damage_monster(Atk),
	monster_move,
	!.

attack.

damagePlayer(Dmg) :-
	hp(HP),
	defense(Def),
	DmgMul is 1 - ((0.06 * Def) / (1 + 0.06 * Def)),
	BiasDmg is Dmg * DmgMul,
	NewHP is HP - BiasDmg,
	(
		NewHP < 0,
		write('You died.'), nl,
		die, !;
		retractall(hp(_)),
		asserta(hp(NewHP)),
		write('You were scratched, '),
		write(BiasDmg),
		write(' damage.'), nl
	).
