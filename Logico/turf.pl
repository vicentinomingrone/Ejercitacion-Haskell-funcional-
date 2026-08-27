:- dynamic caballoQueGanoPremioImportante/1.
% jockey(nombre, altura, peso).
jockey(valdivieso, 155, 52).
jockey(leguisamo, 161, 49).
jockey(lezcano, 149, 50).
jockey(baratucci, 153, 55).
jockey(falero, 157, 52).

%caballo(nombre)
caballo(botafogo).
caballo(oldMan).
caballo(energica).
caballo(matBoy).
caballo(yatasto).

prefiere(botafogo, baratucci):-
    caballo(botafogo),
    jockey(baratucci, _, _).

prefiere(botafogo, Jockey):-
    caballo(botafogo),
    jockey(Jockey, _, Peso),
    Peso < 52.

prefiere(oldMan, Nombre):-
    jockey(Nombre, _, _),
    atom_length(Nombre, CantidadLetras),
    CantidadLetras > 7.

prefiere(energica, Jockey):-
    jockey(Jockey, _, _),
    not(prefiere(botafogo, Jockey)).

prefiere(matBoy, Jockey):-
    jockey(Jockey, Altura, _), 
    Altura > 170. 

%Studs

studs(valdivieso, elTute).
studs(falero, elTute).
studs(lezcano, lasHormigas).
studs(baratucci, elCharabon).
studs(leguisamo, elCharabon).

%Ganador(caballo, premio)

ganador(botafogo, granPremioNacional).
ganador(botafogo, granPremioRepublica).

ganador(oldMan, granPremioRepublica).
ganador(oldMan, palermoDeOro).

ganador(matBoy, granPremioCriadores).


caballosBiJockeys(Caballo):-
    prefiere(Caballo, Jockey),
    prefiere(Caballo, OtroJockey),
    Jockey \= OtroJockey.

aborrece(Caballo, Stud):-
    caballo(Caballo),
    studs(_, Stud),
    forall(
        studs(Jockey, Stud),
        not(prefiere(Caballo, Jockey))
    ).

/*
aborrece(Caballo, Stud):-
    caballo(Caballo),
    studs(_, Stud),
    not(prefiereAJockeyDelStud(Caballo, Stud)).
prefiereAJockeyDelStud(Caballo, Stud):-
    studs(Jockey, Stud),
    prefiere(Caballo, Jockey).

*/

jockerPiolin(Jockey):-
    jockey(Jockey, _, _),
    forall(
        caballoGanoPremioImportante(Caballo),
        prefiere(Caballo, Jockey)
    ).
    

caballoGanoPremioImportante(Caballo):-
    ganador(Caballo, Premio),
    premioImportante(Premio).

premioImportante(granPremioNacional).
premioImportante(granPremioRepublica).

ganaApuesta(ganador(Caballo),[Caballo | _]).

% caso A de apuesta segundo

ganaApuesta(segundo(Caballo), [Caballo | _]).
% caso B de apuesta segundo
ganaApuesta(segundo(Caballo), [_, Caballo| _]).

%Apuesta Exacta

ganaApuesta(exacta(Caballo1, Caballo2), [Caballo1, Caballo2 | _]). 

ganaApuesta(imperfecta(Caballo1, Caballo2), [Caballo1, Caballo2 | _]).
ganaApuesta(imperfecta(Caballo2, Caballo1), [Caballo2, Caballo1 | _]).

crin(botafogo, tordo).
crin(oldMan, alazan).
crin(energica, ratonero).
crin(matBoy, palomino).
crin(yatasto, pinto).

colorDeCrin(tordo, negro).

colorDeCrin(alazan, marron).

colorDeCrin(ratonero, gris).
colorDeCrin(ratonero, negro).

colorDeCrin(palomino, marron).
colorDeCrin(palomino, blanco).

colorDeCrin(pinto, blanco).
colorDeCrin(pinto, marron).

caballoTieneColor(Caballo, Color):-
    crin(Caballo, TipoCrin),
    colorDeCrin(TipoCrin, Color).

caballosDisponiblesPorColor(Color, Caballos):-
    findall(
        Caballo,
        caballoTieneColor(Caballo, Color),
        Caballos
    ).

puedeComprarCaballosDeColor(Color, CaballosElegidos):-
    caballosDisponiblesPorColor(Color, CaballosDisponibles),
    subconjuntoNoVacio(CaballosDisponibles, CaballosElegidos).

subconjuntoNoVacio(Lista, Subconjunto):-
    subconjunto(Lista, Subconjunto),
    Subconjunto \= [].

subconjunto([], []).

subconjunto([Caballo | Caballos], [Caballo | Subconjunto]):-
    subconjunto(Caballos, Subconjunto).

subconjunto([_ | Caballos], Subconjunto):-
    subconjunto(Caballos, Subconjunto).