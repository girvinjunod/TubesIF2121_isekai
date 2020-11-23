/* penjelasan quest:
 * available_quest itu quest yang masih di Q.
 * active_quest itu quest yang udah diambil.
 * active_quest cuma boleh ada satu, kalo belum selesai belum ilang.
 * avalable_quest sama active_quest itu tuple (S,Go,W,Gh,Exp,Gold),
 * S banyak slime,
 * Go banyak goblin,
 * W banyak wolf,
 * Gh banyak ghost,
 * Exp jumlah experience reward quest,
 * Gold jumlah gold reward quest.
 */
/* note: belum tau standar gold, jadi ngasal dulu */

/* dynamic predicate quest */
:- dynamic(available_quest/6).
:- dynamic(active_quest/6).

/* generator available_quest */
/* note: generate-nya sebagian random, sebagian fixed */
generate_quest :-
	/* random quest */
	forall(between(1,6,_),(
		random(0,10,S),
		random(0,7,Go),
		random(0,5,W),
		random(0,3,Gh),
		XP is 30*S + 40*Go + 50*W + 100*Gh,
		Gold is 3*S + 4*Go + 5*W + 10*Gh,  
		asserta(available_quest(S,Go,W,Gh,XP,Gold))
		)),
	/* quest spam satu monster */
	asserta(available_quest(5,0,0,0,150,15)),
	asserta(available_quest(0,5,0,0,200,20)),
	asserta(available_quest(0,0,5,0,250,25)),
	asserta(available_quest(0,0,0,5,500,50)).
