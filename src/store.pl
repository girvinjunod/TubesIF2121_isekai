store :- % Permainan belum dimulai
  state(not_started), !,
  write('Permainan belum dimulai, kamu tidak dapat ke store.'), nl.

store :- % Player tidak di store
  state(free),
  player_cell(Cell),
  Cell \= store_cell, !,
  write('Gagal membuka store karena kamu sedang tidak di store.'), nl.

store :- % Player di store
  state(free),
  player_cell(Cell),
  Cell = store_cell, !,
  gold(UangTersedia),
  write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
  write('                                    ~Store~                                     \n'),
  write('                                                                                \n'),
 format('  Uang tersedia: ~w\n', [UangTersedia]),
  write('                                                                                \n'),
  write('  Item yang kami jual:                                                          \n'),
  write('   - potion (50 gold)                                                           \n'),
  write('   - adrenalin (200 gold)                                                       \n'),
  write('   - elixir (2000 gold)                                                         \n'),
  write('   - kupon_gacha_item (70 gold)                                                 \n'),
  write('   - kupon_gacha_equipment (90 gold)                                            \n'),
  write('                                                                                \n'),
  write('                                                                                \n'),
  write('                        Kami juga menerima penjualan item                       \n'),
  write('                               dengan perintah sell.                            \n'),
  write('                   Kami hanya membeli pada setengah harga pasar.                \n'),
  write('                                                                                \n'),
  write('                                                                                \n'),
  write('                      Dilarang mencuri (steal) di toko ini.                     \n'),
  write('                Jika Anda mencuri, Anda akan merasakan akibatnya.               \n'),
  write('                                                                                \n'),
  write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
  nl,
  write('Masukkan nama item yang ingin dibeli: '),
  read(Item),
  (
    ( % Kasus item yg dibeli ga ada
      \+hargaItem(Item, Harga, buyable), !,nl,
      write('Kami tidak menjual item itu :('), nl
    );
    write('Berapa banyak? '),
    read(Qty),
    gold(UangTersedia),
    hargaItem(Item, Harga), buyable(Item),
    QtyHarga is Harga*Qty,
    (
      ( % Uang kurang
        UangTersedia < QtyHarga, !,nl,
        write('Kamu kurang cukup kaya untuk membeli item ini.'), nl,
        write('Go slay some monster atau ambil lah quest terlebih dahulu.'), nl
      );
      ( % Transaksi berhasil
        NewGold is UangTersedia - QtyHarga,
        retractall(gold(_)),
        asserta(gold(NewGold)),nl,
        format('Selamat atas pembelian ~w kamu! Senang berbisnis dengan mu.', [Item]), nl,
        addToInventory(Item, Qty), !
      )
    )
  ).

sell :- % Permainan belum dimulai
  state(not_started), !,
  write('Permainan belum dimulai, kamu tidak dapat ke store.'), nl.

sell :- % Player tidak di store
  state(free),
  player_cell(Cell),
  Cell \= store_cell, !,
  write('Gagal membuka store karena kamu sedang tidak di store.'), nl.

sell :- % Player tidak memiliki item
  state(free),
  player_cell(Cell),
  Cell = store_cell,
  inventory(I),
  I = [], !,
  write('Kamu tidak memiliki item yang dapat dijual :('), nl.

