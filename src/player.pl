:- dynamic(hp/1).
:- dynamic(maxHP/1).
:- dynamic(level/1).
:- dynamic(experience/1).
:- dynamic(playerClass/1).
:- dynamic(attack/1).
:- dynamic(defense/1).
:- dynamic(weapon/1).
:- dynamic(armor/1).
:- dynamic(name/1).
:- dynamic(levelUpCap/1).

class(swordsman).
class(archer).
class(sorcerer).

pilihKelas(_) :- playerClass(_), !.
pilihKelas(Kelas) :- asserta(playerClass(Kelas)), setStat(Kelas), firstLevel.

firstLevel :-
  maxHP(HP),
  retractall(level(_)),
  retractall(levelUpCap(_)),
  retractall(experience(_)),
  retractall(hp(_)),
  asserta(level(1)),
  asserta(levelUpCap(1000)),
  asserta(experience(0)),
  asserta(hp(HP)).

setStat(swordsman) :-
  retractall(attack(_)),
  retractall(defense(_)),
  retractall(maxHP(_)),
  asserta(attack(10)),
  asserta(defense(10)),
  asserta(maxHP(10)),!.

setStat(archer) :-
  retractall(attack(_)),
  retractall(defense(_)),
  retractall(maxHP(_)),
  asserta(attack(13)),
  asserta(defense(9)),
  asserta(maxHP(10)),!.

setStat(sorcerer) :-
  retractall(attack(_)),
  retractall(defense(_)),
  retractall(maxHP(_)),
  asserta(attack(20)),
  asserta(defense(5)),
  asserta(maxHP(8)),!.

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

setName(X) :-
  retractall(name(_)),
  asserta(name(X)).

earnExp(X) :-
  experience(XP), levelUpCap(LUC),
  NewXP is XP + X,
  NewXP >= LUC, !,
  Lebih is NewXP - LUC,
  levelUp(Lebih).

earnExp(X) :-
  experience(XP),
  NewXP is XP + X,
  retractall(experience(_)),
  asserta(experience(NewXP)).

statsUp :-
  write('Not implemented yet'), nl.

levelUp(Lebih) :-
  level(CurLVL),
  levelUpCap(CurLUC),

  retractall(experience(_)),
  retractall(level(_)),
  retractall(levelUpCap(_)),

  NewLVL is CurLVL + 1,
  NewLUC is 1000*((CurLVL // 10)+1),

  asserta(level(NewLVL)),
  asserta(levelUpCap(NewLUC)),
  statsUp,
  format('Selamat, kamu sekarang level ~w.', [NewLVL]), nl,
  (
    Lebih >= NewLUC, !,
    NewLebih is Lebih - NewLUC,
    levelUp(NewLebih)
  );
  (
    asserta(experience(Lebih)),
    (
      acak(0, 100, R),
      write(R), nl,
      R < 6, !,
      write('Kamu diberkati oleh dewa-dewa Shichi Fukujin, kamu mendapatkan level up sekali lagi.'), nl,
      levelUp(0, gacha)
    );
    (
      level(_), levelUpCap(_), experience(_)
    )
  ).

levelUp(Lebih, gacha) :-
  level(CurLVL),
  levelUpCap(CurLUC),

  retractall(experience(_)),
  retractall(level(_)),
  retractall(levelUpCap(_)),

  NewLVL is CurLVL + 1,
  NewLUC is 1000*((CurLVL // 10)+1),

  asserta(level(NewLVL)),
  asserta(levelUpCap(NewLUC)),
  statsUp,
  format('Selamat, kamu sekarang level ~w.', [NewLVL]), nl,
  (
    Lebih >= NewLUC, !,
    NewLebih is Lebih - NewLUC,
    levelUp(NewLebih)
  );
  (
    asserta(experience(Lebih))
  ).
