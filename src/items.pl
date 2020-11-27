/* list item yang valid
 * Kalo item diubah, tambahin di store.pl
format: (nama, tipe)*/
item(potion, consumable).
item(steroids, consumable).
item(skincare, consumable).
item(adrenalin, consumable).
item(elixir, consumable).
item(spicy_chili, consumable).
item(holy_water, consumable).
item(injeksi_hormon, consumable).
item(uc1000, consumable).
item(devil_fruit, consumable).
item(dragons_tears, consumable).
item(kupon_gacha_equipment, consumable).
item(kupon_gacha_item, consumable).

hargaItem(potion, 50, buyable).
hargaItem(adrenalin, 200, buyable).
hargaItem(elixir, 2000, buyable).
hargaItem(kupon_gacha_item, 70, buyable).
hargaItem(kupon_gacha_equipment, 90, buyable).
hargaItem(steroids, 50).
hargaItem(skincare, 50).
hargaItem(spicy_chili, 70).
hargaItem(holy_water, 70).
hargaItem(injeksi_hormon, 90).
hargaItem(uc1000, 90).
hargaItem(devil_fruit, 110).
hargaItem(dragons_tears, 110).

/* list item equip
format: (nama, tipe, role) */

item(telanjang, weapon, swordsman).
item(telanjang, weapon, archer).
item(telanjang, weapon, sorcerer).
item(telanjang, armor, swordsman).
item(telanjang, armor, archer).
item(telanjang, armor, sorcerer).

item(pedang_0, weapon, swordsman).
item(armor_0, armor, swordsman).
item(pedang_1, weapon, swordsman).
item(armor_1, armor, swordsman).
item(pedang_2, weapon, swordsman).
item(armor_2, armor, swordsman).
item(pedang_3, weapon, swordsman).
item(armor_3, armor, swordsman).
item(pedang_4, weapon, swordsman).
item(armor_4, armor, swordsman).
item(pedang_5, weapon, swordsman).
item(armor_5, armor, swordsman).

item(busur_panah_dan_jangka_0, weapon, archer).
item(jaket_0, armor, archer).
item(busur_panah_dan_jangka_1, weapon, archer).
item(jaket_1, armor, archer).
item(busur_panah_dan_jangka_2, weapon, archer).
item(jaket_2, armor, archer).
item(busur_panah_dan_jangka_3, weapon, archer).
item(jaket_3, armor, archer).
item(busur_panah_dan_jangka_4, weapon, archer).
item(jaket_4, armor, archer).
item(busur_panah_dan_jangka_5, weapon, archer).
item(jaket_5, armor, archer).

item(magic_stick_0, weapon, sorcerer).
item(kaos_0, armor, sorcerer).
item(magic_stick_1, weapon, sorcerer).
item(kaos_1, armor, sorcerer).
item(magic_stick_2, weapon, sorcerer).
item(kaos_2, armor, sorcerer).
item(magic_stick_3, weapon, sorcerer).
item(kaos_3, armor, sorcerer).
item(magic_stick_4, weapon, sorcerer).
item(kaos_4, armor, sorcerer).
item(magic_stick_5, weapon, sorcerer).
item(kaos_5, armor, sorcerer).

/* list efek item */
/* format: (nama, stats_affacted, value change) */
/* Possible stats:
 * hp
 * attack
 * defense
 * level?
 * experience?
*/

item_effect(telanjang, weapon, 0).
item_effect(telanjang, armor, 0).

item_effect(potion, hp, 100).
item_effect(adrenalin, hp, 300).
item_effect(elixir, hp, 10000).
item_effect(steroids, attack, 50).
item_effect(skincare, defense, 50).
item_effect(spicy_chili, attack, 100).
item_effect(holy_water, defense, 100).
item_effect(injeksi_hormon, attack, 300).
item_effect(uc1000, defense, 300).
item_effect(dragons_tears, attack, 500).
item_effect(devil_fruit, defense, 500).
item_effect(kupon_gacha_equipment, -, -).
item_effect(kupon_gacha_item, -, -).

item_effect(magic_stick_0, weapon, 30).
item_effect(kaos_0, armor, 5).
item_effect(busur_panah_dan_jangka_0, weapon, 25).
item_effect(jaket_0, armor, 10).
item_effect(pedang_0, weapon, 15).
item_effect(armor_0, armor, 25).

% Common: (50%)
item_effect(magic_stick_1, weapon, 60).
item_effect(kaos_1, armor, 10).
item_effect(busur_panah_dan_jangka_1, weapon, 50).
item_effect(jaket_1, armor, 20).
item_effect(pedang_1, weapon, 30).
item_effect(armor_1, armor, 50).

