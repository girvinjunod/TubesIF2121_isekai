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
  (item(H, consumable),
  hargaItem(H, Harga,_)), !,
  nl,
  format('  ~w. ~w', [Counter, H]), nl,
  item_effect(H, StatsAffacted, Effect),
   write('     type  : consumable'), nl,
  format('     effect: ~w ~w', [Effect, StatsAffacted]), nl,
  format('     harga : ~w gold', [Harga]), nl,
  NextCounter is Counter + 1,
  listInventory(NextCounter, T).
  
listInventory(Counter, [H|T]) :-
  (item(H, consumable),
  hargaItem(H, Harga)), !,
  nl,
  format('  ~w. ~w', [Counter, H]), nl,
  item_effect(H, StatsAffacted, Effect),
   write('     type  : consumable'), nl,
  format('     effect: ~w ~w', [Effect, StatsAffacted]), nl,
  format('     harga : ~w gold', [Harga]), nl,
  NextCounter is Counter + 1,
  listInventory(NextCounter, T).

listInventory(Counter, [H|T]) :-
  item(H, WA, Role), !,
  item_effect(H, StatsAffacted, Effect),
  hargaItem(H, Harga), !,
  nl,
  format('  ~w. ~w', [Counter, H]), nl,
  (
  (StatsAffacted = weapon,
  X = damage
  );
  (X = defense)
   ),
  format('     ~w untuk ~w', [WA, Role]), nl,
   write('     type  : equipment'), nl,
  format('     effect: ~w ~w', [Effect, X]), nl,
  format('     harga : ~w gold', [Harga]), nl,
  NextCounter is Counter + 1,
  listInventory(NextCounter, T).

/* Inventory operator */

addToInventory(_) :- inventory(Inven), countList(Inven, Cnt), Cnt >= 100, !, fail.
addToInventory(X) :- \+inventory(_), asserta(inventory([X])), !.
addToInventory(X) :- inventory(OldInven),
  retractall(inventory(_)),
  addToList(X, OldInven, NewInven),
  asserta(inventory(NewInven)), !.

addToInventory(X, 1) :-
  addToInventory(X).

addToInventory(X, Cnt) :-
  addToInventory(X),
  NewCnt is Cnt-1,
  addToInventory(X, NewCnt).

removeFromInventory(X) :- inventory(OldInven),
  retractall(inventory(_)),
  removeFromList(X, OldInven, NewInven),
  asserta(inventory(NewInven)).

countItemInInvetory(X, C) :-
  inventory(I),
  countItem(X, I, Cnt),
  C is Cnt.
