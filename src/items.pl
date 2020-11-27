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
hargaItem(wooden_sword, 5).
hargaItem(iron_sword, 30).
hargaItem(steel_sword, 75).
hargaItem(dragon_sword, 150).
hargaItem(masamune, 250).
hargaItem(ultima_blade, 400).
hargaItem(wooden_armor, 5).
hargaItem(iron_armor, 30).
hargaItem(steel_armor, 75).
hargaItem(dragon_armor, 150).
hargaItem(diamond_armor, 250).
hargaItem(nanomachines, 400).
hargaItem(busur_panah_dan_jangka, 5).
hargaItem(crossbow, 30).
hargaItem(longbow, 75).
hargaItem(portable_ballista, 150).
hargaItem(sniper_rifle, 250).
hargaItem(railgun, 400).
hargaItem(leather_cloak, 5).
hargaItem(wolfhide_cloak, 30).
hargaItem(ironhide_cloak, 75).
hargaItem(shadow_cloak, 150).
hargaItem(dragonscale_cloak, 250).
hargaItem(batman_cloak, 400).
hargaItem(magic_stick, 5).
hargaItem(magic_wand, 30).
hargaItem(magic_staff, 75).
hargaItem(grand_magic_staff, 150).
hargaItem(celestial_staff, 250).
hargaItem(paddlepop, 400).
hargaItem(kaos, 5).
hargaItem(magic_robe, 30).
hargaItem(grand_magic_robe, 75).
hargaItem(celestial_robe, 150).
hargaItem(lab_coat, 250).
hargaItem(bathrobe, 400).

/* list item equip
format: (nama, tipe, role) */

item(telanjang, weapon, swordsman).
item(telanjang, weapon, archer).
item(telanjang, weapon, sorcerer).
item(telanjang, armor, swordsman).
item(telanjang, armor, archer).
item(telanjang, armor, sorcerer).

item(wooden_sword, weapon, swordsman).
item(wooden_armor, armor, swordsman).
item(iron_sword, weapon, swordsman).
item(iron_armor, armor, swordsman).
item(steel_sword, weapon, swordsman).
item(steel_armor, armor, swordsman).
item(dragon_sword, weapon, swordsman).
item(dragon_armor, armor, swordsman).
item(masamune, weapon, swordsman).
item(diamond_armor, armor, swordsman).
item(ultima_blade, weapon, swordsman).
item(nanomachines, armor, swordsman).

item(busur_panah_dan_jangka, weapon, archer).
item(leather_cloak, armor, archer).
item(crossbow, weapon, archer).
item(wolfhide_cloak, armor, archer).
item(longbow, weapon, archer).
item(ironhide_cloak, armor, archer).
item(portable_ballista, weapon, archer).
item(shadow_cloak, armor, archer).
item(sniper_rifle, weapon, archer).
item(dragonscale_cloak, armor, archer).
item(railgun, weapon, archer).
item(batman_cloak, armor, archer).

item(magic_stick, weapon, sorcerer).
item(kaos, armor, sorcerer).
item(magic_wand, weapon, sorcerer).
item(magic_robe, armor, sorcerer).
item(magic_staff, weapon, sorcerer).
item(grand_magic_robe, armor, sorcerer).
item(grand_magic_staff, weapon, sorcerer).
item(celestial_robe, armor, sorcerer).
item(celestial_staff, weapon, sorcerer).
item(lab_coat, armor, sorcerer).
item(paddlepop, weapon, sorcerer).
item(bathrobe, armor, sorcerer).

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

item_effect(magic_stick, weapon, 30).
item_effect(kaos, armor, 5).
item_effect(busur_panah_dan_jangka, weapon, 25).
item_effect(leather_cloak, armor, 10).
item_effect(wooden_sword, weapon, 15).
item_effect(wooden_armor, armor, 25).

% Common: (50%)
item_effect(magic_wand, weapon, 60).
item_effect(magic_robe, armor, 10).
item_effect(crossbow, weapon, 50).
item_effect(wolfhide_cloak, armor, 20).
item_effect(iron_sword, weapon, 30).
item_effect(iron_armor, armor, 50).

% Rare: (30%)
item_effect(magic_staff, weapon, 120).
item_effect(grand_magic_robe, armor, 20).
item_effect(longbow, weapon, 100).
item_effect(ironhide_cloak, armor, 40).
item_effect(steel_sword, weapon, 60).
item_effect(steel_armor, armor, 100).

% Ultra Rare: (12%)
item_effect(dragon_sword, weapon, 150).
item_effect(dragon_armor, armor, 250).
item_effect(portable_ballista, weapon, 250).
item_effect(shadow_cloak, armor, 100).
item_effect(grand_magic_staff, weapon, 250).
item_effect(celestial_robe, armor, 50).

% SR: (5%)
item_effect(masamune, weapon, 240).
item_effect(diamond_armor, armor, 400).
item_effect(sniper_rifle, weapon, 400).
item_effect(dragonscale_cloak, armor, 160).
item_effect(celestial_staff, weapon, 480).
item_effect(lab_coat, armor, 80).

% SSR: (3%)
item_effect(ultima_blade, weapon, 450).
item_effect(nanomachines, armor, 750).
item_effect(railgun, weapon, 750).
item_effect(batman_cloak, armor, 300).
item_effect(paddlepop, weapon, 900).
item_effect(bathrobe, armor, 150).

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
