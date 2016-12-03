utterance(Prob, X) :- sentence(Prob, X, [ ]).

sentence(Prob, Start, End) :-
    nounphrase(P1, Start, Rest),
    verbphrase(P2, Rest, End),
    pr(r1, P), 
    Prob is P*P1*P2.


nounphrase(Prob, [Noun | End], End) :-
    noun(P1, Noun), 
    pr(n1, P), 
    Prob is P*P1.
nounphrase(Prob, [Article, Noun | End], End) :-
    article(P1, Article), 
    noun(P2, Noun), 
    pr(n2, P),
    Prob is P*P1*P2.
nounphrase(Prob, [Noun | Rest], End) :-
    noun(P1, Noun),
    prepositionphrase(P2, Rest, End),  
    pr(n3, P),
    Prob is P*P1*P2.
nounphrase(Prob, [Article, Noun | Rest], End) :-
    article(P1, Article), 
    noun(P2, Noun), 
    pr(n4, P),
    prepositionphrase(P3, Rest, End),
    Prob is P*P1*P2*P3.
nounphrase(Prob, [Adjective, Noun | Rest], End) :-
    adjectivephrase(P1, [Adjective, Noun | Rest], End), 
    pr(n8, P), 
    Prob is P*P1.
nounphrase(Prob, [Article | Rest], End) :-
    article(P1, Article), 
    adjectivephrase(P2, Rest, End), 
    pr(n5, P),
    Prob is P*P1*P2.
nounphrase(Prob, [Noun | Rest], End) :-
    noun(P1, Noun), 
    conjunctionphrase(P2, Rest, End),
    pr(n6, P), 
    Prob is P*P1*P2.
nounphrase(Prob, [Article, Noun | Rest], End) :-
    article(P1, Article), 
    noun(P2, Noun),
    conjunctionphrase(P3, Rest, End), 
    pr(n7, P),
    Prob is P*P1*P2*P3.

verbphrase(Prob, [Verb | End], End) :-
    verb(P1, Verb), 
    pr(v1, P), 
    Prob is P*P1.
verbphrase(Prob, [Verb, Noun | Rest], End) :-
    verb(P1, Verb),
    nounphrase(P2, [Noun | Rest], End), 
    pr(v2, P),
    Prob is P*P1*P2.
verbphrase(Prob, [Verb, Article | Rest], End) :-
    verb(P1, Verb),
    nounphrase(P2, [Article | Rest], End), 
    pr(v2, P),
    Prob is P*P1*P2.
verbphrase(Prob, [Verb, Preposition | Rest], End) :-
    verb(P1, Verb),
    prepositionphrase(P2, [Preposition | Rest], End), 
    pr(v3, P),
    Prob is P*P1*P2.
verbphrase(Prob, [Adverb, Verb | Rest], End) :-
    adverbphrase(P1, [Adverb, Verb | Rest], End), 
    pr(v4, P),
    Prob is P*P1.
verbphrase(Prob, [Verb, Adverb | Rest], End) :-
    verb(P1, Verb),
    adverbphrase(P2, [Adverb | Rest], End), 
    pr(v5, P),
    Prob is P*P1*P2.
verbphrase(Prob, [Verb, Adjective | Rest], End) :-
    verb(P1, Verb),
    adjectivephrase(P2, [Adjective | Rest], End), 
    pr(v6, P),
    Prob is P*P1*P2.





/** The small cat eats: utterance(Prob, [the, small, cat, eats]).*/
adjectivephrase(Prob, [Adjective, Noun | Rest], End) :-
    adjective(P1, Adjective),
    noun(P2, Noun),    
    pr(adj2, P),
    Prob is P*P1*P2.
/** [small, big, large, ... ] */
adjectivephrase(Prob, [Adjective | Rest], End) :-
    adjective(P1, Adjective),
    adjectivephrase(P2, Rest, End),
    pr(adj3, P),
    Prob is P*P1*P2.
/** (Works) utterance(Prob, [the, cat, is, small]). */
adjectivephrase(Prob, [Adjective | End], End) :-
    adjective(P1, Adjective),
    pr(adj2, P),
    Prob is P*P1.
