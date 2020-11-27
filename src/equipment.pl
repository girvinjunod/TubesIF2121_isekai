equip(_) :-
  state(S),
  S = not_started, !,
  write('Permainan belum dimulai.\n').
equip(telanjang) :-
	weaponequipped(telanjang), !,
	armorequipped(telanjang), !,
	write('Kamu sudah telanjang\n').
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
	addToInventory(X), addToInventory(Y),
	asserta(defense(NewDEF)),
	asserta(weaponequipped(telanjang)),
	asserta(armorequipped(telanjang)),
	write('Anda telah menelanjangkan diri.\n'), !.
equip(Gear) :-
	weaponequipped(X),
	X = Gear,
	write('Kamu sedang memakai weapon itu.\n'), !.
equip(Gear) :-
	armorequipped(X),
	X = Gear,
	write('Kamu sedang memakai armor itu.\n'), !.
equip(Gear) :-
	\+item(Gear,_,_),
	write('Equipment itu tidak ada.\n'),!.
equip(Gear) :-
	countItemInInvetory(Gear, GearCount),
	GearCount =:= 0, !,
	write('Kamu tidak memiliki equipment itu.\n'), !.
equip(Gear) :-
	item(Gear,_,Job),
	playerClass(X),
	Job \= X,
	write('Equipment tidak cocok dengan job Anda.\n'),!.
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
	write(Gear),write(' telah di-equip.\n'),!.
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
	write(Gear),write(' telah di-equip.\n'),!.

unequip(_) :-
  state(S),
  S = not_started, !,
  write('Permainan belum dimulai.\n').
unequip(telanjang) :-
	(weaponequipped(telanjang)
	;armorequipped(telanjang)),
	write('Sudah telanjang tidak bisa unequip apa-apa lagi :v\n'), !.
unequip(Gear) :-
	\+(item(Gear,_,_)),
	write('Equipment itu tidak ada.\n'), !.
unequip(Gear) :-
	item(Gear,Slot,_),
	Slot = weapon,
	weaponequipped(X),
	X \= Gear, !,
	write('Kamu tidak sedang memakai equipment itu.\n').
unequip(Gear) :-
	item(Gear,Slot,_),
	Slot = weapon,
	weaponequipped(X),
	X = Gear,
	retract(weaponequipped(X)),
	item_effect(X,_,Stats),
	attack(ATK),
	retractall(attack(_)),
	NewATK is ATK - Stats,
	asserta(attack(NewATK)),
	asserta(weaponequipped(telanjang)),
	addToInventory(Gear),
	write(Gear), write(' telah di-unequip.\n'), !.
unequip(Gear) :-
	item(Gear,Slot,_),
	Slot = armor,
	armorequipped(X),
	X \= Gear, !,
	write('Kamu tidak sedang memakai equipment itu.\n').
unequip(Gear) :-
	item(Gear,Slot,_),
	Slot = armor,
	armorequipped(X),
	X = Gear,
	retract(armorequipped(X)),
	item_effect(X,_,Stats),
	defense(DEF),
	retractall(defense(_)),
	NewDEF is DEF - Stats,
	asserta(defense(NewDEF)),
	asserta(armorequipped(telanjang)),
	addToInventory(Gear),
	write(Gear), write(' telah di-unequip.\n'), !.
