/* anjay mabar */
:- include('inventory.pl').
:- include('player.pl').
:- include('menu.pl').
:- include('items.pl').
:- include('tutorial.pl').
:- include('map.pl').
:- include('battle.pl').

:- dynamic(state/1).

state(free).
/* Kemungkinan states:
 * - tutorial
 * - not_started
 * - free
 * - shop
 * - battle
 */

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

setState(X) :-
  retractall(state(_)),
  asserta(state(X)).

exit :-
  halt.
