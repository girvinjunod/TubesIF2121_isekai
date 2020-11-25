:- dynamic(hp/1).
:- dynamic(maxHP/1).
:- dynamic(level/1).
:- dynamic(experience/1).
:- dynamic(playerClass/1).
:- dynamic(attack/1).
:- dynamic(defense/1).
:- dynamic(weaponequipped/1).
:- dynamic(armorequipped/1).
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
  retractall(weaponequipped(_)),
  retractall(armorequipped(_)),
  asserta(level(1)),
  asserta(levelUpCap(1000)),
  asserta(experience(0)),
  asserta(hp(HP)),
  asserta(gold(0)),
  asserta(weaponequipped(telanjang)),
  asserta(armorequipped(telanjang)).

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

statsUp :-
  playerClass(archer), !,
  attack(CurATK),
  defense(CurDEF),
  maxHP(CurHP),
  retractall(attack(_)), retractall(defense(_)),
  retractall(maxHP(_)), retractall(hp(_)),
  NewATK is CurATK + 7,
  NewDef is CurDEF + 3,
  NewHP is CurHP + 10,
  asserta(attack(NewATK)), asserta(defense(NewDef)),
  asserta(maxHP(NewHP)), asserta(hp(NewHP)).

statsUp :-
  playerClass(swordsman), !,
  attack(CurATK),
  defense(CurDEF),
  maxHP(CurHP),
  retractall(attack(_)), retractall(defense(_)),
  retractall(maxHP(_)), retractall(hp(_)),
  NewATK is CurATK + 4,
  NewDef is CurDEF + 4,
  NewHP is CurHP + 12,
  asserta(attack(NewATK)), asserta(defense(NewDef)),
  asserta(maxHP(NewHP)), asserta(hp(NewHP)).

statsUp :-
  playerClass(sorcerer), !,
  attack(CurATK),
  defense(CurDEF),
  maxHP(CurHP),
  retractall(attack(_)), retractall(defense(_)),
  retractall(maxHP(_)), retractall(hp(_)),
  NewATK is CurATK + 8,
  NewDef is CurDEF + 3,
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
      R < 5, !,
      write('Kamu diberkati oleh dewa-dewi Dosen, kamu mendapatkan level up sekali lagi.'), nl,
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

teleport :-
  state(not_started), !,
  write('Permainan belum dimulai, kamu tidak bisa bergerak ke mana-mana.').

teleport :-
  state(A),
  A \= free, !,
  write('Kamu belum bisa berpindah tempat').

teleport :-
  state(free),
  write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
  write('%                              ~Teleport Menu~                                 %\n'),
  write('% 1. store                                                                     %\n'),
  write('% 2. quest                                                                     %\n'),
  write('% 3. boss                                                                      %\n'),
  write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
  nl, nl,
  write('Kamu mau teleport ke mana? '),
  read(Tujuan),
  (
    (
      Tujuan = store, !,
      store_coordinate(X, Y),
      retractall(player_cell(_)),
      retractall(player_coordinate(_, _)),
      asserta(player_cell(store_cell)),
      asserta(player_coordinate(X, Y))
    );
    (
      Tujuan = quest, !,
      quest_coordinate(X, Y),
      retractall(player_cell(_)),
      retractall(player_coordinate(_, _)),
      asserta(player_cell(quest_cell)),
      asserta(player_coordinate(X, Y))
    );
    (
      Tujuan = boss, !,
      dungeon_boss_coordinate(X, Y),
      retractall(player_cell(_)),
      retractall(player_coordinate(_, _)),
      asserta(player_cell(dungeon_boss_cell)),
      asserta(player_coordinate(X, Y))
    );
    (
      write('Tidak ada portal di tempat pilihanmu, teleport dibatalkan.')
    )
  ).
die :-
  retractall(maxHP(_)),
  retractall(level(_)),
  retractall(levelUpCap(_)),
  retractall(experience(_)),
  retractall(hp(_)),
  retractall(gold(_)),
  retractall(weaponequipped(_)),
  retractall(armorequipped(_)),
  write('You died, and as the darkness devours you, you heard the cry for help...'), nl,
  write('Unfortunately, you are unable to move, as your mortal body is torn apart.'), nl.
