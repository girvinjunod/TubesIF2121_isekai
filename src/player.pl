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
:- dynamic(gold/1).

class(swordsman).
class(archer).
class(sorcerer).

pilihKelas(_) :- playerClass(_), !.
pilihKelas(Kelas) :- setStat(Kelas), firstLevel.

firstLevel :-
  maxHP(HP),
  retractall(level(_)),
  retractall(levelUpCap(_)),
  retractall(experience(_)),
  retractall(hp(_)),
  retractall(gold(_)),
  asserta(level(1)),
  asserta(levelUpCap(1000)),
  asserta(experience(0)),
  asserta(hp(HP)),
  asserta(gold(0)).

setStat(swordsman) :-
  retractall(playerClass(_)),
  retractall(attack(_)),
  retractall(defense(_)),
  retractall(maxHP(_)),
  asserta(playerClass(swordsman)),
  asserta(attack(10)),
  asserta(defense(10)),
  asserta(maxHP(10)),!.

setStat(archer) :-
  retractall(playerClass(_)),
  retractall(attack(_)),
  retractall(defense(_)),
  retractall(maxHP(_)),
  asserta(playerClass(archer)),
  asserta(attack(12)),
  asserta(defense(8)),
  asserta(maxHP(10)),!.

setStat(sorcerer) :-
  retractall(playerClass(_)),
  retractall(attack(_)),
  retractall(defense(_)),
  retractall(maxHP(_)),
  asserta(playerClass(sorcerer)),
  asserta(attack(15)),
  asserta(defense(5)),
  asserta(maxHP(8)),!.

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

earnGold(X) :-
  gold(CurrGold),
  retractall(gold(_)),
  NewGold is CurrGold + X,
  asserta(gold(NewGold)).

statsUp :- % Untuk sekarang, setiap naik level dpt +10 di semua stats
  playerClass(archer), !,
  attack(CurATK),
  defense(CurDEF),
  maxHP(CurHP),
  retractall(attack(_)), retractall(defense(_)),
  retractall(maxHP(_)), retractall(hp(_)),
  NewATK is CurATK + 7,
  NewDef is CurDef + 3,
  NewHP is CurHP + 10,
  asserta(attack(NewATK)), asserta(defense(NewDef)),
  asserta(maxHP(NewHP)), asserta(hp(NewHP)).

statsUp :-
  playerClass(swordsman), !,
  attack(CurATK),
  defense(CurDef),
  maxHP(CurHP),
  retractall(attack(_)), retractall(defense(_)),
  retractall(maxHP(_)), retractall(hp(_)),
  NewATK is CurATK + 4,
  NewDef is CurDef + 4,
  NewHP is CurHP + 12,
  asserta(attack(NewATK)), asserta(defense(NewDef)),
  asserta(maxHP(NewHP)), asserta(hp(NewHP)).

statsUp :-
  playerClass(sorcerer), !,
  attack(CurATK),
  defense(CurDef),
  maxHP(CurHP),
  retractall(attack(_)), retractall(defense(_)),
  retractall(maxHP(_)), retractall(hp(_)),
  NewATK is CurATK + 8,
  NewDef is CurDef + 3,
  NewHP is CurHP + 9,
  asserta(attack(NewATK)), asserta(defense(NewDef)),
  asserta(maxHP(NewHP)), asserta(hp(NewHP)).

levelUp(Lebih) :-
  level(CurLVL),

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
