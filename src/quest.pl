/* penjelasan quest:
 * available_quest itu quest yang masih di Q.
 * active_quest itu quest yang udah diambil.
 * active_quest cuma boleh ada satu, kalo belum selesai belum ilang.
 * quest itu tuple (S,Go,W,Gh,Exp,Gold),
 * S banyak slime,
 * Go banyak goblin,
 * W banyak wolf,
 * Gh banyak ghost,
 * Exp jumlah experience reward quest,
 * Gold jumlah gold reward quest.
 * active_quest itu quest, available_quest itu list of quests
 */
/* note: belum tau standar gold, jadi ngasal dulu */

/* dynamic predicate quest */
:- dynamic(available_quest/1).
:- dynamic(active_quest/6).

/* generator available_quest */
/* note: generate-nya sebagian random, sebagian fixed */

add_quest(Tuple) :- \+available_quest(_), asserta(available_quest([Tuple])), !.
add_quest(Tuple) :-
	available_quest(OldAvailableQuest),
	retractall(available_quest(_)),
	addToList(Tuple,OldAvailableQuest,NewAvailableQuest),
	asserta(available_quest(NewAvailableQuest)).

remove_available_quest :-
	available_quest(_),
	!,
	retractall(available_quest(_)).
remove_available_quest.

remove_active_quest :-
	active_quest(_,_,_,_,_,_),
	!,
	retractall(available_quest(_,_,_,_,_,_)).
remove_active_quest.

generate_quest :-
	/* hapus available_quest kalo ada */
	remove_available_quest,
	remove_active_quest,
	/* quest spam satu monster */
	add_quest([5,0,0,0,150,150]),
	add_quest([0,5,0,0,200,200]),
	add_quest([0,0,5,0,250,250]),
	add_quest([0,0,0,5,500,500]),
	/* random quest */
	forall(between(1,5,_),(
		random(0,10,S),
		random(0,7,Go),
		random(0,5,W),
		random(0,3,Gh),
		XP is 30*S + 40*Go + 50*W + 100*Gh,
		Gold is 30*S + 40*Go + 50*W + 100*Gh,
		add_quest([S,Go,W,Gh,XP,Gold])
		)),
	!.

/* available quests printing util. */
print_quest(X,[[S,Go,W,Gh,Exp,Gold]]) :- 
	format('~w ~d. ~d Slime(s), ~d Goblin(s), ~d Wolf(s), ~d Ghost(s), ~d Exp(s), ~d Gold(s)   ~w\n',['%',X,S,Go,W,Gh,Exp,Gold,'%']).
print_quest(X,[[S,Go,W,Gh,Exp,Gold]|Tail]) :-
	format('~w ~d. ~d Slime(s), ~d Goblin(s), ~d Wolf(s), ~d Ghost(s), ~d Exp(s), ~d Gold(s)   ~w\n',['%',X,S,Go,W,Gh,Exp,Gold,'%']),
	NextX is X + 1,
	print_quest(NextX,Tail),
	!.

print_quest :-
	write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
	write('%                               ~Quest Board~                                  %\n'),
	write('%                                                                              %\n'),
	available_quest(Q),
	print_quest(1,Q),
	write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n').

/* command quest. */
/* player lagi gak di quest cell (Q) */
quest :-
	state(free),
	\+player_cell(quest_cell),
	!,
	write('Anda sedang tidak ada di dekat quest board (Q)!\n').
/* player punya active quest */
quest :-
	state(free),
	active_quest(_,_,_,_,_,_),
	!,
	write('Anda belum menyelesaikan quest Anda!\n').
/* available_quest abis */
quest :-
	state(free),
	\+available_quest(_),
	!,
	write('Tidak ada quest lagi untuk dilakukan.\n').
quest :-
	state(free),
	setState(quest),
	print_quest,
	write('Mau pilih quest yang mana?\nInput nomor quest untuk mengambil questnya.\nInput apapun yang lain untuk keluar dari quest board.\n'),
	read(Query),
	(
		integer(Query),
		available_quest(Q),
		countList(Q,NbAvailableQuest),
		Query >= 0,
		Query =< NbAvailableQuest,
		removeNth(Q,Query,NewAvailableQuest,[S,Go,W,Gh,Exp,Gold]),
		retractall(available_quest(_)),
		asserta(available_quest(NewAvailableQuest)),
		asserta(active_quest(S,Go,W,Gh,Exp,Gold)),
		format('Anda mengambil quest nomor ~d.\n',[Query]),
		write('Anda telah keluar dari qeust board.\n'),
		setState(free),
		!
	);
	(
		Query = quit,
		write('Anda telah keluat dari quest board\n'),
		setState(free),
		!
	).

/* cek udah nyelesaiin 5 quest apa belum */
cek_completed_five_quests :-
	available_quest(Q),
	countList(Q,NbAvailableQuest),
	NbAvailableQuest = 4, /* 4 karena awalnya ada 9 quest, 9-4=5 */
	!,
	unlock_dungeon_boss_cell. /* ada di map.pl */

/* ngereward quest yang udah selesai */
active_quest_reward :-
	active_quest(_,_,_,_,Exp,Gold),
	write('Anda telah menyelesaikan quest Anda!\n'),
	format('Anda mendapatkan ~d Exp(s) dan ~d Gold(s).\n',[Exp,Gold]),
	earnExp(Exp),
	earnGold(Gold),
	retractall(active_quest(_,_,_,_,_,_)),
	cek_completed_five_quests,
	!.

/* ngecek active_quest selesai apa belum */
cek_active_quest :-
	active_quest(S,Go,W,Gh,_,_),
	!,
	S = 0,
	Go = 0,
	W = 0,
	Gh = 0,
	active_quest_reward, !.

/* update active quest abis battle */
update_active_quest(Monster) :-
	active_quest(S,Go,W,Gh,Exp,Gold),
	!,
	(
		(
			Monster = 'slime',
			NewS is S - 1,
			NewS >= 0,
			!,
			retractall(active_quest(_,_,_,_,_,_)),
			asserta(active_quest(NewS,Go,W,Gh,Exp,Gold))
		);
		(
			Monster = 'goblin',
			NewGo is Go - 1,
			NewGo >= 0,
			!,
			retractall(active_quest(_,_,_,_,_,_)),
			asserta(active_quest(S,NewGo,W,Gh,Exp,Gold))
		);
		(
			Monster = 'wolf',
			NewW is W - 1,
			NewW >= 0,
			!,
			retractall(active_quest(_,_,_,_,_,_)),
			asserta(active_quest(S,Go,NewW,Gh,Exp,Gold))
		);
		(
			Monster = 'ghost',
			NewGh is Gh - 1,
			NewGh >= 0,
			!,
			retractall(active_quest(_,_,_,_,_,_)),
			asserta(active_quest(S,Go,W,NewGh,Exp,Gold))
		)
	),
	cek_active_quest,
	!.
update_active_quest(_).
