%% CS 3270 instructor
%% Vanderbilt University

:- ['hw05.pl'].

:- begin_tests(hw05).

% Problem 1.1 (sibling)
test(sibling_1) :- sibling(b, c).
test(sibling_2, [fail]) :- sibling(a, i).


% Problem 1.2 (cousin)
test(cousin_1) :- cousin(d, f).
test(cousin_2, [fail]) :- cousin(g, b).


% Problem 1.3 (grandchild)
test(grandchild_1) :- grandchild(d, a).
test(grandchild_2, [fail]) :- grandchild(g, c).


% Problem 1.4 (descendant)
test(descendant_1, [nondet]) :- descendant(b, a).
test(descendant_2, [fail]) :- descendant(d, e).


% Problem 2.1 (isin_atom)
test(isin_atom_1, [nondet]) :- isin_atom(b, [a, b, c]).
test(isin_atom_2, [fail]) :- isin_atom(d, [a, b, c]).


% Problem 2.2 (isin_list)
test(isin_list_1, [nondet]) :- isin_list([b], [a, b, c]).
test(isin_list_2, [nondet]) :- isin_list([a, b], [a, b, c]).
test(isin_list_3, [fail]) :- isin_list([a, d], [a, b, c]).
test(isin_list_4, [nondet]) :- isin_list([a, c], [a, b, c]).
test(isin_list_5, [nondet]) :- isin_list([], [a, b, c]).


% Problem 2.3 (none_common)
test(none_common_1) :- none_common([a, b], [c, d, e]).
test(none_common_2, [fail]) :- none_common([d, e, a], [a, b]).
test(none_common_3, [fail]) :- none_common([a], [a, b, c]).


% Problem 2.4 (combine)
% permutation is used to check that the result is some permutation of [a, b, c, d].
test(combine_1, [nondet]) :- combine([d], [a, b, c], X), permutation([a, b, c, d], X).
test(combine_2, [nondet]) :- combine([a, b, c], [c, d, e], X), permutation([a, b, c, d, e], X).
test(combine_3, [nondet]) :- combine([], [a, b, c], X), permutation([a, b, c], X).


% Problem 2.5 (in_common)
test(in_common_1, [nondet]) :- in_common([a, b, c], [d, c, e, b], X), permutation([b, c], X).
test(in_common_2, X == []) :- in_common([d, e, f], [a, b, c], X).
test(in_common_3, X == []) :- in_common([], [a, b, c], X).


% Problem 2.6 (flip)
test(flip_1) :- flip([a, b, c, d], [d, c, b, a]).
test(flip_2) :- flip([a], [a]).


% Problem 2.7 (make_flat)
test(make_flat_1, all(X == [[1, 2, 3, 4, 5, 6]])) :- make_flat([[1, 2], [3, 4], [5, 6]], X).
test(make_flat_2, all(X == [[1, 2, 3, 4, [5, 6]]])) :- make_flat([[1, 2], [3, 4, [5, 6]]], X).
test(make_flat_3, [fail]) :- make_flat([[1, 2], [3, 4], 5, 6], _).


% Problem 3.1 (sum_of_list)
test(sum_of_list_1, X == 0) :- sum_of_list([], X).
test(sum_of_list_2, X == 10) :- sum_of_list([1, 2, 3, 4], X).


% Problem 3.2 (occurrences)
test(occurrences_1, [nondet]) :- occurrences(a, [], 0).
test(occurrences_2, [nondet]) :- occurrences(a, [b, c, d, e], 0).
test(occurrences_3, [nondet]) :- occurrences(a, [b, c, d, e, a], 1).


% Problem 3.3 (occurs)
test(occurs_1, [nondet]) :- occurs([a, b, c], 0, a).
test(occurs_2, [fail]) :- occurs([a, b, c], 3, b).
test(occurs_3, [nondet]) :- occurs([a, b, c], 1, X), X = b.

:- end_tests(hw05).