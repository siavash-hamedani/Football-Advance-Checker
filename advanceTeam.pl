
% if second and third team have same score count as possible advancing condition
advanceEvenEqual(A,B1,[A-R1|RS]) :- not(B1 == R1) -> false.

advanceEvenEqual(A,B1,[_-R1|RS]) :- B1 == R1, advanceEvenEqual(A,B1,RS).


% top 2 teams of the group advance
advances(A,[A-_|_]).

advances(A,[_,A-_|_]).

advances(A,[_,B-B1,A-A1|_]) :- A1 == B1.

advances(A,[_,B-B1,A-A1|R]) :- A1 == B1 -> advanceEvenEqual(A,B1,R).


% make a dictionary of the atoms inside the list and initialzie to 0
listToZeroDict([],[]).
listToZeroDict([A|X],[A:0|W]) :- listToZeroDict(X,W).

% calculate the score of the team based on the outcome given
score(Q,[],C) :-
    listToZeroDict(Q,S),
    dict_create(C,scores,S).

score(Q,[win(A,B)|X],C) :-
    score(Q,X,N),
    N1X is N.get(A) + 3 , N1 = N.put(A, N1X), N2X is N1.get(B) + 0, N2 = N1.put(B,N2X), C = N2.

score(Q,[draw(A,B)|X],C) :-
    score(Q,X,N),
    N1X is N.get(A) + 1 , N1 = N.put(A, N1X), N2X is N1.get(B) + 1, N2 = N1.put(B,N2X), C = N2.


% all possible combinations of selecting two items from a list
choiceOf2([A|X],T) :-
    T = (A,W),
    member(W,X) ; choiceOf2(X,T).


% outcome of a match is either a draw or a win for either side
outComes([],_,[]).

outComes([(A1,A2)|X],NW,[T|Q]) :-
    outComes(X,NW,Q),
    ((T = win(A1,A2) ; T = draw(A1,A2) ; T = win(A2,A1)),
     not(member(T,NW))).


% play games and generate all outcomes possbile
playGames(INP,T,NW,RES) :-
    findall(L,choiceOf2(INP,L),W),
    outComes(W,NW,T),
    score(INP,T,RES).


% split a list to two same length lists
split([],[],[]).

split([A],[A],[]).

split([A,B],[A],[B]).

split([A,B|X],[A|R1],[B|R2]) :-
    split(X,R1,R2).

% the > function that checks condition on the value part of a k-v pair
isBiggerPaired((_-A2),(_-B2)) :- A2 < B2.

% merge part of a merge sort
merge([],[],[]).

merge([],R,R).

merge(R,[],R).

merge([A|R1],[B|R2],[B|W1]) :-
    isBiggerPaired(A,B),
    merge([A|R1],R2,W1).

merge([A|R1],[B|R2],[A|W2]) :-
    not(isBiggerPaired(A,B)),
    merge(R1,[B|R2],W2).


% mergesort algorithm
mergeSort([],[]).

mergeSort([X],[X]).

mergeSort(INP,Result) :-
    split(INP,Left,Right),
    mergeSort(Left,SortedLeft),
    mergeSort(Right,SortedRight),
    merge(Left,Right,Result),!.



mergeSortDict(INP,RES) :-
    dict_pairs(INP,scores,PAIRED),
    mergeSort(PAIRED,RES).


% make a list of outcomes that are not possible given an input outcome
% if a A and B have a draw, then we would not have the outcome of A wins B
%     or B wins A
generateComplementOfOutcomes([],[]).

generateComplementOfOutcomes([win(A,B)|X],[win(B,A)|R]) :-
    generateComplementOfOutcomes(X,R).

generateComplementOfOutcomes([draw(A,B)|X],[win(B,A),win(A,B)|R]) :-
    generateComplementOfOutcomes(X,R).


% generate the possible ways a team might advance to next round
teamAdvances(Team,INP,OutcomesSoFar,FutureOutComes,Scores) :-
    generateComplementOfOutcomes(OutcomesSoFar,ComplementOfSoFar),
    playGames(INP,FutureOutComes,ComplementOfSoFar,Scores),
    mergeSortDict(Scores,SortedScores),
    advances(Team,SortedScores).

