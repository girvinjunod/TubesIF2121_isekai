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

/*swordsman
starting:
pedang 1 : +30 atck
armor 1: +50 def

Equipment dri gacha store:
pedang 2: +60 atck
armor 2: +100 def
pedang 3: + 90 atck
armor 3: + 150 def
pedang 4: + 120 atck
armor 4: + 200 def
pedang 5: + 150 atck
armor 5: + 250 def


archer
starting:
busur, panah, dan jangka 1 : 50 atck
jaket 1 : 20 def

Equipement dri gacha store:
busur, panah, dan jangka 2 : 100 atck
jaket 2 : 40 def
busur, panah, dan jangka 3 : 150
jaket 3 : 60 def
busur, panah, dan jangka 4 : 200
jaket 4 : 80 def
busur, panah, dan jangka 5 : 250 atck
jaket 5 : 100 def

sorcerer
starting:
magic stick 1: 60 atck
kaos 1 : 10 def

Equipment dri gacha store:
magic stick 2 : 120 atck
kaos 2 : 20 def
magic stick 3 : 180 atck
kaos 3 : 30 def
magic stick 4 : 240 atck
kaos 4 : 40 def
magic stick 5 : 300 atck
kaos 5 : 50 def



drop chancenya (dri steal sama gacha)
rarity 1 : 25%
rarity 2 : 50%
rarity 3 : 25%
rarity 4 : 15%
rarity 5 : 5%*/