/** [small, and big]*/
adjectivephrase(Prob, [Adjective, Conjunction | Rest], End) :-
    adjective(P1, Adjective),
    conjunction(P2, Conjunction),
    adjectivephrase(P3, Rest, End),
    pr(adj4, P),
    Prob is P*P1*P2*P3.


/** utterance(Prob, [the, cat, eats, eloquently]). */
adverbphrase(Prob, [Adverb | End], End) :-
    adverb(P1, Adverb),
    pr(adv1, P),
    Prob is P*P1.
/** utterance(Prob, [the, cat, illegally, eats, eloquently]). */
adverbphrase(Prob, [Adverb, Verb | Rest], End) :-
    adverb(P1, Adverb),
    verbphrase(P2, [Verb | Rest], End),
    pr(adv2, P),
    Prob is P*P1*P2.

/** [eloquently, eloquently, ... ] */
adverbphrase(Prob, [Adverb | Rest], End) :-
    adverb(P1, Adverb),
    adverbphrase(P2, Rest, End),
    pr(adv3, P),
    Prob is P*P1*P2.
/** [eloquently and eloquently, ... ] */
adverbphrase(Prob, [Adverb, Conjunction | Rest], End) :-
    adverb(P1, Adverb),
    conjunction(P2, Conjunction),
    adverbphrase(P3, Rest, End),
    pr(adv4, P),
    Prob is P*P1*P2*P3.




conjunctionphrase(Prob, [Conjunction | Rest], End) :-
    conjunction(P1, Conjunction),
    sentence(P2, Rest, [ ]),
    pr(c1, P),
    Prob is P*P1*P2.


prepositionphrase(Prob, [Preposition | Rest], End) :-
    preposition(P1, Preposition),
    nounphrase(P2, Rest, End), 
    pr(p1, P),
    Prob is P*P1*P2.


pr(r1, 1.0).

pr(n1, 0.05).  /* probability that a nounphrase contains just a noun and ends */
pr(n2, 0.15).  /* probability that a nounphrase contains an article and a noun and ends*/
pr(n3, 0.15).  /* probability that a nounphrase contains just a noun and is followed by a preposition */
pr(n4, 0.25).  /* probability that a nounphrase contains an article and noun and is followed by a preposition */
pr(n5, 0.10).  /* probability that a nounphrase contains an article and as adjective phrase */
pr(n6, 0.10).  /* probability that a nounphrase contains a noun and then a conjunctionphrase */
pr(n7, 0.10).  /* probability that a nounphrase contains an article, a noun and then a conjunctionphrase */
pr(n8, 0.10).  /* probability that a nounphrase contains an adjective and then a noun */

pr(v1, 0.2).  /* probability that a verb ends the sentence */
pr(v2, 0.18).  /* probability that a verb is followed by a nounphrase */
pr(v3, 0.18).  /* probability that a verb is followed by a prepositionphrase*/
pr(v4, 0.18).  /* probability that an adverb is followed by a verb */
pr(v5, 0.18).  /* probability that a verb is followed by an adverb phrase */
pr(v6, 0.18).  /* probability that a verb is followed by an adjective phrase */

pr(adj1, 0.25). /* probability that an adjective phrase is followed by a verb phrase */
pr(adj2, 0.25). /* probability that an adjective phrase contains just an ajective and ends */
pr(adj3, 0.25). /* probability that an adjective phrase contains an ajective and an ajectivephrase */
pr(adj4, 0.25). /* probability that an adjective phrase contains an ajective, an and, and an ajectivephrase */

pr(adv1, 0.25). /* probability that an adverb phrase contains just an adverb and ends */
pr(adv2, 0.25). /* probability that an adverb phrase is followed by a verb phrase */
pr(adv3, 0.25). /* probability that an adverb phrase contains an adverb and an adverbphrase */
pr(adv4, 0.25). /* probability that an adverb phrase contains an adverb, an and, and an adverbphrase */

pr(c1, 1.0).  /* probability a conjection */

pr(p1, 1.0).  /* probability a preposition is followed by a noun phrase */


article(0.28, a).
article(0.11, some).
article(0.31, the).
article(0.14, one).
article(0.16, many).

