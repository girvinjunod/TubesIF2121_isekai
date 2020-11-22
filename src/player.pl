:- include('inventory.pl').
:- dynamic(hp/1).
:- dynamic(maxHP/1).
:- dynamic(level/1).
:- dynamic(experience/1).
:- dynamic(playerClass/1).
:- dynamic(attack/1).
:- dynamic(defense/1).
:- dynamic(weapon/1).
:- dynamic(armor/1).

hp(100).
attack(100).

class(swordsman).
class(archer).
class(sorcerer).

pilihKelas(_) :- playerClass(_), !.
pilihKelas(Kelas) :- asserta(playerClass(Kelas)), setStat.

setStat :- playerClass(swordsman),
  asserta(hp(10)),
  asserta(level(1)),
  asserta(experience(0)),
  asserta(attack(10)),
  asserta(defense(10)),
  asserta(maxHP(10)),!.

setStat :- playerClass(archer),
  asserta(level(1)),
  asserta(experience(0)),
  asserta(attack(13)),
  asserta(defense(9)),
  asserta(maxHP(10)),
  asserta(hp(10)), !.

setStat :- playerClass(sorcerer),
  asserta(level(1)),
  asserta(experience(0)),
  asserta(attack(20)),
  asserta(defense(5)),
  asserta(maxHP(8)),
  asserta(hp(8)), !.

consumeItem(Nama, hp, X) :-
  hp(HP),
  retractall(hp(_)),
  NewHP is HP + X,
  asserta(hp(NewHP)),
  removeFromInventory(Nama).

consumeItem(Nama, attack, X) :-
  attack(ATK),
  retractall(attack(_)),
  NewATK is ATK + X,
  asserta(attack(NewATK)),
  removeFromInventory(Nama).

consumeItem(Nama, defense, X) :-
  defense(DEF),
  retractall(defense(_)),
  NewDEF is DEF + X,
  asserta(defense(NewDEF)),
  removeFromInventory(Nama).
