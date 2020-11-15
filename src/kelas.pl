:- dynamic(playerClass/1).
:- dynamic(attack/1).
:- dynamic(defense/1).
:- dynamic(weapon/1).
:- dynamic(armor/1).

class(swordsman).
class(archer).
class(sorcerer).

pilihKelas(_) :- playerClass(_), !.
pilihKelas(Kelas) :- asserta(playerClass(Kelas)), setStat.

setStat :- playerClass(swordsman),
  asserta(attack(10)),
  asserta(defense(10)),
  asserta(maxHP(10)),
  asserta(hp(10)), !.

setStat :- playerClass(archer),
  asserta(attack(13)),
  asserta(defense(9)),
  asserta(maxHP(10)),
  asserta(hp(10)), !.

setStat :- playerClass(sorcerer),
  asserta(attack(20)),
  asserta(defense(5)),
  asserta(maxHP(8)),
  asserta(hp(8)), !.
