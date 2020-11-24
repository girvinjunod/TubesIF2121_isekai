/*
* drop chancenya (dri steal sama gacha)
* SSR: 5%
* SR: 8%
* Ultra Rare: 12%
* Rare: 25%%
* Common: 50%
*/

randomizeArmor(X, Item) :-
  X < 5, !,
  Y is X mod 3,
  (
    (Y =:= 2, !, Item = armor_5);
    (Y =:= 1, !, Item = jaket_5);
    (Y =:= 0, !, Item = kaos_5)
  ).
randomizeArmor(X, Item) :-
  X < 13, !,
  Y is X mod 3,
  (
    (Y =:= 2, !, Item = armor_4);
    (Y =:= 1, !, Item = jaket_4);
    (Y =:= 0, !, Item = kaos_4)
  ).
randomizeArmor(X, Item) :-
  X < 25, !,
  Y is X mod 3,
  (
    (Y =:= 2, !, Item = armor_3);
    (Y =:= 1, !, Item = jaket_3);
    (Y =:= 0, !, Item = kaos_3)
  ).
randomizeArmor(X, Item) :-
  X < 50, !,
  Y is X mod 3,
  (
    (Y =:= 2, !, Item = armor_2);
    (Y =:= 1, !, Item = jaket_2);
    (Y =:= 0, !, Item = kaos_2)
  ).
randomizeArmor(X, Item) :-
  X < 100, !,
  Y is X mod 3,
  (
    (Y =:= 2, !, Item = armor_1);
    (Y =:= 1, !, Item = jaket_1);
    (Y =:= 0, !, Item = kaos_1)
  ).

gachaArmor(Item) :-
  acak(0, 100, R),
  randomizeArmor(R, Item).

randomizeWeapon(X, Item) :-
  X < 5, !,
  Y is X mod 3,
  (
    (Y =:= 2, !, Item = pedang_5);
    (Y =:= 1, !, Item = busur_panah_dan_jangka_5);
    (Y =:= 0, !, Item = magic_stick_5)
  ).
randomizeWeapon(X, Item) :-
  X < 13, !,
  Y is X mod 3,
  (
    (Y =:= 2, !, Item = pedang_4);
    (Y =:= 1, !, Item = busur_panah_dan_jangka_4);
    (Y =:= 0, !, Item = magic_stick_4)
  ).
randomizeWeapon(X, Item) :-
  X < 25, !,
  Y is X mod 3,
  (
    (Y =:= 2, !, Item = pedang_3);
    (Y =:= 1, !, Item = busur_panah_dan_jangka_3);
    (Y =:= 0, !, Item = magic_stick_3)
  ).
randomizeWeapon(X, Item) :-
  X < 50, !,
  Y is X mod 3,
  (
    (Y =:= 2, !, Item = pedang_2);
    (Y =:= 1, !, Item = busur_panah_dan_jangka_2);
    (Y =:= 0, !, Item = magic_stick_2)
  ).
randomizeWeapon(X, Item) :-
  X < 100, !,
  Y is X mod 3,
  (
    (Y =:= 2, !, Item = pedang_1);
    (Y =:= 1, !, Item = busur_panah_dan_jangka_1);
    (Y =:= 0, !, Item = magic_stick_1)
  ).

gachaWeapon(Item) :-
  acak(0, 100, R),
  randomizeWeapon(R, Item).

gachaEquipment :-
  countItemInInvetory(kupon_gacha_equipment, Cnt),
  Cnt =:= 0, !,
  write('Kamu tidak memiliki kupon gacha :(, silakan beli dahulu di store.').

gachaEquipment :-
  removeFromInventory(kupon_gacha_equipment),
  write('Melakukan gacha...'), nl,
  write('Deg... '),
  sleep(1),
  write('Deg... '),
  sleep(1),
  write('Tetot!'), nl,
  acak(0, 2, R),
  (
    (R =:= 0, !, gachaArmor(Item));
    (R =:= 1, !, gachaWeapon(Item))
  ),
  addToInventory(Item),
  format('Selamat, kamu mendapatkan: ~w dari gacha! :D', [Item]), nl.

gachaItem :-
  countItemInInvetory(kupon_gacha_item, Cnt),
  Cnt =:= 0, !,
  write('Kamu tidak memiliki kupon gacha :(, silakan beli dahulu di store.').

gachaItem :-
  write('Melakukan gacha...'), nl,
  write('Deg... '),
  sleep(1),
  write('Deg... '),
  sleep(1),
  write('Tetot!'), nl,
  acak(0, 100, R),
  (
    (
      R < 25,
      (R < 13, !, Item = skincare);
      (R < 25, !, Item = steroids)
    );
    (Item = potion)
  ),
  addToInventory(Item),
  format('Selamat, kamu mendapatkan: ~w dari gacha! :D', [Item]), nl.
