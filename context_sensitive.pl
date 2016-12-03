utterance(X) :- sentence(X, [ ]).


sentence(Start, End) :-
    nounphrase(Start, Rest, Number),
    verbphrase(Rest, End, Number).


nounphrase([Noun | End], End, Number) :-
    noun(Noun, Number).
nounphrase([Article, Noun | End], End, Number) :-
    noun(Noun, Number), 
    article(Article, Number).
nounphrase([Noun | Rest], End, Number) :-
    noun(Noun, Number),
    prepositionphrase(Rest, End, _).
nounphrase([Article, Noun | Rest], End, Number) :-
    article(Article, Number), 
    noun(Noun, Number),
    prepositionphrase(Rest, End, _).
nounphrase([Article | Rest], End, Number) :-
    article(Article, Number), 
    adjectivephrase(Rest, End, _).
nounphrase([Noun | Rest], End, Number) :-
    noun(Noun, Number), 
    conjunctionphrase(Rest, End, _).
nounphrase([Article, Noun | Rest], End, Number) :-
    article(Article, Number), 
    noun(Noun, Number),
    conjunctionphrase(Rest, End, _). 

verbphrase([Verb | End], End, Number) :-
    verb(Verb, Number).
verbphrase([Verb, Article | Rest], End, Number) :-
    verb(Verb, Number), 
    nounphrase([Article | Rest], End, _).
verbphrase([Verb, Noun | Rest], End, Number) :-
    verb(Verb, Number), 
    nounphrase([Noun | Rest], End, _).
verbphrase([Verb, Preposition | Rest], End, Number) :-
    verb(Verb, Number), 
    prepositionphrase([Preposition | Rest], End, _).
verbphrase([Adverb, Verb | Rest], End, Number) :-
    adverbphrase([Adverb, Verb | Rest], End, _). 
verbphrase([Verb, Adverb | Rest], End, Number) :-
    verb(Verb, Number),
    adverbphrase([Adverb | Rest], End, _).
verbphrase([Verb, Adjective | Rest], End, Number) :-
    verb(Verb, Number),
    adjectivephrase([Adjective | Rest], End, _). 






adjectivephrase([Adjective, Noun | Rest], End, Number) :-
    adjective(Adjective, Number),
    noun(Noun, Number).
adjectivephrase([Adjective | Rest], End, Number) :-
    adjective(Adjective, Number),
    adjectivephrase(Rest, End, _).
adjectivephrase([Adjective | End], End, Number) :-
    adjective(Adjective, Number).
adjectivephrase([Adjective, Conjunction | Rest], End, Number) :-
    adjective(Adjective, Number),
    conjunction(Conjunction, Number),
    adjectivephrase(Rest, End, _).




adverbphrase([Adverb | End], End, Number) :-
    adverb(Adverb, Number).
adverbphrase([Adverb, Verb | Rest], End, Number) :-
    adverb(Adverb, Number),
    verbphrase([Verb | Rest], End, _).
adverbphrase([Adverb | Rest], End, Number) :-
    adverb(Adverb, Number),
    adverbphrase(Rest, End, _).
adverbphrase([Adverb, Conjunction | Rest], End, Number) :-
    adverb(Adverb, Number),
    conjunction(Conjunction, Number),
    adverbphrase(Rest, End, _).



conjunctionphrase([Conjunction | Rest], End, Number) :-
    conjunction(Conjunction, Number),
    sentence(Rest, [ ]).




prepositionphrase([Preposition | Rest], End, Number) :-
    preposition(Preposition, Number),
    nounphrase(Rest, End, _).






article(a, singular).
article(some, plural).
article(the, singular).
article(the, plural).
article(one, singular).
article(many, plural).

verb(tells, singular).
verb(tell, plural).
verb(controls, singular).
verb(control, plural).
verb(scans, singular).
verb(scan, plural).
verb(exists, singular).
verb(exist, plural).
verb(pays, singular).
verb(pay, plural).
verb(is, singular).
verb(are, plural).
verb(receives, singular).
verb(receive, plural).
verb(accepts, singular).
verb(accept, plural).
verb(joins, singular).
verb(join, plural).
verb(loves, singular).
verb(love, plural).
verb(likes, singular).
verb(like, plural).
verb(hates, singular).
verb(hate, plural).
verb(wants, singular).
verb(want, plural).
verb(needs, singular).
verb(need, plural).
verb(eats, singular).
verb(eat, plural).
verb(consumes, singular).
verb(consume, plural).
verb(contemplates, singular).
verb(contemplate, plural).
verb(praises, singular).
verb(praise, plural).
verb(exalts, singular).
verb(exalt, plural).

