equip(telanjang) :-
    weaponequipped(W), armorequipped(A),
    W = telanjang, !, A = telanjang, !,
    write('Kamu sudah telanjang').

equip(telanjang) :-
	retract(weaponequipped(X)),
	retract(armorequipped(Y)),
	item_effect(X,_, ATKDulu),
	item_effect(Y,_, DEFDulu),
	attack(ATK),
	retractall(attack(_)),
	NewATK is ATK - ATKDulu,
	asserta(attack(NewATK)),
	defense(DEF),
	retractall(defense(_)),
	NewDEF is DEF - DEFDulu,
	asserta(defense(NewDEF)),
	asserta(weaponequipped(telanjang)),
	asserta(armorequipped(telanjang)),
	write('Anda telah menelanjangkan diri.'), !.
equip(Gear) :-
	\+item(Gear,_,_),
	write('Equipment itu tidak ada.'),!.
equip(Gear) :-
  countItemInInvetory(Gear, GearCount),
  GearCount =:= 0, !,
  write('Kamu tidak memiliki equipment itu.'), !.
equip(Gear) :-
	item(Gear,_,Job),
	playerClass(X),
	Job \= X,
	write('Equipment tidak cocok dengan job Anda.'),!.
equip(Gear) :-
	item(Gear,Slot,Job),
	playerClass(X),
	Job = X,
	Slot = weapon,
	retract(weaponequipped(Y)),
	asserta(weaponequipped(Gear)),
	item_effect(Gear,Tipe,Stats),
	item_effect(Y,_, Dulu),
	Tipe = weapon,
	attack(ATK),
	retractall(attack(_)),
	NewATK is ATK - Dulu + Stats,
	asserta(attack(NewATK)),
    removeFromInventory(Gear),
	write(Gear),write(' telah di-equip.'),!.
equip(Gear) :-
	item(Gear,Slot,Job),
	playerClass(X),
	Job = X,
	Slot = armor,
	retract(armorequipped(Y)),
	asserta(armorequipped(Gear)),
	item_effect(Gear,Tipe,Stats),
	item_effect(Y,_, Dulu),
	Tipe = armor,
	defense(DEF),
	retractall(defense(_)),
	NewDEF is DEF - Dulu + Stats,
	asserta(defense(NewDEF)),
    removeFromInventory(Gear),
	write(Gear),write(' telah di-equip.'),!.

unequip(telanjang) :- write('Sudah telanjang tidak bisa unequip apa-apa lagi :v'), !.
unequip(Gear) :-
	\+(item(Gear,_,_)),
	write('Equipment itu tidak ada.'), !.
unequip(Gear) :-
  item(Gear,Slot,_),
  Slot = weapon,
  retract(weaponequipped(X)),
  X \= Gear,
  write('Kamu tidak sedang memakai equipment itu.'),
  asserta(weaponequipped(Gear)), !.
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
  asserta(weaponequipped(telanjang)),
  write(Gear), write('telah di-unequip.'), !.
unequip(Gear) :-
  item(Gear,Slot,_),
  Slot = armor,
  retract(armorequipped(X)),
  X \= Gear,
  write('Kamu tidak sedang memakai equipment itu.'),
  asserta(armorequipped(Gear)), !.
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
  asserta(armorequipped(telanjang)),
  write(Gear), write('telah di-unequip.'), !.
