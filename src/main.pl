/* anjay mabar */
:- include('inventory.pl').
:- include('player.pl').
:- include('menu.pl').
:- include('items.pl').
:- include('tutorial.pl').

game :-
    menu.

start :-
  write('Siapa namamu, petualang? '),
  read(NamaPemain),
  setName(NamaPemain),
  tpb(NamaPemain).
