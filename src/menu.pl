mainMenu :-
  write('$$\\   $$\\          $$\\             $$$$$$\\                     $$\\                $$\\        $$$$$$\\ \n'),
  write('$$ | $$  |         $$ |            \\_$$  _|                    $$ |               \\__|      $$  __$$\\ \n'),
  write('$$ |$$  / $$$$$$\\  $$ |  $$\\         $$ |   $$$$$$$\\  $$$$$$\\  $$ |  $$\\ $$$$$$\\  $$\\       $$ /  \\__|$$\\  $$\\  $$\\ \n'),
  write('$$$$$  / $$  __$$\\ $$ | $$  |        $$ |  $$  _____|$$  __$$\\ $$ | $$  |\\____$$\\ $$ |      $$ |$$$$\\ $$ | $$ | $$ | \n'),
  write('$$  $$<  $$ /  $$ |$$$$$$  /         $$ |  \\$$$$$$\\  $$$$$$$$ |$$$$$$  / $$$$$$$ |$$ |      $$ |\\_$$ |$$ | $$ | $$ | \n'),
  write('$$ |\\$$\\ $$ |  $$ |$$  _$$<          $$ |   \\____$$\\ $$   ____|$$  _$$< $$  __$$ |$$ |      $$ |  $$ |$$ | $$ | $$ | \n'),
  write('$$ | \\$$\\\\$$$$$$  |$$ | \\$$\\       $$$$$$\\ $$$$$$$  |\\$$$$$$$\\ $$ | \\$$\\\\$$$$$$$ |$$ |      \\$$$$$$  |\\$$$$$\\$$$$  | \n'),
  write('\\__|  \\__|\\______/ \\__|  \\__|      \\______|\\_______/  \\_______|\\__|  \\__|\\_______|\\__|       \\______/  \\_____\\____/  \n'),
  nl,nl,nl,
  write('$$$$$$$\\                                $$\\             $$$$$$$$\\        $$\\                           $$\\  $$$$\\   \n'),
  write('$$  __$$\\                               $$ |            \\__$$  __|       $$ |                          $$ |$$  $$\\ \n'),
  write('$$ |  $$ | $$$$$$\\  $$$$$$$\\  $$\\   $$\\ $$$$$$$\\           $$ |$$\\   $$\\ $$$$$$$\\   $$$$$$\\   $$$$$$$\\ $$ |\\__/$$ | \n'),
  write('$$$$$$$  |$$  __$$\\ $$  __$$\\ $$ |  $$ |$$  __$$\\          $$ |$$ |  $$ |$$  __$$\\ $$  __$$\\ $$  _____|$$ |   $$  |  \n'),
  write('$$  ____/ $$$$$$$$ |$$ |  $$ |$$ |  $$ |$$ |  $$ |         $$ |$$ |  $$ |$$ |  $$ |$$$$$$$$ |\\$$$$$$\\  \\__|  $$  /  \n'),
  write('$$ |      $$   ____|$$ |  $$ |$$ |  $$ |$$ |  $$ |         $$ |$$ |  $$ |$$ |  $$ |$$   ____| \\____$$\\       \\__/ \n'),
  write('$$ |      \\$$$$$$$\\ $$ |  $$ |\\$$$$$$  |$$ |  $$ |         $$ |\\$$$$$$  |$$$$$$$  |\\$$$$$$$\\ $$$$$$$  |$$\\   $$\\ \n'),
  write('\\__|       \\_______|\\__|  \\__| \\______/ \\__|  \\__|         \\__| \\______/ \\_______/  \\_______|\\_______/ \\__|  \\__|  \n'),
  nl,nl,nl,
  write('Welcome to "Kok Isekai Gw Penuh Tubes" the game!!\n'),
  nl,
  write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
  write('%                          ~Kok Isekai Gw Penuh Tubes~                         %\n'),
  write('% 1. new game  : untuk memulai petualanganmu                                   %\n'),
  write('% 2. exit      : keluar dari gim                                               %\n'),
  write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%').

