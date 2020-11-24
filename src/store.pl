store :-
  state(not_started), !,
  write('Permainan belum dimulai, kamu tidak dapat ke store.'), nl.

store :- % Player tidak di store
  state(free),
  player_cell(Cell),
  Cell \= store_cell, !,
  write('Gagal membuka store karena kamu sedang tidak di store.'), nl.

store :- % Item dijual
  state(free),
  player_cell(Cell),
  Cell = store_cell, !,
  write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
  write('%                                   ~Store~                                    %\n'),
  write('%                                                                              %\n'),
  write('% Item yang kami jual:                                                         %\n'),
  write('% 1. potion (50 gold)                                                          %\n'),
  write('% 2. kupon_gacha_item (70 gold)                                                %\n'),
  write('% 3. kupon_gacha_equipment (90 gold)                                           %\n'),
  write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
  nl,
  write('Masukkan nama item yang mau kamu beli: '),
  read(Item),
  (
    ( % Kasus item yg dibeli ga ada
      \+hargaItem(Item, Harga), !,
      write('Kami tidak menjual item itu :(.'), nl
    );
    (
      (
        (
          gold(UangTersedia),
          hargaItem(Item, Harga),
          UangTersedia < Harga, !,
          write('Kamu kurang cukup kaya untuk membeli item ini.'), nl,
          write('Go slay some monster atau ambil lah quest terlebih dahulu.'), nl
        );
        (
          gold(UangTersedia),
          hargaItem(Item, Harga),
          NewGold is UangTersedia - Harga,
          retractall(gold(_)),
          asserta(gold(NewGold)),
          format('Selamat atas pembelian ~w kamu! Senang berbisnis dengan mu.', [Item]), nl,
          addToInventory(Item)
        )
      )
    )
  ).

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
  removeFromInventory(kupon_gacha_item),
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
