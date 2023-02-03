% Name: Vincent Gilliam
% vunetID: gilliava
% email address: vincent.a.gilliam@vanderbilt.edu
% honor code: I have not received nor given help on this assignment.


% Data supplied with assignment:
parent(a, b).  % 1
parent(a, c).  % 2
parent(b, d).  % 3
parent(b, e).  % 4
parent(c, f).  % 5
parent(d, g).  % 6
parent(d, h).  % 7
parent(d, i).  % 8

% Define a predicate sibling(X, Y) that holds iff X and Y are siblings
sibling(X, Y) :- parent(Parent, X), parent(Parent, Y), not(X = Y).
% Define a predicate cousin(X, Y) that holds iff X and Y are cousins.
cousin(X, Y) :- sibling(Parent1, Parent2), parent(Parent1, X), parent(Parent2, Y).
% Define a predicate grandchild(X, Y) that holds iff X is a grandchild of Y
grandchild(X, Y) :- parent(Y, Parent), parent(Parent, X).
% Define a predicate descendant(X, Y) that holds iff X is a descendant of Y
descendant(X, Y) :- parent(Y, X).
descendant(X, Y) :- parent(Y, Z), descendant(X, Z).
% isin_atom(Atom, Lst) that holds iff the element Atom occurs in Lst
isin_atom(Atom, [Atom|_]).
isin_atom(Atom, [_|Lst]) :- isin_atom(Atom, Lst).
% isin_list(Lst1, Lst2) that holds iff Lst1 is a subset of Lst2
isin_list([], _).
isin_list([Head|Lst1], [Head|Lst2]) :- isin_list(Lst1,Lst2).
isin_list(Lst1, [_|Lst2]) :- isin_list(Lst1,Lst2).
% none_common(Lst1, Lst2) that holds iff Lst1 and Lst2 have no elements in common
none_common([], _).
none_common([Head|Lst1], Lst2) :- not(isin_atom(Head, Lst2)), none_common(Lst1, Lst2).
% combine(Lst1, Lst2, Lst3) that, given two lists Lst1 and Lst2, will produce their union Lst3
combine([],Lst2,Lst2).
combine([Head|Tail], Lst2, Result) :- isin_atom(Head, Lst2), combine(Tail, Lst2, Result).
combine([Head|Tail], Lst2, [Head|Result]) :- not(isin_atom(Head, Lst2)), combine(Tail, Lst2, Result).
% in_common(Lst1, Lst2, Lst3) that, given two lists Lst1 and Lst2, will produce their intersection Lst3.
in_common([], _ ,[]).
in_common([Head|Tail], Lst2, Result) :- not(isin_atom(Head, Lst2)), in_common(Tail, Lst2, Result).
in_common([Head|Tail], Lst2,[Head|Result]) :- isin_atom(Head, Lst2), in_common(Tail, Lst2, Result).
% flip(Lst1, Lst2) that holds iff the list Lst1 is the reverse of Lst2 and vice versa
flip_acc(Lst1,_, Lst1).
flip_acc(Lst1, [Head|Tail], Acc) :-  flip_acc(Lst1, Tail, [Head|Acc]). 
flip(Lst1, Lst2) :- flip_acc(Lst1, Lst2, []).
% make_flat(Lst1, Lst2) that, given a list of lists Lst1, will produce a list Lst2, where the top level lists have % been flattened into a single list, use append as a helpers
append([], Lst2, Lst2).
append([Head|Tail], Lst2, [Head|Result]) :- append(Tail, Lst2, Result).

make_flat_acc([], Lst2, Lst2) :- !.
make_flat_acc([Head|Tail], Lst2, Acc) :- is_list(Head), make_flat_acc(Tail, Lst2 ,Result), append(Acc,Head, Result).
make_flat(Lst1, Lst2):- make_flat_acc(Lst1, Lst2, []), Lst2 = [_|_].
% sum_of_list(Lst, Sum) that, given a list of integers Lst, returns the sum Sum of all the elements of Lst
sum_of_list([], 0).
sum_of_list([Head|Tail], SL) :- sum_of_list(Tail, Sum), SL is Head + Sum.
% occurrences(Atom, Lst, Num) that holds iff the element Atom occurs Num times in the list Lst
occurrences(_, [], 0).
occurrences(Atom, [Atom|Tail], Final) :- occurrences(Atom, Tail, Num), Final is Num + 1.
occurrences(Atom, [_|Tail], Num) :- occurrences(Atom, Tail, Num).
% occurs(Lst, Idx, Atom) that holds iff Atom is the element occurring in position Idx of the list Lst
occurs([Atom|_], 0, Atom).
occurs([_|Tail], Final, Atom) :- occurs(Tail, Idx, Atom), Final is Idx + 1.