status :-
  active_quest(S,Go,W,Gh,QuestExp,QuestGold), !,
  name(NAME), hp(HP), maxHP(MaxHP), attack(ATK), defense(DEF), level(LVL), experience(EXP),
  levelUpCap(LUC), playerClass(PC), gold(Gold), armorequipped(ARMOR), weaponequipped(WEAP),
   write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
  format('                                   Status ~w                                \n', [NAME]),
  format('  HP          : ~2f/~w', [HP, MaxHP]), nl,
  format('  Attack      : ~w', [ATK]), nl,
  format('  Defense     : ~w', [DEF]), nl,
  format('  Weapon      : ~w', [WEAP]), nl,
  format('  Armor       : ~w', [ARMOR]), nl,
  format('  Level       : ~w', [LVL]), nl,
  format('  Experience  : ~w/~w', [EXP, LUC]), nl,
  format('  Job         : ~w', [PC]), nl,
  format('  Gold        : ~w', [Gold]), nl,
  format('  Active Quest: ~d Slime(s) ~d Goblin(s) ~d Wolf(s) ~d Ghost(s) ~d Exp(s) ~d Gold(s)\n',[S,Go,W,Gh,QuestExp,QuestGold]),
   write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%').
status :-
  name(NAME), hp(HP), maxHP(MaxHP), attack(ATK), defense(DEF), level(LVL), experience(EXP),
  levelUpCap(LUC), playerClass(PC), gold(Gold), armorequipped(ARMOR), weaponequipped(WEAP),
   write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
  format('                                   Status ~w                                \n', [NAME]),
  format('  HP          : ~2f/~w', [HP, MaxHP]), nl,
  format('  Attack      : ~w', [ATK]), nl,
  format('  Defense     : ~w', [DEF]), nl,
  format('  Weapon      : ~w', [WEAP]), nl,
  format('  Armor       : ~w', [ARMOR]), nl,
  format('  Level       : ~w', [LVL]), nl,
  format('  Experience  : ~w/~w', [EXP, LUC]), nl,
  format('  Job         : ~w', [PC]), nl,
  format('  Gold        : ~w', [Gold]), nl,
   write('  Active Quest: Kamu sedang tidak mengambil quest\n'),
   write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%').

stats :-
  status.

help :-
  state(free), !,
  write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
  write('%                                ~Perintah Permainan~                              %\n'),
  write('% 1.  map               : Menampilkan peta                                         %\n'),
  write('% 2.  status            : Menampilkan kondisimu terkini                            %\n'),
  write('% 3.  w                 : Gerak ke utara 1 langkah                                 %\n'),
  write('% 4.  s                 : Gerak ke selatan 1 langkah                               %\n'),
  write('% 5.  d                 : Gerak ke ke timur 1 langkah                              %\n'),
  write('% 6.  a                 : Gerak ke barat 1 langkah                                 %\n'),
  write('% 7.  teleport          : Teleport ke salah satu tempat \'special\' (Q, S, D)      %\n'),
  write('% 8.  help              : menampilkan segala bantuan                               %\n'),
  write('%                                                                                  %\n'),
  write('% 9.  use(nama)         : Menggunakan item dengan nama item `Nama`                 %\n'),
  write('% 10. inventory        : Menuliskan isi inventory                                  %\n'),
  write('% 10. store            : Membuka menu store (hanya bisa di store (S))              %\n'),
  write('% 11. sell             : Menjual item di inventory (hanya bisa di store (S))       %\n'),
  write('% 12. drop(Nama)       : Membuang item dengan nama Nama dari inventory             %\n'),
  write('% 13. drop(Nama, Q)    : Membuang sekaligus Q item dengan nama Nama dari inventory %\n'),
  write('% 14. equip(Nama)      : Meng-equip armor atau senjata dari inventory              %\n'),
  write('% 15. unequip(Nama)    : Melepas armor atau senjata dari badan                     %\n'),
  write('% 16. gachaEquipment   : Melakukan gacha equipment (harus memiliki kupon gacha)    %\n'),
  write('% 17. gachaItem        : Melakukan gacha item (harus memiliki kupon gacha)         %\n'),
  write('%                                                                                  %\n'),
  write('% 18. quest            : Membuka menu quest (hanya bisa di quest board (Q)         %\n'),
  write('%                                                                                  %\n'),
  write('% 16. exit             : keluar dari gim                                           %\n'),
  write('%                                                                                  %\n'),
  write('%                                   ~Legenda Map~                                  %\n'),
  write('% 1.  P                 : Player                                                   %\n'),
  write('% 2.  S                 : Store                                                    %\n'),
  write('% 3.  B                 : Boss                                                     %\n'),
  write('% 3.  Q                 : Quest Board                                              %\n'),
  write('% 4.  #                 : Pagar                                                    %\n'),
  write('% 4.  -                 : Jalan                                                    %\n'),
  write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%').

