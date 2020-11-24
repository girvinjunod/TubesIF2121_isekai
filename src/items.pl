/* list item yang valid */
/* format: (nama, tipe) */
item(potion, consumable).
item(xAtk, consumable).
item(xDef, consumable).

/* list efek item */
/* format: (nama, stats_affacted, value change) */
/* Possible stats:
 * hp
 * attack
 * defense
 * level?
 * experience?
*/
item_effect(potion, hp, 10).
item_effect(xAtk, attack, 10).
item_effect(xDef, defense, 10).

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