% Rare: (30%)
item_effect(magic_stick_2, weapon, 120).
item_effect(kaos_2, armor, 20).
item_effect(busur_panah_dan_jangka_2, weapon, 100).
item_effect(jaket_2, armor, 40).
item_effect(pedang_2, weapon, 60).
item_effect(armor_2, armor, 100).

% Ultra Rare: (12%)
item_effect(pedang_3, weapon, 150).
item_effect(armor_3, armor, 250).
item_effect(busur_panah_dan_jangka_3, weapon, 250).
item_effect(jaket_3, armor, 100).
item_effect(magic_stick_3, weapon, 250).
item_effect(kaos_3, armor, 50).

% SR: (5%)
item_effect(pedang_4, weapon, 240).
item_effect(armor_4, armor, 400).
item_effect(busur_panah_dan_jangka_4, weapon, 400).
item_effect(jaket_4, armor, 160).
item_effect(magic_stick_4, weapon, 480).
item_effect(kaos_4, armor, 80).

% SSR: (3%)
item_effect(pedang_5, weapon, 450).
item_effect(armor_5, armor, 750).
item_effect(busur_panah_dan_jangka_5, weapon, 750).
item_effect(jaket_5, armor, 300).
item_effect(magic_stick_5, weapon, 900).
item_effect(kaos_5, armor, 150).

/* Penggunaan item */
use(_) :-
  state(S),
  S = not_started, !,
  write('Permainan belum dimulai.').

use(Item) :-
  countItemInInvetory(Item, ItemCount),
  ItemCount =:= 0, !,
  write('Kamu tidak memiliki item itu.').

use(Item) :-
  item_effect(Item, StatsAffacted, X),
  ((
    StatsAffacted = attack, !,
    attack(ATK),
    retractall(attack(_)),
    NewATK is ATK + X,
    write('Berhasil menggunakan '), write(Item), write(' untuk meningkatkan attack.\n'),
    asserta(attack(NewATK)),
    removeFromInventory(Item), !
  );
  (
    StatsAffacted = hp, !,
    hp(HP),
    maxHP(Max),
    ((
      NewHP is HP + X,
      NewHP =< Max
    );
    (
      NewHP is Max
    )),
    write('Berhasil berobat dengan '), write(Item), write(' .\n'),
    retractall(hp(_)),
    asserta(hp(NewHP)),
    removeFromInventory(Item), !
  );
  (
    StatsAffacted = defense, !,
    defense(DEF),
    retractall(defense(_)),
    NewDEF is DEF + X,
    write('Berhasil menggunakan '), write(Item), write(' untuk meningkatkan defense.\n'),
    asserta(defense(NewDEF)),
    removeFromInventory(Item)
  )), !.
drop(_) :-
  state(S),
  S = not_started, !,
  write('Permainan belum dimulai.'), nl.

drop(Gear) :-
	\+(item(Gear,_,_)), \+item(Gear,_),
	write('Barang itu tidak ada.\n'),  nl, !.
drop(Gear) :-
	countItemInInvetory(Gear, GearCount),
	GearCount =:= 0, !,
	write('Kamu tidak memiliki barang itu.\n'), nl,  !.
	
drop(X) :-
  removeFromInventory(X),
  write('Kamu telah membuang '), write(X), nl, !.

drop(_,_) :-
  state(S),
  S = not_started, !,
  write('Permainan belum dimulai.'), nl.
  
drop(Gear,_) :-
	\+(item(Gear,_,_)), \+item(Gear,_),
	write('Barang itu tidak ada.\n'),  nl, !.
	
drop(Gear,_) :-
	countItemInInvetory(Gear, GearCount),
	GearCount =:= 0, !,
	write('Kamu tidak memiliki barang itu.\n'),  nl, !.

drop(Gear,Count) :-
	countItemInInvetory(Gear, GearCount),
	GearCount < Count, !,
	write('Kamu tidak memiliki '),write(Count), write(' barang itu.\n'), nl,  !.

drop(X, 1) :-
    drop(X), !.

drop(X, Cnt) :-
  forall(between(1, Cnt, _), (
    removeFromInventory(X)
  )),
  write('Kamu telah drop '),write(Cnt), write(' '), write(X), write('.'), nl, !.

drop(X, Cnt, sell) :-
  forall(between(1, Cnt, _), (
    removeFromInventory(X)
  )), !.
