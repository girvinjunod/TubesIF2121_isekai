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
