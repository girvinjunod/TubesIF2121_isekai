:- dynamic(inventory/1).
:- include('list.pl').

inventory([
  %potion,
  %potion,
  %potion,
  %potion,
  %potion
]).

listInventory :- inventory(X), write(X).

/* Inventory operator */

addToInventory(_) :- inventory(Inven), countList(Inven, Cnt), Cnt >= 100, !, fail.
addToInventory(X) :- \+inventory(_), asserta(inventory([X])), !.
addToInventory(X) :- inventory(OldInven),
  retractall(inventory(_)),
  addToList(X, OldInven, NewInven),
  asserta(inventory(NewInven)), !.

removeFromInventory(X) :- inventory(OldInven),
  retractall(inventory(_)),
  removeFromList(X, OldInven, NewInven),
  asserta(inventory(NewInven)).

countItemInInvetory(X, C) :-
  inventory(I),
  countItem(X, I, Cnt),
  C is Cnt.
