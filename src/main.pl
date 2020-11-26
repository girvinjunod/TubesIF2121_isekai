/* anjay mabar */
:- include('inventory.pl').
:- include('player.pl').
:- include('menu.pl').
:- include('items.pl').
:- include('tutorial.pl').
:- include('map.pl').
:- include('battle.pl').
:- include('store.pl').
:- include('equipment.pl').
:- include('quest.pl').
:- include('boss.pl').

:- dynamic(state/1).

state(not_started).
/* Kemungkinan states:
 * - not_started
 * - free
 * - shop
 * - battle
 * - mati
 * - boss
 * - tutorial
 * - end
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
  X is R.

acak(P,Q,X) :-
  real_time(RT),
  set_seed(RT),
  random(P,Q,R),
  X is R.

start :-
  mainMenu,
  nl,
  write('Apa yang mau kamu lakukan (new / exit): '),
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
  reset,
  setState(tutorial),
  randomize_map,
  generate_quest,
  write('Siapa namamu, Petualang? '),
  read(NamaPemain),
  setName(NamaPemain),
  tpb(NamaPemain).

loadGame :-
  write('Fitur belum diimplementasikan :('), nl.

save :-
  write('Fitur belum diimplementasikan :('), nl.
