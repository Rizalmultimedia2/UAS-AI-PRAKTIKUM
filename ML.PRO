% Knowledge Base Start
hero(silvana):-
    hero_dps(no). 

hero(guinevere):-
    hero_dps(yes),
    physical_atk(no).

hero(leomord):-
    hero_dps(yes),
    physical_atk(yes),
    hero_tebal(yes).

hero(yss):-
    hero_dps(yes),
    physical_atk(yes),
    hero_tebal(no),
    jadi_core(yes).

hero(wanwan):-
    hero_dps(yes),
    physical_atk(yes),
    hero_tebal(no),
    jadi_core(no),
    hero_lincah(yes).

hero(brody):-
    hero_dps(yes),
    physical_atk(yes),
    hero_tebal(no),
    jadi_core(no),
    hero_lincah(no).
% End Rules (Knowledge Base)
 
% Start User Interface
/* Asking the user */
hero_dps(X):- 
    menuask(hero_dps, X, [yes, no]).
physical_atk(X):- 
    menuask(physical_atk, X, [yes, no]).
hero_tebal(X):- 
    menuask(hero_tebal, X, [yes, no]).
jadi_core(X):- 
    menuask(jadi_core, X, [yes, no]).
magical_atk(X):- 
    menuask(magical_atk, X, [yes, no]).
hero_cc(X):- 
    menuask(hero_cc, X, [yes, no]).
hero_lincah(X):- 
    menuask(hero_lincah, X, [yes, no]).
 
/* Menus for user & Remembering the answer*/
menuask(A, V, _):-
    known(yes, A, V),
    write('yes lacak'), nl, % succeed if true
    !.% stop looking
menuask(A, V, _):-
    known(_, A, V), % fail if false
    write('no lacak'), nl,
    !,
    fail.
menuask(A, V, MenuList) :-
    write('Apakah anda suka '), write(A), write('?'), nl,
    write(MenuList), nl,
    read(X),
    check_val(X, A, V, MenuList),
    asserta( known(yes, A, X) ),
    X == V. 
 
/* Check input */
check_val(X, _A, _V, MenuList) :-
    member(X, MenuList),
    !.
check_val(X, A, V, MenuList) :-
    write(X), write(' is not a legal value, try again.'), nl,
    menuask(A, V, MenuList). 
 
/* Member rules */
member(X,[X|_]).
member(X,[_|T]):-member(X,T).
% End User Interface
 
% Start Simple Shell
/* Simple shell */
top_goal(X) :- hero(X). 
 
solve :-
    abolish(known, 3),
    top_goal(X),
    write('Hero yang cocok adalah '), write(X), nl.
solve :-
    write('Belum ada hero yang cocok.'), nl. 
 
/* Command loop */
go :-  
    greeting,
    repeat,
    write('> '),
    read(X),
    do(X),
    X == keluar.
 
greeting :-
    write('Program untuk memilih hero Mobile Legend.'), nl,
    write('Ketik mulai atau keluar.'), nl.
 
/* Running Program */
do(mulai) :-
    solve,
    !. 
 
/* Quit Program */
do(keluar).
do(X) :-
    write(X),
    write('is not a legal command.'), nl,
    fail. 
% End Simple Shell
 
/* handle undefined procedure */
:- unknown(trace, fail).