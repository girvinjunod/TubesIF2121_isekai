boss(X) :-
	nl,
	write(X),
	write(' pun masuk ke dalam istana Raja Naga Keri.\n'), sleep(3),
	nl,
	write('---------------Di Istana---------------\n'), sleep(1),
	nl,
	write('"Selamat datang hero '),
	write(X),
	write(' di istanaku."\n'), sleep(2),
	write('"Saya, Raja Naga Keri, ingin berterimakasih atas jasa Anda terhadap dunia ini mengalahkan tubes2 blablabla..."\n'),
	nl, sleep(2),
	write('Sudah burnout marathon mengerjakan banyak tubes, '),
	write(X),
	write(' tidak tahan mendengarkan pidato raja yang panjang dan bertele-tele.\n'), sleep(2),
	write('Ia pun memotong pidato raja untuk menanyakan kapan dia bisa pulang ke dunianya karena dia masih dikejar deadline tubes di ITB.\n'), sleep(2),
	nl,
	write('"Pulang? Tapi kami membutuhkan Anda di sini! Siapa lagi yang akan membantu saya mengerjakan semua tubes ini!"\n'), sleep(2),
	nl,
	write(X),
	write(' tetap bersikukuh dia ingin pulang, membuat Raja Naga Keri marah.\n'), sleep(2),
	nl,
	write('"OK, kalau begitu saya tantang Anda untuk duel dengan saya. Kalau saya kalah Anda boleh pulang,\n'),
	write('tapi kalau saya menang Anda harus menggantikan saya sebagai raja dan mengerjakan semua tubes di Jurusan."\n'),
	nl, sleep(2),
	write('Berpikir duelnya konyol dan buat apa dia menerima duelnya, '),
	write(X),
	write(' pun menolak.\n'), sleep(2),
	nl,
	write('"Hah apa maksud lu nolak duel, ga bisa gitu dong. Pokoknya kita duel sekarang!!"\n'), sleep(2),
	nl,
	write('-------------BOSS BATTLE BEGINS!!!----------\n'), sleep(2),
	nl, battleBoss, enemy, nl.

	
battleBoss :-
	randomize_monster(boss),
	setState(battle),
	retractall(special_cooldown(_)),
	asserta(special_cooldown(0)).
battleBoss2 :-
	randomize_monster(boss2),
	setState(battle),
	retractall(special_cooldown(_)),
	asserta(special_cooldown(0)).

changephase(X):-
	nl,nl,nl, sleep(2), nl,
	write('Raja Naga Keri terjatuh kalah melawan '), write(X), write('.\n'),
	write('"Tidakkkkkk...."\n'),nl,
	sleep(1),
	write('"Ini belum berakhir..."\n'), nl,
	sleep(2),
	write('"AAAAAAAAaaaaaaaaaaaaaaaaa..."\n'),nl,nl, sleep(2),
	write('Raja Naga Keri telah terjatuh ke energi negatif tubes dan berubah !!!.\n'),nl,nl,nl, sleep(2),
	write('-------------BOSS BATTLE CONTINUES!!!----------\n'), sleep(2),nl,nl,
	battleBoss2, enemy, nl.

finishBoss(X):-
	write('----------------BOSS DEFEATED----------------\n'),
	nl,nl,nl,
	write('Dengan Raja Naga Keri terkalahkan, tidak ada lagi yang menghalangi '), 
	write(X),
	write(' untuk kembali ke dunianya melewati portal menuju dunianya yang ada di istana.\n'), sleep(2),
	write('Sebelum ia pergi, ia pun menggunakan sistem pengumuman di istana untuk mengirimkan surat pengumuman ke seluruh penduduk jurusan.\n'), sleep(2),
	nl,
	write('Di sana dia menuliskan bahwa meskipun badai tubes telah lewat, tubes2 akan tetap ada.\n'), sleep(2),
	write('Oleh karena itu, dia meminta penduduk Jurusan untuk mencegah bencana ini dari terjadi lagi dengan mengerjakan segala tubes yang ada dengan benar.\n'), sleep(2),
	write('Bagilah tugas, aturlah waktu, jangan menumpuk semua kerjaan di Raja Keri saja.\n'), sleep(2),
	write('Dia menuliskan bahwa tubes adalah hal baik yang akan membuat mereka berkembang, jadi manfaatkan kesempatannya.\n'), sleep(2),
	write('Di akhir surat itu dia menuliskan bahwa dia harus kembali ke dunianya karena masih dikejar deadline tubesnya di ITB.\n'), sleep(2),
	nl,nl,
	write('"Selamat tinggal Jurusan, terima kasih untuk segalanya!"\n'), sleep(5),
	nl,nl,
	write('-----------Kembali ke Dunia Asal-----------\n'), sleep(3),
	nl,
	write(X),
	write(' pun kembali ke dunia asalnya, dia tiba2 berada di depan Indomaret yang dia sedang tuju sebelum dia keisekai.\n'), sleep(3),
	write('Dia pun melihat dirinya sudah kembali lagi ke semula dengan pakaian biasanya dan tanpa kekuatan apa pun.\n'), sleep(2),
	write('Dia meraba-raba kantongnya dan menemukan HPnya di sana, lalu ketika ia menyalakan HPnya ia pun terkejut.\n'), sleep(2),
	nl,
	write('Disitu tertulis tanggal 30 November 2020\n'), sleep(4),
	nl,
	write('"Hah kacau, udah deadline tubes Alstrukdat dong!!!!"\n'), sleep(4),
	nl,nl,nl,
	write('------------------------------------------------------THE END------------------------------------------------------\n'),
	setState(not_started), !, reset, fail.
	
