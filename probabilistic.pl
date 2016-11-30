utterance(Prob, X) :- sentence(Prob, X, [ ]).
sentence(Prob, Start, End) :-
    nounphrase(P1, Start, Rest),
    verbphrase(P2, Rest, End),
    pr(r1, P), Prob is P*P1*P2.
nounphrase(Prob, [Noun | End], End) :-
    noun(P1, Noun), pr(r2, P), Prob is P*P1.
nounphrase(Prob, [Article, Noun | End], End) :-
    article(P1, Article), noun(P2, Noun), pr(r3, P),
    Prob is P*P1*P2.
nounphrase(Prob, [Noun | Rest], End) :-
    noun(P1, Noun),
    prepositionphrase(P2, Rest, End),  pr(r6, P),
    Prob is P*P1*P2.
nounphrase(Prob, [Article, Noun | Rest], End) :-
    article(P1, Article), noun(P2, Noun), pr(r7, P),
    prepositionphrase(P3, Rest, End),
    Prob is P*P1*P2*P3.
verbphrase(Prob, [Verb | End], End) :-
    verb(P1, Verb), pr(r4, P), Prob is P*P1.
verbphrase(Prob, [Verb | Rest], End) :-
    verb(P1, Verb),
    nounphrase(P2, Rest, End), pr(r5, P),
    Prob is P*P1*P2.
verbphrase(Prob, [Verb, Article | Rest], End) :-
    verb(P1, Verb),
    nounphrase(P2, [Article | Rest], End), pr(r5, P),
    Prob is P*P1*P2.
verbphrase(Prob, [Verb, Preposition | Rest], End) :-
    verb(P1, Verb),
    prepositionphrase(P2, [Preposition | Rest], End), pr(r5, P),
    Prob is P*P1*P2.
verbphrase([Verb, Noun | Rest], End, Number) :-
    verb(Verb, Number), nounphrase([Noun | Rest], End, _).
verbphrase([Verb, Preposition | Rest], End, Number) :-
    verb(Verb, Number), prepositionphrase([Preposition | Rest], End, _).


prepositionphrase(Prob, [Preposition | Rest], End) :-
    preposition(P1, Preposition),
    nounphrase(P2, Rest, End), pr(r8, P),
    Prob is P*P1*P2.

pr(r1, 1.0).
pr(r2, 0.15).  /* probability that a nounphrase contains just a noun and ends */
pr(r3, 0.35).  /* probability that a nounphrase contains an article and a noun and ends*/
pr(r4, 0.2).  /* probability that a verb ends the sentence */
pr(r5, 0.6).  /* probability that a verb is followed by a nounphrase */
pr(r6, 0.15).  /* probability that a nounphrase contains just a noun and is followed by a preposition */
pr(r7, 0.35).  /* probability that a nounphrase contains an article and noun and is followed by a preposition */
pr(r8, 1.0).  /* probability a preposition is followed by a noun phrase */
pr(r9, 0.2).  /* propbability that a verb is followed by a preposition */
article(0.25, a).
article(0.75, the).
noun(0.65, man).
noun(0.35, dog).
verb(0.9, likes).
verb(0.1, bites).
preposition(0.5, with).
