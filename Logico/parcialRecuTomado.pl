% qué se sirvió en cada fecha
asado(fecha(15,9,2011), mixta).
asado(fecha(15,9,2011), mondiola).
asado(fecha(15,9,2011), chinchu).
asado(fecha(22,9,2011), vacio).
asado(fecha(22,9,2011), mixta).
asado(fecha(22,9,2011), waldorf).

leGusta(fer, vacio).
leGusta(pablo, asado).
leGusta(flor, mixta).
leGusta(mati, chori).
leGusta(mati, vacio).
leGusta(mati, waldorf).
leGusta(fer, mondiola).

aEzequielLeGusta(Comida):-
    leGusta(mati, Comida),
    leGusta(flor, Comida).


aMarianaLeGusta(Comida):-
    leGusta(flor, Comida),
    leGusta(_, mondiola).

% en lo de leo no hice nada y explique que no hice nada por universo cerrado, tipo, 
% Como no hay nada que digsa que le gusta la ensalada Waldof,