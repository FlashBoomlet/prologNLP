utterance(X) :- sentence(X, [ ]).
sentence(Start, End) :-
    nounphrase(Start, Rest, Number),
    verbphrase(Rest, End, Number).
nounphrase([Noun | End], End, Number) :-
    noun(Noun, Number).
nounphrase([Article, Noun | End], End, Number) :-
    noun(Noun, Number), article(Article, Number).
nounphrase([Noun | Rest], End, Number) :-
    noun(Noun, Number),
    prepositionphrase(Rest, End, _).
nounphrase([Article, Noun | Rest], End, Number) :-
    article(Article, Number), noun(Noun, Number),
    prepositionphrase(Rest, End, _).
verbphrase([Verb | End], End, Number) :-
    verb(Verb, Number).
verbphrase([Verb, Article | Rest], End, Number) :-
    verb(Verb, Number), nounphrase([Article | Rest], End, _).
verbphrase([Verb, Noun | Rest], End, Number) :-
    verb(Verb, Number), nounphrase([Noun | Rest], End, _).
verbphrase([Verb, Preposition | Rest], End, Number) :-
    verb(Verb, Number), prepositionphrase([Preposition | Rest], End, _).
prepositionphrase([Preposition | Rest], End, Number) :-
    preposition(Preposition, Number),
    nounphrase(Rest, End, _).

article(a, singular).
article(these, plural).
article(the, singular).
article(the, plural).
noun(man, singular).
noun(men, plural).
noun(dog, singular).
noun(dogs, plural).
verb(likes, singular).
verb(like, plural).
verb(bites, singular).
verb(bite, plural).
preposition(with, _).
