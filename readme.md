> **The Academic Honor Policy (see Brightspace) is applicable to all work you do in CS 3270/5270.**

# CS 3270: Programming Languages
## Homework 5 (Part II)

Introduction to Prolog

## Goals

* Creating our own database of rules and relationships.
* Writing Prolog rules for processing lists and numbers.

## GitHub notes

Please see [GitHub notes](github-notes.md) for more information on cloning, committing, and pushing repositories.

## Style guidelines

* **Names:** Use proper style for names. The naming convention in Prolog is to separate multi-word names with underscores. For example, a predicate that determines if an element is a member of a list could be called `my_member`, a variable that represents a last name could be called `Last_Name`, and an atom that represents a particular book title could be called `tree_of_hands`. Also, use meaningful names. For example, a name representing speed should be called `speed` instead of just `s`.

* **Line lengths:** No lines should exceed 100 columns.

* **Indentation:** Use proper and consistent indentation. When separating out sub-goals of a single rule into multiple lines, use consistent indenting for all sub-goals after the first line of the rule.

* **Whitespace:** Predicates with different names should be separated by at least one empty line.

* **Comments:** Provide a short descriptive comment before each unique group of predicates that you define. The comments do not have to be in Javadoc-style.

## Resources

Put all your Prolog rules into `hw05.pl` that can be loaded (consulted) by the SWI-Prolog interpreter.

To test your rules, consult `hw05.plt` and then type `run_tests.` on the Prolog prompt. Note that you will get a failed test for any rules that are incorrect or haven't been written yet. Also, we may perform more tests when grading your solution.

## Exercises

**You may only use predicates and language constructs that were described in class. In some problems, you can use predicates that you've written in earlier problems.**

### Part 1 – Database processing and rules

Let's start off with a simple database and rules that define family relationships.

Assume you are given a set of facts of the form `parent(name1, name2)`, where `name1` is the parent of `name2`. For example, consider the following genealogical tree (included in the `hw05.pl` file):

   ```Prolog
   parent(a, b).   % 1
   parent(a, c).   % 2
   parent(b, d).   % 3
   parent(b, e).   % 4
   parent(c, f).   % 5
   parent(d, g).   % 6
   parent(d, h).   % 7
   parent(d, i).   % 8
   ```

   whose graphical representation is:

   ```Prolog
            a
          /   \
         b     c
       /   \   |
      d     e  f
    / | \
   g  h  i
   ```

Define the following rules in your `hw05.pl` file. These rules should be able to give all possible pairs of values (if Prolog was asked for another answer).

1. Define a predicate `sibling(X, Y)` that holds *iff* `X` and `Y` are siblings. Note that a person is not a sibling of themselves, so you will not want to produce that result. You can specify that two variables cannot unify to the same object by the rule `not(X = Y)`. Try your rule once without this additional term, see what happens, then add the term. The `not` predicate is your logical negation operator. [Please be careful how you use the `not(X = Y)` predicate. This predicate may not make sense until `X` and `Y` have been unified with actual values. Thus when using it in a rule, you should place it *after* the other terms that cause `X` and `Y` to be unified with values.]

   ```Prolog
   ?- sibling(b, c).
   true.

   ?- sibling(a, i).
   false.
   ```

2. Define a predicate `cousin(X, Y)` that holds *iff* `X` and `Y` are cousins. We are only interested in first cousins.

   ```Prolog
   ?- cousin(d, f).
   true.

   ?- cousin(g, b).
   false.
   ```

3. Define a predicate `grandchild(X, Y)` that holds *iff* `X` is a grandchild of `Y`.

   ```Prolog
   ?- grandchild(d, a).
   true.

   ?- grandchild(g, c).
   false.
   ```

4. Define a predicate `descendant(X, Y)` that holds *iff* `X` is a descendant of `Y`.

   ```Prolog
   ?- descendant(b, a).
   true.

   ?- descendant(d, e).
   false.
   ```

### Part 2 – List processing

Consider representing a *set* as a list of values (no duplicates). Define the following predicates in your `hw05.pl` file. To avoid unnecessary warning messages from the Prolog interpreter, use the *don't care* variable `_` (i.e., the underscore) to represent variables that don't matter.

Your solution can give multiple answers (if we asked for another problem) as long as there is a correct answer (usually the first answer).

When we grade these five problems, we will always provide sets (no duplicates) as parameters.

1. `isin_atom(Atom, Lst)` that holds *iff* the element `Atom` occurs in `Lst`. You can copy the `my_member` predicate defined in class. Consider using this predicate in the next problem. Also, use this predicate and the `not` predicate for problems 3 - 5.

   ```Prolog
   ?- isin_atom(b, [a, b, c]).
   true.

   ?- isin_atom(d, [a, b, c]).
   false.
   ```

