docente(ana).
docente(bruno).
docente(carla).
docente(diego).

ayudante(ana, lola).
ayudante(ana, tomi).
ayudante(ana, mica).
ayudante(ana, ema).
ayudante(ana, nico).
ayudante(ana, juli).
ayudante(ana, agus).
ayudante(ana, rami).
ayudante(ana, vale).
ayudante(ana, ciro).
ayudante(ana, sofi).

ayudante(bruno, mica).
ayudante(carla, tomi).

solitario(Profe) :- 
    docente(Profe),
    not(ayudante(Profe, _)).  

compartido(Ayudante) :- 
    ayudante(Profe1, Ayudante),
    ayudante(Profe2, Ayudante),
    Profe1 \= Profe2.

celoso(Docente) :-
    docente(Docente),
    forall(ayudante(Docente,Ayudante),
    not(compartido(Ayudante))).

-- Punto 5 

tieneEquipoGrande(Docente):-
    docente(Docente),
    findall(Ayudante, ayudante(Docente, Ayudante), ListaDeAyudantes),
    length(ListaDeAyudantes, Cantidad),
    Cantidad > 8.

persona(Persona) :- 
    docente(Persona).

persona(Persona):-
    ayudante(_, Persona).

dia(lunes).
dia(martes).
dia(miercoles).
dia(jueves).
dia(viernes).
dia(sabado).
dia(domingo).

diaLaboral(lunes).
diaLaboral(martes).
diaLaboral(miercoles).
diaLaboral(jueves).
diaLaboral(viernes).

tieneOtroTrabajo(tomi).
tieneOtroTrabajo(sofi).
tieneOtroTrabajo(juli).

noPuede(bruno, martes).
noPuede(carla, sabado).


estaDisponible(Persona, Dia):-
    persona(Persona),
    dia(Dia),
    not(noEstaDisponible(Persona, Dia)).

noEstaDisponible(Persona, Dia):-
    tieneOtroTrabajo(Persona),
    diaLaboral(Dia).

noEstaDisponible(Persona, Dia):-
    noPuede(Persona, Dia).