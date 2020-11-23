/* anjay mabar */
:- include('inventory.pl').
:- include('player.pl').
:- include('menu.pl').
:- include('items.pl').
:- include('tutorial.pl').
:- include('map.pl').

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
  tpb(NamaPemain).

exit :-
  halt.
