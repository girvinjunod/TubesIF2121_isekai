boss(X) :-
	nl,
	write(X),
	write(' pun masuk ke dalam istana Raja Naga Keri.\n'),
	nl,
	write('---------------Di Istana---------------\n'),
	nl,
	write('"Selamat datang hero '),
	write(X),
	write(' di istanaku."\n'),
	write('"Saya, Raja Naga Keri, ingin berterimakasih atas jasa Anda terhadap dunia ini mengalahkan tubes2 blablabla..."\n'),
	nl,
	write('Sudah burnout marathon mengerjakan banyak tubes,'),
	write(X),
	write(' tidak tahan mendengarkan pidato raja yang panjang dan bertele-tele.\n'),
	write('Ia pun memotong pidato raja untuk menanyakan kapan dia bisa pulang ke dunianya karena dia masih dikejar deadline tubes di ITB.\n'),
	nl,
	write('"Pulang? Tapi kami membutuhkan Anda di sini! Siapa lagi yang akan membantu saya mengerjakan semua tubes ini!"\n'),
	nl,
	write(X),
	write(' tetap bersikukuh dia ingin pulang, membuat Raja Naga Keri marah.\n'),
	nl,
	write('"OK, kalau begitu saya tantang Anda untuk duel dengan saya. Kalau saya kalah Anda boleh pulang,\n'),
	write('tapi kalau saya menang Anda harus menggantikan saya sebagai raja dan mengerjakan semua tubes di Jurusan."\n'),
	nl,
	write('Berpikir duelnya konyol dan buat apa dia menerima duelnya, '),
	write(X),
	write(' pun menolak.\n'),
	nl,
	write('"Hah apa maksud lu nolak duel, ga bisa gitu dong. Pokoknya kita duel sekarang!!"\n'),
	nl,
	write('-------------BOSS BATTLE BEGINS!!!----------\n'),
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
	write('"AAAAAAAAaaaaaaaaaaaaaaaaa..."\n'),nl,nl,
	write('Raja Naga Keri telah terjatuh ke energi negatif tubes dan berubah !!!.\n'),nl,nl,nl,
	write('-------------BOSS BATTLE CONTINUES!!!----------\n'),nl,nl,
	battleBoss2, enemy, nl.

finishBoss(X):-
	write('----------------BOSS DEFEATED----------------\n'),
	nl,nl,nl,
	write('Dengan Raja Naga Keri terkalahkan, tidak ada lagi yang menghalangi '),
	write(X),
	write(' untuk kembali ke dunianya melewati portal menuju dunianya yang ada di istana.\n'),
	write('Sebelum ia pergi, ia pun menggunakan sistem pengumuman di istana untuk mengirimkan surat pengumuman ke seluruh penduduk jurusan.\n'),
	nl,
	write('Di sana dia menuliskan bahwa meskipun badai tubes telah lewat, tubes2 akan tetap ada.\n'),
	write('Oleh karena itu, dia meminta penduduk Jurusan untuk mencegah bencana ini dari terjadi lagi dengan mengerjakan segala tubes yang ada dengan benar.\n'),
	write('Bagilah tugas, aturlah waktu, jangan menumpuk semua kerjaan di Raja Keri saja.\n'),
	write('Dia menuliskan bahwa tubes adalah hal baik yang akan membuat mereka berkembang, jadi manfaatkan kesempatannya.\n'),
	write('Di akhir surat itu dia menuliskan bahwa dia harus kembali ke dunianya karena masih dikejar deadline tubesnya di ITB.\n'),
	nl,nl,
	write('"Selamat tinggal Jurusan, terima kasih untuk segalanya!"\n'),
	nl,nl,
	write('-----------Kembali ke Dunia Asal-----------\n'),
	nl,
	write(X),
	write(' pun kembali ke dunia asalnya, dia tiba2 berada di depan Indomaret yang dia sedang tuju sebelum dia keisekai.\n'),
	write('Dia pun melihat dirinya sudah kembali lagi ke semula dengan pakaian biasanya dan tanpa kekuatan apa pun.\n'),
	write('Dia meraba-raba kantongnya dan menemukan HPnya di sana, lalu ketika ia menyalakan HPnya ia pun terkejut.\n'),
	nl,
	write('Disitu tertulis tanggal 30 November 2020\n'),
	nl,
	write('"Hah kacau, udah deadline tubes Alstrukdat dong!!!!"\n'),
	nl,nl,nl,
	write('------------------------------------------------------THE END------------------------------------------------------\n'),
	setState(not_started), !, reset, fail.
	