verb(0.0463, tells).
verb(0.0463, tell).
verb(0.0163, controls).
verb(0.0063, control).
verb(0.0063, scans).
verb(0.0063, scan).
verb(0.0063, exists).
verb(0.0063, exist).
verb(0.0063, pays).
verb(0.0363, pay).
verb(0.0469, is).
verb(0.0463, are).
verb(0.0163, receives).
verb(0.0163, receive).
verb(0.0163, accepts).
verb(0.0163, accept).
verb(0.0163, joins).
verb(0.0463, join).
verb(0.0463, loves).
verb(0.0363, love).
verb(0.0463, likes).
verb(0.0463, like).
verb(0.0363, hates).
verb(0.0363, hate).
verb(0.0263, wants).
verb(0.0363, want).
verb(0.0263, needs).
verb(0.0263, need).
verb(0.0263, eats).
verb(0.0363, eat).
verb(0.0163, consumes).
verb(0.0363, consume).
verb(0.0163, contemplates).
verb(0.0263, contemplate).
verb(0.0363, praises).
verb(0.0263, praise).
verb(0.0063, exalts).
verb(0.0063, exalt).

noun(0.08  , i).
noun(0.025  , we).
noun(0.04  , it).
noun(0.025  , trump).
noun(0.0075  , wriwenis).
noun(0.02  , man).
noun(0.02  , men).
noun(0.012  , cult).
noun(0.012  , name).
noun(0.012  , names).
noun(0.012  , knowledge).   
noun(0.02  , helicopter).
noun(0.012  , helicopters).
noun(0.01  , alien).
noun(0.01  , aliens).
noun(0.012  , human).
noun(0.012  , humans).
noun(0.02  , government).
noun(0.012  , governments).
noun(0.02  , military).
noun(0.0125  , militaries).
noun(0.0125  , earth).
noun(0.012  , person).
noun(0.012  , people).
noun(0.0125  , brain).
noun(0.012  , brains).
noun(0.012  , truth).
noun(0.012  , truths).
noun(0.0125  , company).
noun(0.0125  , companies).
noun(0.0075  , chemtrail).
noun(0.0075  , chemtrails).
noun(0.012  , cloud).
noun(0.01  , clouds).
noun(0.02  , plane).
noun(0.01  , planes).
noun(0.0075  , insect).
noun(0.0075  , insects).
noun(0.0075  , lizard).
noun(0.0075  , lizards).
noun(0.0075  , illuminati).
noun(0.04  , wall).
noun(0.0125  , walls).
noun(0.02  , border).
noun(0.0125  , borders).
noun(0.0125  , immigrant).
noun(0.02  , immigrants).
noun(0.025 , mexico).
noun(0.02  , china).
noun(0.025  , america).
noun(0.0125  , job).
noun(0.02  , jobs).
noun(0.02  , economy).
noun(0.012  , pizza).
noun(0.0075  , pizzas).
noun(0.02  , hat). 
noun(0.0125  , hats).
noun(0.0075  , cat).
noun(0.0075  , cats).
noun(0.0075  , dog).
noun(0.01  , dogs).
noun(0.0075  , robot).
noun(0.0075  , robots).
noun(0.0075  , porch).
noun(0.0075  , porches).
noun(0.0075  , cheese).
noun(0.0075  , cheeses).
noun(0.0075  , pepperoni).
noun(0.0075  , pepperonis).
noun(0.0075  , sausage).
noun(0.0075  , sausages).

adjective(0.063, flat).
adjective(0.033, round).
adjective(0.023, black).
adjective(0.033, tinfoil).
adjective(0.053, small).
adjective(0.033, ice).
adjective(0.073, poisonous).
adjective(0.083, good).
adjective(0.063, nice).
adjective(0.046, fantasy).
adjective(0.053, fake).
adjective(0.083, real).
adjective(0.023, reptilian).
adjective(0.043, hollow).
adjective(0.073, illegal).
adjective(0.043, stupid).
adjective(0.073, great).
adjective(0.043, graceful).
adjective(0.063, expensive).

adverb(0.14, wisely).
adverb(0.28, terribly).
adverb(0.11, eloquently).
adverb(0.16, stupidly).
adverb(0.31, illegally).

preposition(0.15 , against).
preposition(0.15 , for).
preposition(0.1 , before).
preposition(0.1 , after).
preposition(0.1 , outside).
preposition(0.1 , inside).
preposition(0.2 , with).
preposition(0.1 , without).


conjunction(1.0, and).
