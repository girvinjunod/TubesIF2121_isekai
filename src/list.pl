/* List operator */

addToList(X, [], [X]).
addToList(X, [H|T], Ret) :- addToList(X, T, TailRet), Ret = [H|TailRet].

countList([], 0).
countList([_|T], Cnt) :- countList(T, LastCnt), Cnt is LastCnt+1.

removeFromList(_, [], []) :- !.
removeFromList(X, [X|T], T) :- !.
removeFromList(X, [H|T], [H|Ret]) :- removeFromList(X, T, Ret), !.

countItem(_, [], Cnt) :- Cnt is 0, !.
countItem(X, [Y], Cnt) :-
  (
    X \== Y, Cnt is 0;
    X == Y, Cnt is 1
  ), !.
countItem(X, [X], Cnt) :- Cnt is 1, !.
countItem(X, [Y|Z], Cnt) :-
  countItem(X, Z, LastCnt),
  (
    X == Y, Cnt is LastCnt+1;
    X \== Y, Cnt is LastCnt
  ), !.

/* asumsi: 0<N<=size List */
removeNth([_|Tail],1,Tail).
removeNth([Head|Tail],N,Ret) :-
	NextN is N - 1,
	removeNth(Tail,NextN,Tmp),
	Ret = [Head|Tmp].