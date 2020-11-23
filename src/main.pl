/* anjay mabar */
:- include('inventory.pl').
:- include('player.pl').
:- include('menu.pl').
:- include('items.pl').
:- include('tutorial.pl').
:- include('map.pl').
:- include('battle.pl').

:- dynamic(state/1).

state(not_started).
/* Kemungkinan states:
 * - tutorial
 * - not_started
 * - free
 * - shop
 * - battle
 */

setState(X) :-
  retractall(state(_)),
  asserta(state(X)).

exit :-
  halt.

acak(X) :-
  real_time(RT),
  set_seed(RT),
  random(R),
  X is R,
  write(X).

acak(P,Q,X) :-
  real_time(RT),
  set_seed(RT),
  random(P,Q,R),
  X is R,
  write(X).

start :-
  mainMenu,
  nl,
  write('Apa yang mau kamu lakukan (new / load / exit): '),
  read(Act),
  nl, nl, nl,
  ((
    Act = new,
    newGame
  );
  (
    Act = load,
    loadGame
  );
  (
    Act = exit,
    exit
  )).

newGame :-
  randomize_map,
  write('Siapa namamu, Petualang? '),
  read(NamaPemain),
  setName(NamaPemain),
  tpb(NamaPemain),
  setState(free).

loadGame :-
  write('Fitur belum diimplementasikan :('), nl.

save :-
  write('Fitur belum diimplementasikan :('), nl.
