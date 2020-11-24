/* equip item*/
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
    retractall(weaponequipped(_)),
    asserta(weaponequipped(Gear)),!.
equip(Gear) :-
    item(Gear,Slot,Job),
    playerClass(X),
    Job = X,
    Slot = armor,
    retractall(armorequipped(_)),
    asserta(armorequipped(Gear)),!.
/*unequip item*/
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
  write(Gear), write('telah di-unequip.'), !.