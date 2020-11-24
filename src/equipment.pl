equip(Gear) :-
    \+item(Gear,_,_),
    write('Item itu tidak ada.'),!.
equip(Gear) :-
  countItemInInvetory(Gear, GearCount),
  GearCount =:= 0, !,
  write('Kamu tidak memiliki item itu.'), !.
equip(Gear) :-
    item(Gear,_,Job),
    playerClass(X),
    Job \= X,
    write('Equipment tidak cocok dengan job kamu.'),!.
equip(Gear) :-
    item(Gear,Slot,Job),
    playerClass(X),
    Job = X,
    Slot = weapon,
    retract(weaponequipped(Y)),
    asserta(weaponequipped(Gear)),
    item_effect(Gear,Tipe,Stats),
    item_effect(Y,_, Dulu),
    Tipe = attack,
    attack(ATK),
    retractall(attack(_)),
    NewATK is ATK - Dulu + Stats,
    asserta(attack(NewATK)),!.
equip(Gear) :-
    item(Gear,Slot,Job),
    playerClass(X),
    Job = X,
    Slot = armor,
    retract(armorequipped(Y)),
    asserta(armorequipped(Gear)),
    item_effect(Gear,Tipe,Stats),
    item_effect(Y,_, Dulu),
    Tipe = defense,
    defense(DEF),
    retractall(defense(_)),
    NewDEF is DEF - Dulu + Stats,
    asserta(defense(NewDEF)),!.


unequip(Gear) :-
    \+(item(Gear,_,_)),
    write('Item itu tidak ada.'), !.
unequip(Gear) :-
  item(Gear,Slot,_),
  Slot = weapon,
  retract(weaponequipped(X)),
  X \= Gear,
  write('Kamu tidak sedang memakai item itu.'),
  equip(Gear), !.
unequip(Gear) :-
  item(Gear,Slot,_),
  Slot = weapon,
  retract(weaponequipped(X)),
  X = Gear,
  item_effect(X,_,Stats),
  attack(ATK),
  retractall(attack(_)),
  NewATK is ATK - Stats,
  asserta(attack(NewATK)),
  equip(telanjang),
  write(Gear), write('telah di-unequip.'), !.
unequip(Gear) :-
  item(Gear,Slot,_),
  Slot = armor,
  retract(armorequipped(X)),
  X \= Gear,
  write('Kamu tidak sedang memakai item itu.'),
  equip(Gear), !.
unequip(Gear) :-
  item(Gear,Slot,_),
  Slot = armor,
  retract(armorequipped(X)),
  X = Gear,
  item_effect(X,_,Stats),
  defense(DEF),
  retractall(defense(_)),
  NewDEF is DEF - Stats,
  asserta(defense(NewDEF)),
  equip(telanjang),
  write(Gear), write('telah di-unequip.'), !.
