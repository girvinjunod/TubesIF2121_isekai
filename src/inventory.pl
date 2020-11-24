:- dynamic(inventory/1).
:- include('list.pl').

inventory([
  %potion,
  %potion,
  %potion,
  %pedang_1,
  %jaket_1,
  %xDef,
  %xAtk,
  %magic_stick_1,
  %kaos_1
]).

listInventory(_, []) :-
  true, !. %do nothing
listInventory(Counter, [H|T]) :-
  item(H, consumable), !,
  nl,
  format('  ~w. ~w', [Counter, H]), nl,
  item_effect(H, StatsAffacted, Effect),
   write('     type: consumable'), nl,
  format('     effect: ~w ~w', [Effect, StatsAffacted]), nl,
  NextCounter is Counter + 1,
  listInventory(NextCounter, T).

listInventory(Counter, [H|T]) :-
  item(H, WA, Role), !,
  nl,
  format('  ~w. ~w', [Counter, H]), nl,
  item_effect(H, StatsAffacted, Effect),
  format('     ~w untuk ~w', [WA, Role]), nl,
   write('     type: equipment'), nl,
  format('     effect: ~w ~w', [Effect, StatsAffacted]), nl,
  NextCounter is Counter + 1,
  listInventory(NextCounter, T).

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
