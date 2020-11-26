tpb(X) :-
    nl,
    write(X),
    write(' adalah seseorang mahasiswa IF ITB yang stres dengan tubesnya. \nOleh karena itu, dia pun memutuskan untuk pergi ke indomaret untuk rehat. \nNamun saat menyebrang jalan ke indomaret '),
    write(X),
    write(' ditabrak oleh truck-kun dan dia pun pergi ke isekai, yaitu dunia "Jurusan". \n'),
    nl,
    write(X),
    write(' pun terbangun di sebuah gedung bernama TPB. Ia menyadari bahwa ia tidak ada pakaian apa2 dan tidak ada barang apa2.\n'),
    write('Lalu tiba2 datang seseorang yang dikenal dengan sebutan Paus Asdos menyambut dia.\n'),
    write('Paus Asdos mengatakan bahwa '),
    write(X),
    write(' telah disummon ke dunia lain untuk membantu dunia "Jurusan" untuk membantu masyarakatnya melawan wabah monster tubes.\n'),
    write('Masih bingung dengan situasinya, Paus Asdos tiba-tiba menyuruh '),
    write(X),
    write(' untuk mengisi formulir job terlebih dahulu sebelum dijelaskan lebih lanjut.\n'),
    nl,
    formulir(X),
    nl,
    write('Lalu Paus Asdos pun melanjutkan eksposisinya.\n'),
    write('Ia bilang bahwa di dunia ini dewa-dewi Dosen telah memberikan anugerah kepada manusia dalam bentuk tubes.\n'),
    write('Dengan menyelesaikan tubes seseorang akan dapat menerima EXP points dan bisa level up, menjadi lebih hebat dari sebelumnya.\n'),
    nl,
    write('Namun sayangnya banyak masyarakat jurusan yang malas, tidak ingin mengerjakan tubes.\n'),
    write('Daripada mengerjakan, mereka malah memberikan tubes2 mereka ke Raja Keri yang handal mengerjakan tubes.\n'),
    write('Kesal namun tidak bisa menolak, Raja Keri pun menerima dan mencoba untuk mengerjakan tubes2 dari seluruh penjuru Jurusan.\n'),
    write('Karena segala tubes yang telah dikerjakannya ia menjadi sangat kuat dan telah berevolusi menjadi naga, dikenal dengan nama Raja Naga Keri.\n'),
    write('Namun, dia pun akhirnya tenggelam juga banyaknya tubes yang ada.\n'),
    nl,
    write('Marah dan kesal karena tidak ada yang membantu, dia pun mengirimkan semua tubes itu ke seluruh penjuru dunia.\n'),
    write('Tubes-tubes yang tidak dikerjakan ini pun lama-kelamaan jadi terisi dengan energi negatif lalu berubah menjadi monster.\n'),
    write('Monster-monster tubes inilah yang sedang meneror dunia jurusan dan alasan mengapa Anda disummon ke sini.\n'),
    nl,
    write('Anda sebagai mahasiswa IF ITB pastinya sudah terbiasa dan jago dalam mengalahkan tubes.\n'),
    write('Oleh karena itu, tolonglah kami oh pejuang IF ITB, selamatkan kami dari badai tubes ini, hentikan Raja Naga Keri yang marah2, dan selamatkan dunia ini.\n'),
    write('Btw, portal balik ke dunia Anda hanya ada di istana Raja Naga Keri jadi semangat!\n'),
    nl,
    write('Paus Asdos pun tidak menunggu respon '),
    write(X),
    write(' dan langsung menganggap '),
    write(X),
    write(' setuju.\n'),
    write('Ia pun langsung diterjunkan ke tutorial battle melawan sebuah tubes Alstrukdat yang telah berubah menjadi slime.\n'),
    nl,
    battleTutorial.

getStartingItem :-
    playerClass(swordsman), !,
    addToInventory(pedang_0),
    addToInventory(armor_0),
	addToInventory(potion, 5),
	write('Kamu mendapatkan pedang_0 dan armor_0.\n').