2. `isin_list(Lst1, Lst2)` that holds *iff* `Lst1` is a subset of `Lst2`.

   ```Prolog
   ?- isin_list([b], [a, b, c]).
   true.

   ?- isin_list([a, b], [a, b, c]).
   true.

   ?- isin_list([a, d], [a, b, c]).
   false.

   ?- isin_list([a, c], [a, b, c]).
   true.

   ?- isin_list([], [a, b, c]).
   true.
   ```

3. `none_common(Lst1, Lst2)` that holds *iff* `Lst1` and `Lst2` have no elements in common.

   ```Prolog
   ?- none_common([a, b], [c, d, e]).
   true.

   ?- none_common([d, e, a], [a, b]).
   false.

   ?- none_common([a], [a, b, c]).
   false.
   ```

4. `combine(Lst1, Lst2, Lst3)` that, given two lists `Lst1` and `Lst2`, will produce their union `Lst3`. You should not allow duplicates in the list `Lst3`.

   ```Prolog
   ?- combine([d], [a, b, c], Result).
   Result = [d, a, b, c].

   ?- combine([a, b, c], [c, d, e], Result).
   Result = [a, b, c, d, e].

   ?- combine([],[a, b, c], Result).
   Result = [a, b, c].
   ```

5. `in_common(Lst1, Lst2, Lst3)` that, given two lists `Lst1` and `Lst2`, will produce their intersection `Lst3`.

   ```Prolog
   ?- in_common([a, b, c], [d, c, e, b], Result).
   Result = [b, c].

   ?- in_common([d, e, f], [a, b, c], Result).
   Result = [].

   ?- in_common([], [a, b, c], Result).
   Result = [].
   ```

   The following two rules are for generic list processing, rather than processing of sets.

6. `flip(Lst1, Lst2)` that holds *iff* the list `Lst1` is the reverse of `Lst2` and vice versa. You can do this one of two ways:

   a. You can utilize the `append(Lst1, Lst2, Result)` that results in a slower function.

   b. You can create a tail-recursive helper function that utilizes an accumulator. In this case, `flip` still takes only two parameters, but calls the helper function to do all the work.

   ```Prolog
   ?- flip([a, b, c, d], [d, c, b, a]).
   true.

   ?- flip([a], [a]).
   true.
   ```

7. `make_flat(Lst1, Lst2)` that, given a list of lists `Lst1`, will produce a list `Lst2`, where the top level lists have been flattened into a single list. We are only flattening the top level lists (and not attempting to flatten any sublists).

   ```Prolog
   ?- make_flat([[1, 2], [3, 4], [5, 6]], Lst2).
   Lst2 = [1, 2, 3, 4, 5, 6].

   ?- make_flat([[1, 2], [3, 4, [5, 6]]], Lst2).
   Lst2 = [1, 2, 3, 4, [5, 6]].

   ?- make_flat([[1, 2], [3, 4], 5, 6], Lst2).
   false. % Since all top level items are not lists.
   ```

### Part 3 – List processing and numbers

Define the following predicates in your `hw05.pl` file.

1. `sum_of_list(Lst, Sum)` that, given a list of integers `Lst`, returns the sum `Sum` of all the elements of `Lst`.

   ```Prolog
   ?- sum_of_list([], Sum).
   Sum = 0.

   ?- sum_of_list([1, 2, 3, 4], Sum).
   Sum = 10.
   ```

2. `occurrences(Atom, Lst, Num)` that holds *iff* the element `Atom` occurs `Num` times in the list `Lst`.

   ```Prolog
   ?- occurrences(a, [], 0).
   true.

   ?- occurrences(a, [b, c, d, e], Num).
   Num = 0.

   ?- occurrences(a, [b, c, d, e, a], Num).
   Num = 1.
   ```

3. `occurs(Lst, Idx, Atom)` that holds *iff* `Atom` is the element occurring in position `Idx` of the list `Lst`. Let's use zero-based indexing in our list, so that `occurs([a, b, c], 1, b)` is `true.`

   ```Prolog
   ?- occurs([a, b, c], 0, a).
   true.

   ?- occurs([a, b, c], 3, b).
   false.

   ?- occurs([a, b, c], 1, Atom).
   Atom = b.
   ```

## Final notes

* Ensure that your name, VUnetID, email address, and the honor code statement appear in the header comments of files you altered.

* You must only update `hw05.pl`. Do not alter any other files!

* Submissions for this assignment will be run on additional hidden test cases during grading.

* All files necessary to run your program must reside in the GitHub.com repository.

* For full credit, your program must pass the build on GitHub. You will have to push to GitHub in order to trigger a build.