noun(i, singular).
noun(we, plural).
noun(it, singular).
noun(it, plural).
noun(trump, singular).
noun(wriwenis, singular).
noun(man, singular).
noun(men, plural).
noun(cult, singular).
noun(cult, plural).
noun(name, singular).
noun(names, plural).
noun(knowledge, singular).    
noun(hat, singular).
noun(hats, plural).
noun(helicopter, singular).
noun(helicopters, plural).
noun(alien, singular).
noun(aliens, plural).
noun(human, singular).
noun(humans, plural).
noun(government, singular).
noun(governments, plural).
noun(military, singular).
noun(militaries, plural).
noun(earth, singular).
noun(person, singular).
noun(people, plural).
noun(brain, singular).
noun(brains, plural).
noun(truth, singular).
noun(truths, plural).
noun(company, singular).
noun(companies, plural).
noun(chemtrail, singular).
noun(chemtrails, plural).
noun(cloud, singular).
noun(clouds, plural).
noun(plane, singular).
noun(planes, plural).
noun(insect, singular).
noun(insects, plural).
noun(lizard, singular).
noun(lizards, plural).
noun(illuminati, plural).
noun(wall, singular).
noun(walls, plural).
noun(border, singular).
noun(borders, plural).
noun(immigrant, singular).
noun(immigrants, plural).
noun(mexico, singular).
noun(china, singular).
noun(america, singular).
noun(job, singular).
noun(jobs, plural).
noun(economy, singular).
noun(pizza, singular).
noun(pizzas, plural).
noun(hat, singular). 
noun(hats, plural).
noun(cat, singular).
noun(cats, plural).
noun(dog, singular).
noun(dogs, plural).
noun(robot, singular).
noun(robots, plural).
noun(porch, singular).
noun(porches, plural).
noun(cheese, singular).
noun(cheeses, plural).
noun(pepperoni, singular).
noun(pepperonis, plural).
noun(sausage, singular).
noun(sausages, plural).

adjective(flat, singular).
adjective(round, singular).
adjective(black, singular).
adjective(tinfoil, singular).
adjective(small, singular).
adjective(ice, singular).
adjective(poisonous, singular).
adjective(good, singular).
adjective(nice, singular).
adjective(fantasy, singular).
adjective(fake, singular).
adjective(real, singular).
adjective(reptilian, singular).
adjective(hollow, singular).
adjective(illegal, singular).
adjective(stupid, singular).
adjective(great, singular).
adjective(graceful, singular).
adjective(expensive, singular).
adjective(flat, plural).
adjective(round, plural).
adjective(black, plural).
adjective(tinfoil, plural).
adjective(small, plural).
adjective(ice, plural).
adjective(poisonous, plural).
adjective(good, plural).
adjective(nice, plural).
adjective(fantasy, plural).
adjective(fake, plural).
adjective(real, plural).
adjective(reptilian, plural).
adjective(hollow, plural).
adjective(illegal, plural).
adjective(stupid, plural).
adjective(great, plural).
adjective(graceful, plural).
adjective(expensive, plural).


adverb(wisely, singular).
adverb(terribly, singular).
adverb(eloquently, singular).
adverb(stupidly, singular).
adverb(illegally, singular).
adverb(wisely, plural).
adverb(terribly, plural).
adverb(eloquently, plural).
adverb(stupidly, plural).
adverb(illegally, plural).


preposition(against, singular).
preposition(for, singular).
preposition(before, singular).
preposition(after, singular).
preposition(outside, singular).
preposition(inside, singular).
preposition(with, singular).
preposition(without, singular).
preposition(against, plural).
preposition(for, plural).
preposition(before, plural).
preposition(after, plural).
preposition(outside, plural).
preposition(inside, plural).
preposition(with, plural).
preposition(without, plural).


conjunction(and, plural).
conjunction(and, singular).
