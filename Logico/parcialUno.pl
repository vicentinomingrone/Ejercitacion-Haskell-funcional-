% auto(Marca, Modelo, Año, Km, Tipo de Combustible, Dueño).

auto(ferrari, spider100, datos(2026, 0, nafta), vito).
auto(volkswagen, gol, datos(2023, 12300, nafta), vito).
auto(lamborghini, huracan, datos(2026, 0, nafta), ariel).
auto(mitsubishi, lancer, datos(2023, 20022, electrico), ariel).
auto(chevrolet, taurus, datos(2000, 120000, gas), kevin).
auto(cadillac, zumager, datos(2010, 90000, nafta), frank).

/*
¿Existe algún auto eléctrico?
?- auto(_, _, datos(_, _, electrico), _).
true.
¿Qué autos pertenecen a un dueño específico?
vito.
?- auto(_, Modelo, _, vito).
Modelo= spider100;
Modelo= gol. 
¿Qué dueño tiene un auto de una marca determinada?
marca determinada= ferrari 
?- auto(ferrari, _, _, Dueño).
Dueño= vito.
¿Qué autos tienen más de 100.000 km?
?- auto(Auto, _, datos(_, KM, _), _),  KM > 100000.
Auto= chevrolet.
¿Es cierto que un auto determinado pertenece a cierto dueño?
ferrari -> vito 
auto(ferrari, _, _, vito).
true.
*/

tieneMasKilometrajeQue(Marca1, Modelo1, Marca2, Modelo2):-
    auto(Marca1, Modelo1, datos(_, KM1, _), _),
    auto(Marca2, Modelo2, datos(_, KM2, _), _), 
    (Marca1, Modelo1) \= (Marca2, Modelo2),
    KM1 > KM2. 

autoMuyUsado(Marca, Modelo):-
    auto(Marca, Modelo, datos(_, KM, _), _),
    KM > 100000.

autoMuyUsado(Marca, Modelo):-
    auto(Marca, Modelo, datos(Anio, _, _), _), 
    2026 - Anio > 10.

tieneMasDeUnAuto(Duenio):-
    auto(Marca1, Modelo1, _, Duenio),
    auto(Marca2, Modelo2, _, Duenio),
    (Marca1, Modelo1) \= (Marca2, Modelo2).




autoContaminante(Marca, Modelo):-
    auto(Marca, Modelo, datos(_, _, Combustible), _),
    combustibleContaminante(Combustible).

combustibleContaminante(nafta).
combustibleContaminante(gas).

conoceBidireccional(Persona, OtraPersona):-
    conoce(Persona, OtraPersona).

conoceBidireccional(Persona, OtraPersona):-
    conoce(OtraPersona, Persona).


puedeRecomendarA(Persona, OtraPersona):-
    Persona \= OtraPersona,
    puedeRecomendarA(Persona, OtraPersona, [Persona]).

puedeRecomendarA(Persona, OtraPersona, _):-
    conoceBidireccional(Persona, OtraPersona).

puedeRecomendarA(Persona, OtraPersona, Visitados):-
    conoceBidireccional(Persona, Intermedio),
    not(member(Intermedio, Visitados)),
    puedeRecomendarA(Intermedio, OtraPersona, [Intermedio | Visitados]).