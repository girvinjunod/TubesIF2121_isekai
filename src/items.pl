/* list item yang valid
 * Kalo item diubah, tambahin di store.pl
format: (nama, tipe)*/
item(potion, consumable).
item(steroids, consumable).
item(skincare, consumable).
item(kupon_gacha_equipment, consumable).
item(kupon_gacha_item, consumable).

hargaItem(potion, 50).
hargaItem(kupon_gacha_item, 70).
hargaItem(kupon_gacha_equipment, 90).

/* list item equip
format: (nama, tipe, role) */

item(telanjang, weapon, swordsman).
item(telanjang, weapon, archer).
item(telanjang, weapon, sorcerer).
item(telanjang, armor, swordsman).
item(telanjang, armor, archer).
item(telanjang, armor, sorcerer).

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

item_effect(potion, hp, 10).
item_effect(steroids, weapon, 10).
item_effect(skincare, defense, 10).
item_effect(kupon_gacha_equipment, -, -).
item_effect(kupon_gacha_item, -, -).

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
item_effect(pedang_3, weapon, 90).
item_effect(armor_3, armor, 150).
item_effect(busur_panah_dan_jangka_3, weapon, 150).
item_effect(jaket_3, armor, 60).
item_effect(magic_stick_3, weapon, 180).
item_effect(kaos_3, armor, 30).

% SR: (5%)
item_effect(pedang_4, weapon, 120).
item_effect(armor_4, armor, 200).
item_effect(busur_panah_dan_jangka_4, weapon, 200).
item_effect(jaket_4, armor, 80).
item_effect(magic_stick_4, weapon, 240).
item_effect(kaos_4, armor, 40).

% SSR: (3%)
item_effect(pedang_5, weapon, 150).
item_effect(armor_5, armor, 250).
item_effect(busur_panah_dan_jangka_5, weapon, 250).
item_effect(jaket_5, armor, 100).
item_effect(magic_stick_5, weapon, 300).
item_effect(kaos_5, armor, 50).

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
    asserta(attack(NewATK)),
    removeFromInventory(Item)
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
    retractall(hp(_)),
    asserta(hp(NewHP)),
    removeFromInventory(Item)
  );
  (
    StatsAffacted = defense, !,
    defense(DEF),
    retractall(defense(_)),
    NewDEF is DEF + X,
    asserta(defense(NewDEF)),
    removeFromInventory(Item)
  )).

drop(X) :-
  removeFromInventory(X).

drop(X, 1) :-
  removeFromInventory(X).

drop(X, Cnt) :-
  removeFromInventory(X),
  NewCnt is Cnt-1,
  drop(X, NewCnt).
