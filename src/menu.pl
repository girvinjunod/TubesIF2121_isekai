menu :-
  write('       ____  U _____ u _   _    ____     _   _               _   _ \n'),
  write('U /"___|u | ___"|/| \\ |"|  / __"| u | | | |     ___     | \\ |"|    \n'),
  write('\\| |  _ / |  _|" <|  \\| |><\\___ \\/ /| |_| |\\   |_"_|   <|  \\| |>   \n'),
  write(' | |_| |  | |___ U| |\\  |u u___) | U|  _  |u    | |    U| |\\  |u   \n'),
  write('  \\____|  |_____| |_| \\_|  |____/>> |_| |_|   U/| |\\u   |_| \\_|    \n'),
  write(' _)(|_   <<   >> ||   \\,-.)(  (__)//   \\.-,_|___|_,-.||   \\,-. \n'),
  write(' (__)__) (__) (__)(_")  (_/(__)    (_") ("_)\\_)-\' \'-(_/ (_")  (_/  \n'),
  nl,
  write('Welcome to insert nama game!!\n'),
  nl,
  write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
  write('%                          ~Kok Isekai Gw Penuh Tubes~                         %\n'),
  write('% 1. start  : untuk memulai petualanganmu                                      %\n'),
  write('% 2. map    : menampilkan peta                                                 %\n'),
  write('% 3. status : menampilkan kondisimu terkini                                    %\n'),
  write('% 4. w      : gerak ke utara 1 langkah                                         %\n'),
  write('% 5. a      : gerak ke barat 1 langkah                                         %\n'),
  write('% 6. s      : gerak ke selatan 1 langkah                                       %\n'),
  write('% 7. d      : gerak ke ke timur 1 langkah                                      %\n'),
  write('% 8. Status : menampilkan status pemain                                        %\n'),
  write('% 9. help   : menampilkan segala bantuan                                       %\n'),
  write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%').

status :-
  hp(HP), maxHP(MaxHP), attack(ATK), defense(DEF),
   write('$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'), nl,
  format('$ HP: ~w/~w                       $', [HP, MaxHP]), nl,
  format('$ Attack: ~w                      $', [ATK]), nl,
  format('$ Defense: ~w                      $', [DEF]), nl,
   write('$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'), nl.
