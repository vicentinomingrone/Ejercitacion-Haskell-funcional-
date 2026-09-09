% computadora(Codigo, Marca, Tipo, Anio, Duenio).
computadora(pc001, lenovo, notebook, 2021, vicentino).
computadora(pc002, hp, escritorio, 2018, martina).
computadora(pc003, dell, notebook, 2015, lucas).
computadora(pc004, apple, notebook, 2023, sofia).
computadora(pc005, acer, escritorio, 2012, tomas).
computadora(pc006, asus, gamer, 2020, camila).
computadora(pc007, bangho, escritorio, 2017, juan).

% tecnico(Nombre, Especialidad, Experiencia).
tecnico(raul, hardware, 12).
tecnico(diego, software, 7).
tecnico(marcos, redes, 5).
tecnico(oscar, seguridad, 15).
tecnico(leo, hardware, 3).
tecnico(gustavo, datos, 20).

% falla(CodigoComputadora, TipoFalla, Gravedad).
falla(pc001, disco, media).
falla(pc001, sistemaOperativo, leve).
falla(pc002, red, media).
falla(pc003, disco, grave).
falla(pc004, seguridad, grave).
falla(pc005, fuente, grave).
falla(pc006, temperatura, media).
falla(pc006, placaVideo, grave).
falla(pc007, red, leve).

% costoBase(TipoFalla, Costo).
costoBase(disco, 120000).
costoBase(sistemaOperativo, 50000).
costoBase(red, 70000).
costoBase(seguridad, 180000).
costoBase(fuente, 90000).
costoBase(temperatura, 60000).
costoBase(placaVideo, 250000).

% backupRealizado(CodigoComputadora, Estado).
backupRealizado(pc001, completo).
backupRealizado(pc002, incompleto).
backupRealizado(pc003, inexistente).
backupRealizado(pc004, completo).
backupRealizado(pc006, incompleto).

/* Parte A
1- computadora(_, _, notebook, _, _).
true
2- computadora(pc004, _, _, _, Quien).
Quien = Sofia. 
3- falla(Cual, red, _).
Cual= pc002;
Cual= pc007.
4- tecnico(gustavo, Cual, _).
Cual= datos. 

Parte B

computadoraCritica(Codigo):-
    falla(Codigo, _, grave).

computadoraCritica(Codigo):-
    backupRealizado(Codigo, Estado),
    Estado \= completo.

1- el codigo resuelve bien el probelma, pero no lo resuelve correctamente ya que pude haber alguna computaora que no tenga bckup en nuiestra base y no la tomaria como computadora critica.
2- no es inversible, ya que le faltaria ligarse con computadora antes, para que sean solo las computadoras que tengamops en nuestra BC (Base de Conocimiento)
3- por ejemplo si creariamos una computadora de pepe, no la tomaria como critica ya que ni siquera esta en Backup, ni en falla grave. => 
computadora(pc009, lenovo, notebook, 2021, pepe).
falla(pc009, disco, media).

esta no la agarraria, entonces cuando nostros hariamos la consulta 
computadoraCritica(pc009). 
False
daria false ya que no tiene ningun Backup. 

el 4 lo dejo aca abajo: 

*/

computadorasCriticas(Computadora):-
    computadora(Computadora, _, _, _, _),
    falla(Computadora, _, garve).

computadoraCritica(Computadora):-
    computadora(Computadora, _, _, _, _),
    not(backupRealizado(Computadora, completo)). 

% Parte C

costoReparacion(Computadora, TipoFalla, CostoFinal):-
    computadora(Computadora, _, _, _, _),
    falla(Computadora, TipoFalla, Gravedad),
    costoBase(TipoFalla, Costo),
    multiplicadorSegunGravedad(Gravedad, Multiplicador),
    CostoFinal is Costo * Multiplicador.

multiplicadorSegunGravedad(leve, 1).
multiplicadorSegunGravedad(media, 1.25).
multiplicadorSegunGravedad(grave, 1.60).



especialidadNecesaria(disco, hardware).
especialidadNecesaria(fuente, hardware).
especialidadNecesaria(placaVideo, hardware).
especialidadNecesaria(sistemaOperativo, software).
especialidadNecesaria(red, redes).
especialidadNecesaria(seguridad, seguridad).
especialidadNecesaria(temperatura, hardware).

tecnicoIdeal(Tecnico, Computadora):-
    tecnico(Tecnico, Especialidad, _),
    computadora(Computadora, _, _, _, _),
    falla(Computadora, TipoFalla, _),
    especialidadNecesaria(TipoFalla, Especialidad), 
    tieneMasCincoExperiencia(Tecnico). 


tieneMasCincoExperiencia(Tecnico):-
    tecnico(Tecnico, _, Experiencia),
    Experiencia > 5.


comboMantenimiento(Combo):-
    findall(Codigo, computadora(Codigo, _, _, _, _), Computadoras),
    comboPosible(Computadoras, Combo),
    comboValido(Combo).

comboPosible([], []).

comboPosible([Computadora | Resto], [Computadora | Combo]):-
    comboPosible(Resto, Combo).

comboPosible([_ | Resto], Combo):-
    comboPosible(Resto, Combo).

comboValido(Combo):-
    length(Combo, 3),
    todasExisten(Combo),
    tieneNotebook(Combo),
    tieneFallaGrave(Combo),
    fallasMenosSetecientosMil(Combo).

todasExisten(Combo):-
    forall(
        member(Computadora, Combo), 
        computadora(Computadora, _, _, _, _)
    ).

tieneNotebook(Combo):-
    member(Computadora, Combo),
    computadora(Computadora, _, notebook, _, _).

tieneFallaGrave(Combo):-
    member(Computadora, Combo),
    falla(Computadora, _, grave).

fallasMenosSetecientosMil(Combo):-
    findall(
        CostoFinal,
        (
            member(Computadora, Combo),
            costoReparacion(Computadora, _, CostoFinal) 
        ),
        CostosFinales
    ),
    sum_list(CostosFinales, Total),
    Total =< 700000.