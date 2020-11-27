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

baseExp(100).

reset :-
  retractall(playerClass(_)),
  retractall(attack(_)),
  retractall(defense(_)),
  retractall(maxHP(_)),
  retractall(level(_)),
  retractall(levelUpCap(_)),
  retractall(experience(_)),
  retractall(hp(_)),
  retractall(gold(_)),
  retractall(weaponequipped(_)),
  retractall(armorequipped(_)),
  retractall(name(_)),
  retractall(active_quest(_,_,_,_,_,_)).

pilihKelas(_) :- playerClass(_), !.
pilihKelas(Kelas) :- setStat(Kelas), firstLevel.

firstLevel :-
  maxHP(HP),
  baseExp(BExp),
  asserta(level(1)),
  asserta(levelUpCap(BExp)),
  asserta(experience(0)),
  asserta(hp(HP)),
  asserta(gold(0)),
  asserta(weaponequipped(telanjang)),
  asserta(armorequipped(telanjang)).

setStat(swordsman) :-
  asserta(playerClass(swordsman)),
  asserta(attack(75)),
  asserta(defense(150)),
  asserta(maxHP(800)),!.

setStat(archer) :-
  asserta(playerClass(archer)),
  asserta(attack(150)),
  asserta(defense(50)),
  asserta(maxHP(500)),!.

setStat(sorcerer) :-
  asserta(playerClass(sorcerer)),
  asserta(attack(200)),
  asserta(defense(50)),
  asserta(maxHP(400)),!.

setName(X) :-
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
  NewATK is CurATK + 15,
  NewDef is CurDEF + 10,
  NewHP is CurHP + 30,
  asserta(attack(NewATK)), asserta(defense(NewDef)),
  asserta(maxHP(NewHP)), asserta(hp(NewHP)).

statsUp :-
  playerClass(swordsman), !,
  attack(CurATK),
  defense(CurDEF),
  maxHP(CurHP),
  retractall(attack(_)), retractall(defense(_)),
  retractall(maxHP(_)), retractall(hp(_)),
  NewATK is CurATK + 10,
  NewDef is CurDEF + 20,
  NewHP is CurHP + 50,
  asserta(attack(NewATK)), asserta(defense(NewDef)),
  asserta(maxHP(NewHP)), asserta(hp(NewHP)).

statsUp :-
  playerClass(sorcerer), !,
  attack(CurATK),
  defense(CurDEF),
  maxHP(CurHP),
  retractall(attack(_)), retractall(defense(_)),
  retractall(maxHP(_)), retractall(hp(_)),
  NewATK is CurATK + 30,
  NewDef is CurDEF + 5,
  NewHP is CurHP + 20,
  asserta(attack(NewATK)), asserta(defense(NewDef)),
  asserta(maxHP(NewHP)), asserta(hp(NewHP)).

levelUp(Lebih) :-
  level(CurLVL),
  baseExp(BExp),

  retractall(experience(_)),
  retractall(level(_)),
  retractall(levelUpCap(_)),

  NewLVL is CurLVL + 1,
  NewLUC is BExp*((CurLVL // 10)+1),

  asserta(level(NewLVL)),
  asserta(levelUpCap(NewLUC)),
  statsUp,nl,
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
  baseExp(BExp),

  retractall(experience(_)),
  retractall(level(_)),
  retractall(levelUpCap(_)),

  NewLVL is CurLVL + 1,
  NewLUC is BExp*((CurLVL // 10)+1),

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
  write('Kamu tidak bisa menggunakan teleport di luar eksplorasi.\n').

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
      (Tujuan = store; Tujuan = 1), !,
      store_coordinate(X, Y),
      retractall(player_cell(_)),
      retractall(player_coordinate(_, _)),
      asserta(player_cell(store_cell)),
      asserta(player_coordinate(X, Y)),
      write('Kamu berhasil teleport ke store\n')
    );
    (
      (Tujuan = quest; Tujuan = 2), !,
      quest_coordinate(X, Y),
      retractall(player_cell(_)),
      retractall(player_coordinate(_, _)),
      asserta(player_cell(quest_cell)),
      asserta(player_coordinate(X, Y)),
      write('Kamu berhasil teleport ke quest\n')
    );
    (
      (Tujuan = boss; Tujuan = 3), !,
      dungeon_boss_coordinate(X, Y),
      retractall(player_cell(_)),
      retractall(player_coordinate(_, _)),
      asserta(player_cell(dungeon_boss_cell)),
      asserta(player_coordinate(X, Y)),
      write('Kamu berhasil teleport ke boss\n'),
	  interact_with_dungeon_boss_cell
    );
    (
      write('Tidak ada portal di tempat pilihanmu, teleport dibatalkan.\n')
    )
  ).
die :-
	current_monster('Shopkeeper'),
	retractall(maxHP(_)),
	retractall(level(_)),
	retractall(levelUpCap(_)),
	retractall(experience(_)),
	retractall(hp(_)),
	retractall(gold(_)),
	retractall(weaponequipped(_)),
	retractall(armorequipped(_)),
	setState(not_started),nl, sleep(1),
	write('Kamu terjatuh di tengah pertempuran, seiring kamu ditelan kegelapan, kamu melihat sang shopkeeper tersenyum...'), nl,nl, sleep(1),
	write('Kamu mencoba untuk bergerak namun tidak bisa, karena kamu sudah tewas...'), nl,nl,nl, sleep(1),
	write('Ingat anak-anak, mencuri itu tidak baik.\n'),nl, sleep(1),
	nl,nl,
	write('------------------------------------------------------JUSTICE IS SERVED------------------------------------------------------\n'),
	reset, !.

die :-
  retractall(maxHP(_)),
  retractall(level(_)),
  retractall(levelUpCap(_)),
  retractall(experience(_)),
  retractall(hp(_)),
  retractall(gold(_)),
  retractall(weaponequipped(_)),
  retractall(armorequipped(_)),
  setState(not_started), nl, sleep(1),
  write('Kamu terjatuh di tengah pertempuran, seiring kamu ditelan kegelapan, kamu mendengar teriakan minta tolong...'), nl,nl, sleep(1),
  write('Sayangnya, kamu tidak dapat bergerak, karena kamu sudah tewas...'), nl,
  nl,nl, sleep(1),
  write('------------------------------------------------------GAME OVER------------------------------------------------------\n'),
  reset, !.