sell :- % Player di store
  state(free),
  player_cell(Cell),
  Cell = store_cell, !,
  inventory,
  nl,
  write('Masukkan nama item yang mau kamu jual: '),
  read(Item),
  (
    ( % Kasus item yg dibeli ga ada
      \+hargaItem(Item, Harga), !,
      write('Kami tidak membeli item itu :('), nl
    );
    write('Berapa banyak? '),
    read(Qty),
    (
      (% Kasus ga punya itemnya
        countItemInInvetory(Item, C),
        C < Qty, !,
        format('Kamu tidak memiliki ~w sebanyak itu :(', [Item]), nl
      );
      (
        gold(UangTersedia),
        hargaItem(Item, Harga),
        NewGold is UangTersedia + ((Harga // 2)*Qty),
        retractall(gold(_)),
        asserta(gold(NewGold)),
        format('Terima kasih atas penjualan ~w kamu! Senang berbisnis dengan mu.', [Item]), nl,
        drop(Item, Qty, sell), !
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
    (Y =:= 2, !, Item = nanomachines);
    (Y =:= 1, !, Item = batman_cloak);
    (Y =:= 0, !, Item = bathrobe)
  ).
randomizeArmor(X, Item) :-
  X < 13, !,
  Y is X mod 3,
  (
    (Y =:= 2, !, Item = diamond_armor);
    (Y =:= 1, !, Item = dragonscale_cloak);
    (Y =:= 0, !, Item = lab_coat)
  ).
randomizeArmor(X, Item) :-
  X < 25, !,
  Y is X mod 3,
  (
    (Y =:= 2, !, Item = dragon_armor);
    (Y =:= 1, !, Item = shadow_cloak);
    (Y =:= 0, !, Item = celestial_robe)
  ).
randomizeArmor(X, Item) :-
  X < 50, !,
  Y is X mod 3,
  (
    (Y =:= 2, !, Item = steel_armor);
    (Y =:= 1, !, Item = ironhide_cloak);
    (Y =:= 0, !, Item = grand_magic_robe)
  ).
randomizeArmor(X, Item) :-
  X < 100, !,
  Y is X mod 3,
  (
    (Y =:= 2, !, Item = iron_armor);
    (Y =:= 1, !, Item = wolfhide_cloak);
    (Y =:= 0, !, Item = magic_robe)
  ).

gachaArmor(Item) :-
  acak(0, 100, R),
  randomizeArmor(R, Item).

randomizeWeapon(X, Item) :-
  X < 5, !,
  Y is X mod 3,
  (
    (Y =:= 2, !, Item = ultima_blade);
    (Y =:= 1, !, Item = railgun);
    (Y =:= 0, !, Item = paddlepop)
  ).
randomizeWeapon(X, Item) :-
  X < 13, !,
  Y is X mod 3,
  (
    (Y =:= 2, !, Item = masamune);
    (Y =:= 1, !, Item = sniper_rifle);
    (Y =:= 0, !, Item = celestial_staff)
  ).
randomizeWeapon(X, Item) :-
  X < 25, !,
  Y is X mod 3,
  (
    (Y =:= 2, !, Item = dragon_sword);
    (Y =:= 1, !, Item = portable_ballista);
    (Y =:= 0, !, Item = grand_magic_staff)
  ).
randomizeWeapon(X, Item) :-
  X < 50, !,
  Y is X mod 3,
  (
    (Y =:= 2, !, Item = steel_sword);
    (Y =:= 1, !, Item = longbow);
    (Y =:= 0, !, Item = magic_staff)
  ).
randomizeWeapon(X, Item) :-
  X < 100, !,
  Y is X mod 3,
  (
    (Y =:= 2, !, Item = iron_sword);
    (Y =:= 1, !, Item = crossbow);
    (Y =:= 0, !, Item = magic_wand)
  ).
gachaWeapon(_) :-
  state(S),
  S = not_started, !,
  write('Permainan belum dimulai.').

gachaWeapon(Item) :-
  acak(0, 100, R),
  randomizeWeapon(R, Item).

gachaEquipment(_) :-
  state(S),
  S = not_started, !,
  write('Permainan belum dimulai.').

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
  format('Selamat, kamu mendapatkan ~w dari gacha! :D', [Item]), nl.

/*
* drop chancenya (dri gacha)
* potion: 50%
* skincare: 15%
* steroids: 15%
* adrenalin: 6 %
* elixir: 2%
* spicy_chili: 5 %
* holy_water: 5 %
* dragon's tears: 1 %
* devil_fruit: 1 %
*
*/
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
      R > 49,
      (R > 98 ,!, Item = devil_fruit);
	  (R > 97 ,!, Item = dragons_tears);
	  (R > 95 ,!, Item = elixir);
	  (R > 90 ,!, Item = holy_water);
	  (R > 85 ,!, Item = spicy_chili);
	  (R > 79 ,!, Item = adrenalin);
	  (R > 64 ,!, Item = skincare);
      (R > 49, !, Item = steroids)
    );
    (Item = potion)
  ),
  addToInventory(Item),
  format('Selamat, kamu mendapatkan: ~w dari gacha! :D', [Item]), nl.
  
steal :- % Permainan belum dimulai
  state(not_started), !,
  write('Permainan belum dimulai, kamu tidak dapat ke store.'), nl.

steal :- % Player tidak di store
  state(free),
  player_cell(Cell),
  Cell \= store_cell, !,
  write('Gagal mencuri dari store karena kamu sedang tidak di store.'), nl.
steal :-
	randomize_monster(shopkeeper),
	setState(battle),
	retractall(special_cooldown(_)),
	asserta(special_cooldown(0)),nl,
	write('Kamu tertangkap basah mencoba untuk mencuri.\n'),nl,
	write('Sang shopkeeper mencegat kamu yang mencoba kabur dan battle pun dimulai.\n'),
	nl,nl,
	write('-----------------------------------------------------SECRET BOSS FIGHT!!-----------------------------------------------------\n'),nl,nl.
