% representa(MC, Pais).
representa(chuty, espana).
representa(gazir, espana).
representa(rapder, mexico).
representa(elMenor, chile).
representa(teorema, chile).
representa(vallesT, colombia).
representa(exe, argentina).
representa(katakrist, peru).

% nivelDe(MC, Skill, Nivel).
nivelDe(chuty, punchlines, 95).
nivelDe(chuty, tecnica, 90).
nivelDe(gazir, tecnica, 98).
nivelDe(gazir, flow, 91).
nivelDe(gazir, punchlines, 88).
nivelDe(rapder, escena, 93).
nivelDe(rapder, punchlines, 85).
nivelDe(elMenor, punchlines, 97).
nivelDe(elMenor, dobleTempo, 93).
nivelDe(teorema, flow, 90).
nivelDe(teorema, escena, 90).
nivelDe(vallesT, flow, 92).
nivelDe(vallesT, escena, 88).
nivelDe(exe, tecnica, 91).
nivelDe(katakrist, escena, 80).
nivelDe(katakrist, dobleTempo, 75).

/*
Parte A: 
¿Existe algún MC que represente a Chile?
representa(_, chile).
true.
¿Qué país representa Gazir?
representa(gazir, Cual).
Cual = espana. 
¿Quiénes representan a España?
representa(Quienes, espana).
Quienes = gazir; 
Quienes = chuty;
¿Qué skills tiene Chuty?
nivelDe(chuty, Skills, _).
Skills = tecnica;
Skills = punchlines. 

*/

brillaEn(chuty,punchlines).
brillaEn(chuty,tecnica).
brillaEn(gazir,punchlines).
brillaEn(gazir,flow).

esVersatil(MC):-
    findall(Skill, brillaEn(MC, Skill), Skills),
    length(Skills, Cantidad),
    Cantidad > 1.

/*
El código resuelve el problema planteado.
Si resuleve el problema, lo que pasa aca es que justamente compara contra una lista de Skills.
El predicado esVersatil/1 es inversible.
No es inversible el predicado, ya que le faltaria un predicado que ligue antes del findall el Mc
como por ejmeplo el predicado de representa(Mc, _).
El predicado esVersatil/1 tiene problemas de declaratividad.
si tiene problemas de declaratividad ya que no se entiene tanto lo que quiere demostrar
Codificar una solución que resuelva los problemas que se encuentren.
Esta de abajo es una solucion mejor yo creo, ya que no necesito meterme en una lista ni nada. 
*/

esVersxatil(MC):-
    representa(MC, _),
    brillaEn(MC, Skill),
    brillaEn(MC, OtraSkill),
    Skill \= OtraSkill. 

% Parte C 

% batalla(Ganador, Perdedor, Resultado).
batalla(chuty, exe, puntaje(10, 9, 9)).
batalla(gazir, elMenor, replica(2)).
batalla(teorema, katakrist, replica(1)).
batalla(chuty, teorema, puntaje(9, 10, 10)).
batalla(gazir, rapder, replica(3)).
batalla(chuty, gazir, replica(2)).
batalla(rapder, vallesT, abandono).

aplausosDelGanador(Ganador, Aplausos):-
    batalla(Ganador, _, puntaje(P1, P2, P3)),
    Aplausos is P1 + P2 + P3.

aplausosDelGanador(Ganador, Aplausos):-
    batalla(Ganador, _, replica(Cantidad)),
    Aplausos is Cantidad * 10.

aplausosDelGanador(Ganador, 100):-
    batalla(Ganador, _, abandono).


/*
Es sencillo agregar un nuevo tipo de resultado sin modificar aplausosDelGanador/2.
No es sencillo agregar un nuvo tipo ya que deberias crear otra regla. 
Hay conceptos del dominio que no están representados en el código.
Se repite lógica.
Se repite logica, si mas que nada en el tema de deteriminar cuanto ganaeria
Escribir una nueva solución que resuelva los problemas detectados.

*/

aplausosDelGanador(Ganador, Aplausos):-
    batalla(Ganador, _, Tipo),
    segunGane(Tipo, Multiplicador),
    Aplausos is Multiplicador. 

segunGane(puntaje(P1, P2, P3), P1 + P2 + P3).
segunGane(replica(Cantidad), Cantidad * 10).
segunGane(abandono, 100).

% Parte D 

esElMejorEn1(MC, Skill):-
    nivelDe(MC, Skill, Nivel),
    findall(
        Otro,
        (
            nivelDe(Otro, Skill, OtroNivel),
            OtroNivel > Nivel
        ),
        Mejores
    ),
    length(Mejores, 0).

esElMejorEn2(MC, Skill):-
    nivelDe(MC, Skill, Nivel),
    forall(
        nivelDe(_, Skill, OtroNivel),
        Nivel >= OtroNivel
    ).

/*
¿Ambas soluciones funcionan igual?
Justificar conceptualmente usando ejemplos de consultas individuales 
y existenciales con sus respuestas.
No ambas soluciones no funcionan igual, una funciona cerando una lista y comprando si esa lista esta 
llena o vacia y la otra simplemente comprar con todos los Mc que hay y si no encuentra otro con 
mejor o igual nivel te da true.

¿Cuál es la mejor opción? 
O, en caso de que ninguna sea ideal, codificar una opción superadora 
y justificar el motivo.
La primera de crear una lista para mi es la mejor ya que compra el mismo Mc con todos de la lista

Parte E 
*/

equipoDeExhibicion(Equipo):-
    findall(Integrante, representa(Integrante, _), Integrantes),
    equipoPosible(Integrantes, Equipo),
    equipoValido(Equipo).

equipoPosible([], []).

equipoPosible([Integrante | Resto], [Integrante | Equipo]):-
    equipoPosible(Resto, Equipo).

equipoPosible([_ | Resto], Equipo):-
    equipoPosible(Resto, Equipo).

equipoValido(Equipo):-
    length(Equipo, 4),
    ganaronBatalla(Equipo),
    esMulticultural(Equipo).

ganaronBatalla(Equipo):-
    forall(
        member(Integrante, Equipo),
        batalla(Integrante, _, _)
    ).

esMulticultural(Equipo):- 
    member(Integrante, Equipo),
    esDeRegion(Integrante, america),
    member(OtroIntegrante, Equipo),
    esDeRegion(OtroIntegrante, europa),
    Integrante \= OtroIntegrante.



regionPais(espana, europa).
regionPais(mexico, america).
regionPais(chile, america).
regionPais(colombia, america).
regionPais(argentina, america).
regionPais(peru, america).

esDeRegion(MC, Region):-
    representa(MC, Pais),
    regionPais(Pais, Region).