getStartingItem :-
    playerClass(archer), !,
    addToInventory(busur_panah_dan_jangka_0),
    addToInventory(jaket_0),
	addToInventory(potion, 5),
	write('Kamu mendapatkan busur_panah_dan_jangka_0 dan jaket_0.\n').

getStartingItem :-
    playerClass(sorcerer), !,
    addToInventory(magic_stick_0),
    addToInventory(kaos_0),
	addToInventory(potion, 5),
	write('Kamu mendapatkan magic_stick_0 dan kaos_0.\n').

formulir(X) :-
  write(' ----------------------------------------------------\n'),
  write('                      Formulir Job                   \n'),
  nl,
  write('   Welome to Jurusan, o\' brave hero!!\n'),
  nl,
  write('   Nama: '),
  write(X),
  nl,nl,
  write('   Pilih job Anda:\n'),
  nl,
  write('      1. Swordsman\n'),
  write('         Jobdesc:\n'),
  write('            - Defense-Oriented (ez mode)\n'),
  write('            - Base Stats:\n'),
  write('               * Initial Max HP : 800\n'),
  write('               * Attack         : 50\n'),
  write('               * Defense        : 150\n'),
  write('            - Special Attack:\n'),
  write('               * Lionheart\n'),
  write('                   -> Memberi damage sebesar HP saat itu\n'),
  write('      2. Archer\n'),
  write('         Jobdesc:\n'),
  write('            - Gimmick Oriented\n'),
  write('            - Base Stats:\n'),
  write('               * Initial Max HP : 500\n'),
  write('               * Attack         : 150\n'),
  write('               * Defense        : 50\n'),
  write('            - Special Attack:\n'),
  write('               * Steal!!!\n'),
  write('                   -> Mencuri item\n'),
  write('      3. Sorcerer\n'),
  write('         Jobdesc:\n'),
  write('            - Gacha Glass Cannon\n'),
  write('            - Base Stats:\n'),
  write('               * Initial Max HP : 400\n'),
  write('               * Attack         : 200\n'),
  write('               * Defense        : 50\n'),
  write('            - Special Attack:\n'),
  write('               * Expurusion, but with gacha\n'),
  write('                   -> Memberi damage bernilai gacha.\n'),
  nl,
  write('   Masukkan role pilihan (swordsman/archer/sorcerer):  '),
  read(RoleChosen),
  nl,
  write(' ----------------------------------------------------\n'), nl,
  validFormRole(RoleChosen).

validFormRole(Role) :-
	Role \= sorcerer, Role \= archer, Role \= swordsman, !,
	write('Hiya ga bisa baca ya.'), nl,
	write('Karena ketidakmampuan kamu dalam membaca, kamu dianggap tidak layak'), nl,
	write('masuk ke dunia tubes. Kamu langsung dibawa ke istana raja naga carry dan'), nl,
	write('kamu langsung mati di tempat. F.'), nl,
	write('Kata-kata terakhir yang kamu dengar adalah "Mulailah permainan baru."'), fail, !.

validFormRole(Role) :-
	pilihKelas(Role).


finishTutorial :-
	name(NAME),
    nl, nl, nl,
	write('---------------------------------------------------------------------------\n'), nl, nl, nl,
    write('Dengan selesainya tutorial battle ini\nPaus Asdos pun langsung mengeluarkan '),
    write(NAME),
    write(' ke dunia Jurusan yang kejam.\n'),
    nl,nl,nl,nl,
    write('------------------------------ADVENTURE START------------------------------'), nl,nl,nl,nl,
	retractall(special_cooldown(_)),
	setState(free).

battleTutorial :-
  randomize_monster(0.3, 1),
  setState(tutorial),
  asserta(special_cooldown(0)),
  battleStats,
  help, nl,
  write('Untuk membantu kamu dalam melawan tubes Alstrukdat, kamu diberikan 5 potion dan starting equipment.\n'),nl,
  write('Equip gunakan perintah equip(Nama_item)\n'),nl,
  getStartingItem.
	