help :-
  ( state(battle); state(tutorial); state(boss) ), !,
  write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
  write('%                              ~Perintah Battle~                               %\n'),
  write('% 1. attack        : Serang monster                                            %\n'),
  write('% 2. special_attack: Serang monster dengan special attack                      %\n'),
  write('% 3. kabur         : Kabur dari battle                                         %\n'),
  write('% 4. use(nama)     : Menggunakan item dengan nama item `nama`                  %\n'),
  write('% 5. inventory     : Menuliskan isi inventory                                  %\n'),
  write('% 6. help          : Menampilkan segala bantuan                                %\n'),
  write('% 7. status        : Menampilkan status pemain                                 %\n'),
  write('% 8. exit          : Keluar dari gim                                           %\n'),
  write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%').

help :-
  state(not_started), !,
  write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
  write('%                                  ~Menu~                                      %\n'),
  write('% 1. start         : Mulai gim                                                 %\n'),
  write('% 2. exit          : Keluar dari gim                                           %\n'),
  write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%').

inventory :-
  state(not_started), !,
  write('Inventory tidak tersedia karena permainan belum dimulai.'), nl.

inventory :-
  inventory(I),
  I = [], !,
  write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
  write('%                                ~Inventory~                                   %\n'),
  write('%                                                                              %\n'),
  write('%                            Inventory-mu kosong                               %\n'),
  write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n').

inventory :-
  write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
  write('%                                ~Inventory~                                   %\n'),
  inventory(I),
  listInventory(1, I),
  write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n').

shop :-
  store.

enemy :-
  monster_hp(HP), monster_maxHP(MaxHP), monster_atk(ATK), monster_def(DEF), monster_lvl(LVL),
  current_monster(NAME),
   write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
  format('                                   Status ~w                                \n', [NAME]),
  format('  HP          : ~2f/~w', [HP, MaxHP]), nl,
  format('  Attack      : ~w', [ATK]), nl,
  format('  Defense     : ~w', [DEF]), nl,
  format('  Level       : ~w', [LVL]), nl,
   write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'), !.

battleStats :-
  (state(battle); state(tutorial)), !,
  monster_hp(M_HP), monster_maxHP(M_MaxHP),
  current_monster(M_NAME), monster_lvl(M_LVL), name(P_NAME), hp(P_HP),
  maxHP(P_MaxHP), level(P_LVL), weaponequipped(WEAP), armorequipped(ARMOR),
  weaponequipped(WEAP), special_cooldown(SPC_COOL),
   write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
   write('                                   Battle\n'),
  format('  ~w (Enemy)', [M_NAME]), nl,
  format('  HP          : ~2f/~w', [M_HP, M_MaxHP]), nl,
  format('  Level       : ~w', [M_LVL]), nl,
   write('---------------------------------------------------------------------------------\n'),
  format('  ~w (Player)\n', [P_NAME]),
  format('  HP          : ~2f/~w', [P_HP, P_MaxHP]), nl,
  format('  Weapon      : ~w', [WEAP]), nl,
  format('  Armor       : ~w', [ARMOR]), nl,
  format('  Level       : ~w', [P_LVL]), nl,
  (
    (
      SPC_COOL =:= 0,
      write('  Sp. attack  : bisa digunakan'), !
    );
    (
      format('  Sp. attack  : ~w turn tersisa sampai bisa digunakan.', [SPC_COOL])
    )
  ), nl,
   write('---------------------------------------------------------------------------------\n'),
   write('  Gunakan command `enemy` untuk stats lengkap musuh\n  dan `stats` untuk stats lengkap kamu\n'),
   write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),nl.

battleStats.
