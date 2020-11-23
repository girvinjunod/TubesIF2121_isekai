:- include('player.pl').
:- dynamic(in_battle/0).
:- dynamic(current_monster/1).
:- dynamic(monster_hp/1).
:- dynamic(monster_atk/1).
:- dynamic(monster_def/1).
:- dynamic(monster_exp/1).
:- dynamic(monster_turn/1).
:- dynamic(monster_lvl/1).

monster_encounter :-
	\+in_battle,
	random(X),
	X < 0.2,
	asserta(in_battle),
	random(Y),
	randomize_monster(Y),
	write('Encountered '),
	current_monster(Name),
	write(Name),
	write(' in the fields.'),
	write('Level: '),
	asserta(monster_turn(0)),
	!.
monster_encounter :- in_battle.

randomize_monster(X) :-
	X < 0.5,
	asserta(current_monster('slime')),
	asserta(monster_hp(200)),
	asserta(monster_atk(50)),
	asserta(monster_def(50)),
	asserta(monster_exp(65)),
	asserta(monster_lvl(1)),
	!.
randomize_monster(X) :-
	X < 0.8,
	asserta(current_monster('goblin')),
	asserta(monster_hp(300)),
	asserta(monster_atk(75)),
	asserta(monster_def(60)),
	asserta(monster_exp(85)),
	asserta(monster_lvl(5)),
	!.
randomize_monster(X) :-
	X < 0.99,
	asserta(current_monster('wolf')),
	asserta(monster_hp(400)),
	asserta(monster_atk(135)),
	asserta(monster_def(95)),
	asserta(monster_exp(115)),
	asserta(monster_lvl(20)),
	!.

randomize_monster(_) :-
	asserta(current_monster('ghost')),
	asserta(monster_hp(560)),
	asserta(monster_atk(200)),
	asserta(monster_def(100)),
	asserta(monster_exp(200)),
	asserta(monster_lvl(50)).

monster_count_move :-
	monster_turn(T),
	T > 0,
	U is T - 1,
	retractall(monster_turn(_)),
	asserta(monster_turn(U)), !.

monster_count_move :- monster_turn(T), T = 0.

monster_move :-
	monster_turn(T),
	random(X),
	X < 0.3,
	T =< 0,
	monster_special,
	monster_count_move,
	!.

monster_move :-
	monster_atk(X),
	damagePlayer(X),
	current_monster(Name),
	write(Name),
	write(' dealt '),
	write(X),
	write(' damage.'),
	monster_count_move.

monster_special :-
	monster_atk(atk),
	dmg is atk * 3,
	damagePlayer(dmg),
	asserta(monster_turn(3)).

damage_monster(X) :-
	monster_hp(Curr),
	After is Curr - X,
	After =< 0,
	retractall(monster_hp(Curr)),
	monster_die,
	!.

damage_monster(X) :-
	monster_hp(Curr),
	After is Curr - X,
	retractall(monster_hp(Curr)),
	asserta(monster_hp(After)).

monster_die :-
	current_monster(Name),
	monster_exp(XP),
	earnExp(XP),
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
	!.
