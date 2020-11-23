/* spesifikasi map:
 *	(R,C) itu sel di baris ke-R kolom ke-C
 * pojok kiri atas itu (1,1), pojok kanan bawah itu (nRow,nCol)
 * koordinat (1,C), (nRow,C), (R,1), (R,nCol) selalu pagar untuk 1<=R<=nRow, 1<=C<=nCol
 */

/* size map */
nRow(20).
nCol(20).


/* koordinat-koordinat pagar (#) */
/* note: koordinat (1,C), (nRow,C), (R,1), (R,nCol) selalu pagar untuk 1<=R<=nRow, 1<=C<=nCol */
fence(R,_) :- R = 1.
fence(R,_) :- nRow(R).
fence(_,C) :- C = 1.
fence(_,C) :- nCol(C).
fence(5,5).
fence(6,6).
fence(7,7).

/* koordinat store (S) */
store_coordinate(3,3).

/* koordinat dungeon boss (D) */
dungeon_boss_coordinate(3,2).

/* koordinat pengambilan quest (Q) */
quest_coordinate(3,4).

/* dynamic predicate koordinat player */
:- dynamic(player_coordinate/2).

/* koordinat player (P) */
player_coordinate(2,2).

/* map-printing functions */
printCell(R,C) :-
	fence(R,C),
	!,
	write('#').
printCell(R,C) :-
	store_coordinate(R,C),
	!,
	write('S').
printCell(R,C) :-
	dungeon_boss_coordinate(R,C),
	!,
	write('D').
printCell(R,C) :-
	quest_coordinate(R,C),
	!,
	write('Q').
printCell(R,C) :-
	player_coordinate(R,C),
	!,
	write('P').
printCell(_,_) :-
	write('-').

map :-
	nRow(R),
	nCol(C),
	forall(between(1,R,I),(
		forall(between(1,C,J),(
			printCell(I,J)
		)),
		nl
	)).

/* player actions */
w :-
	player_coordinate(R,C),
	NewR is R - 1,
	fence(NewR,C),
	!,
	write('invalid move'), nl.
w :-
	player_coordinate(R,C),
	NewR is R - 1,
	retractall(player_coordinate(_,_)),
	asserta(player_coordinate(NewR,C)),
	write('you moved north'), nl.

a :-
	player_coordinate(R,C),
	NewC is C - 1,
	fence(R,NewC),
	!,
	write('invalid move'), nl.
a :-
	player_coordinate(R,C),
	NewC is C - 1,
	retractall(player_coordinate(_,_)),
	asserta(player_coordinate(R,NewC)),
	write('you moved west'), nl.

s :-
	player_coordinate(R,C),
	NewR is R + 1,
	fence(NewR,C),
	!,
	write('invalid move'), nl.
s :-
	player_coordinate(R,C),
	NewR is R + 1,
	retractall(player_coordinate(_,_)),
	asserta(player_coordinate(NewR,C)),
	write('you moved south'), nl.

d :-
	player_coordinate(R,C),
	NewC is C + 1,
	fence(R,NewC),
	!,
	write('invalid move'), nl.
d :-
	player_coordinate(R,C),
	NewC is C + 1,
	retractall(player_coordinate(_,_)),
	asserta(player_coordinate(R,NewC)),
	write('you moved east'), nl.
