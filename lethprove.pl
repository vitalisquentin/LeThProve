/*Invertible calculus*/

/*Check on invertible rules to avoid infinite loops*/
check(A):-atom(A).
check([]).
check([A|GammaTail]):-not(member(A,GammaTail)),check_sup(A),check(GammaTail).
check_sup(A):-atom(A),!.
check_sup(A):-compound(A),not(is_list(A)),functor(A,<<,_),arg(1,A,X),!,check_spec(X).
check_sup(A):-compound(A),not(is_list(A)).
check_sup(A):-compound(A),is_list(A),check(A).
check_spec(X):-atom(X).
check_spec(L):-flatten(L,L1),check(L1).
/*Verif for axini to discriminate []*/
verif(P):-atom(P),not(is_list(P)),!.
verif(P):-compound(P),!.
/*Extract for extension A*/
extract([],[]).
extract([A<B|Tail],[A<B|ResTail]):-!,extract(Tail,ResTail).
extract([Sigma<<A|Tail],[Sigma<<A|ResTail]):-!,extract(Tail,ResTail).
extract([_|Tail],ResTail):-extract(Tail,ResTail).


/*Flatten all*/
prove(Gamma,Delta,X,List):-flatten(Gamma,GammaFlat),flatten(Delta,DeltaFlat),!,prove2(GammaFlat,DeltaFlat,X,List).
/*Rule for not having loop Jump,N*/
prove2([top],[bot],_,_):-!,fail.
/*Loop detect*/
prove2(Gamma,Delta,_,L):-member((Gamma,Delta),L),!,fail.


/* Axioms */
/*Bot Left*/
prove2(Gamma,_,axbot,_):-member(bot,Gamma),!.
/*Top Right*/
prove2(_,Delta,axtop,_):-member(top,Delta),!.
/*Init*/
prove2(Gamma,Delta,axini,_):-member(P,Gamma),verif(P),member(P,Delta),!.


/*Rules w/ one premises*/
/*->R*/
prove2(Gamma,Delta,impR(Sub),L):-select(A -> B, Delta, Delta1),!,prove([A,Gamma],[B,Delta1],Sub,[(Gamma,Delta)|L]).
/*Comparative plausibility R, << = triangle (see LaTex code for \lhd)*/
prove2(Gamma,Delta,plR(Sub),L):-select(A < B,Delta,Delta1),!,prove(Gamma,[A <<  B,Delta1],Sub,[(Gamma,Delta)|L]).
/*Jump, Sigma->List*/
prove2(Gamma,Delta,jump(Sub),L):-member(Sigma << A,Delta),prove([A],[Sigma],Sub,[(Gamma,Delta)|L]).


/* Rules w/ two premises */
/*->L*/
prove2(Gamma,Delta,impL(Sub1,Sub2),L):-select(A -> B,Gamma,Gamma1),!,prove([B,Gamma1],Delta,Sub1,[(Gamma,Delta)|L]),prove(Gamma1,[A,Delta],Sub2,[(Gamma,Delta)|L]).


/* **********************check************************** */
/*We check here to do it one time per round and save compilation time*/
prove2(Gamma,_,_,_):-not(check(Gamma)),!,fail.
prove2(_,Delta,_,_):-not(check(Delta)),!,fail.
/* ***************************************************** */


/*Comparative plausibility L*/
prove2(Gamma,Delta,plL(Sub1,Sub2),L):-member(A < B,Gamma),select(Sigma << C,Delta,Delta1),prove(Gamma,[[B,Sigma] << C,Delta1],Sub1,[(Gamma,Delta)|L]),prove(Gamma,[Sigma << A,Sigma << C,Delta1],Sub2,[(Gamma,Delta)|L]).
/*com*/
prove2(Gamma,Delta,com(Sub1,Sub2),L):-select(Sigma1 << A,Delta,Delta1),select(Sigma2 << B,Delta1,Delta2),prove(Gamma,[[Sigma1,Sigma2] << A,Sigma2 << B,Delta2],Sub1,[(Gamma,Delta)|L]),prove(Gamma,[[Sigma1,Sigma2] << B,Sigma1 << A,Delta2],Sub2,[(Gamma,Delta)|L]).

/*Counterfactuals*/
/*prove2(Gamma,Delta,countL(Sub1,Sub2)):-select(A =< B,Gamma,Gamma1),!,prove([bot<a,Gamma1],Delta,Sub1),prove(Gamma1,[((A->B)->bot)<<A,Delta],Sub2).*/
/*prove2(Gamma,Delta,countR(Sub)):-select(A =< B,Delta,Delta1),!,prove([((A->B)->bot)<A,Gamma],[bot<<A,Delta1],Sub).*/



/* Extensions */
/*N*/
/*prove2(Gamma,Delta,n(Sub),L):-prove(Gamma,[bot << top,Delta],Sub,[(Gamma,Delta)|L]).*/
/*T*/
/*prove2(Gamma,Delta,t(Sub1,Sub2),L):-member(A < B,Gamma),!,prove(Gamma,[B,Delta],Sub1,[(Gamma,Delta)|L]),prove(Gamma,[bot << A,Delta],Sub2,[(Gamma,Delta)|L]).*/
/*W*/
/*prove2(Gamma,Delta,w(Sub),L):-member(Sigma << _,Delta),prove(Gamma,[Sigma,Delta],Sub,[(Gamma,Delta)|L]).*/
/*C*/
/*prove2(Gamma,Delta,c(Sub1,Sub2),L):-member(C < D,Gamma),!,prove([C,Gamma],Delta,Sub1,[(Gamma,Delta)|L]),prove(Gamma,[D,Delta],Sub2,[(Gamma,Delta)|L]).*/
/*A*/
/*prove2(Gamma,Delta,a(Sub),L):-select(Sigma << B,Delta,Delta1),extract(Gamma,GammaRestricted),extract(Delta1,DeltaRestricted),prove([B,GammaRestricted],[Sigma << B,Sigma,DeltaRestricted],Sub,[(Gamma,Delta)|L]).*/


/*p -> q équivalent à non(p)Vq ou non((p^non(q))*/
