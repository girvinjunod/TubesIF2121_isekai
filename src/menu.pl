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
  write('% 2. load game : untuk melanjutkan petualanganmu                               %\n'),
  write('% 3. exit      : keluar dari gim                                               %\n'),
  write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%').

status :-
  hp(HP), maxHP(MaxHP), attack(ATK), defense(DEF), level(LVL), experience(EXP), levelUpCap(LUC), playerClass(PC),
   write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
   write('                                   ~Status Kamu~                                \n'),
  format('  HP: ~w/~w', [HP, MaxHP]), nl,
  format('  Attack: ~w', [ATK]), nl,
  format('  Defense: ~w', [DEF]), nl,
  format('  Level: ~w', [LVL]), nl,
  format('  Experience: ~w/~w', [EXP, LUC]), nl,
  format('  Class: ~w', [PC]), nl,
   write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%').

stats :-
  status.

help :-
  state(free), !,
  write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
  write('%                              ~Perintah Permainan~                            %\n'),
  write('% 1. map           : Menampilkan peta                                          %\n'),
  write('% 2. status        : Menampilkan kondisimu terkini                             %\n'),
  write('% 3. w             : Gerak ke utara 1 langkah                                  %\n'),
  write('% 4. s             : Gerak ke selatan 1 langkah                                %\n'),
  write('% 5. d             : Gerak ke ke timur 1 langkah                               %\n'),
  write('% 6. a             : Gerak ke barat 1 langkah                                  %\n'),
  write('% 7. help          : menampilkan segala bantuan                                %\n'),
  write('% 8. use(Nama)     : Menggunakan item dengan nama item `Nama`                  %\n'),
  write('% 9. inventory     : Menuliskan isi inventory                                  %\n'),
  write('% 10. save         : Menyimpan gim                                             %\n'),
  write('% 11. exit         : keluar dari gim                                           %\n'),
  write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%').

help  :-
  state(battle), !,
  write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
  write('%                              ~Perintah Battle~                               %\n'),
  write('% 1. attack        : Serang monster                                            %\n'),
  write('% 2. item          : Menuliskan item yang dimiliki                             %\n'),
  write('% 3. kabur         : Kabur dari battle                                         %\n'),
  write('% 4. use(Nama)     : Menggunakan item dengan nama item `Nama`                  %\n'),
  write('% 5. inventory     : Menuliskan isi inventory                                  %\n'),
  write('% 6. help          : Menampilkan segala bantuan                                %\n'),
  write('% 7. status        : Menampilkan status pemain                                 %\n'),
  write('% 8. exit          : Keluar dari gim                                           %\n'),
  write('% 9. save         : Menyimpan gim                                             %\n'),
  write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%').

help  :-
  state(not_started), !,
  write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
  write('%                                  ~Menu~                                      %\n'),
  write('% 1. start         : Mulai gim                                                 %\n'),
  write('% 2. exit          : Keluar dari gim                                           %\n'),
  write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%').

inventory :-
  state(X),
  X = not_started, !,
  write('Inventory tidak tersedia karena permainan belum dimulai.'), nl.

inventory :-
  state(X),
  X = tutorial, !,
  write('Inventory tidak tersedia selama tutorial.'), nl.

inventory :-
  inventory(I),
  I = [], !,
  write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
  write('%                                ~Inventory~                                   %\n'),
  write('%                                                                              %\n'),
  write('%                            Inventory mu kosong                               %\n'),
  write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n').

inventory :-
  write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
  write('%                                ~Inventory~                                   %\n'),
  inventory(I),
  listInventory(1, I),
  write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n').
