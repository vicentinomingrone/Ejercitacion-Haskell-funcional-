% usuario(Nombre, Edad, TipoCuenta).
usuario(vicentino, 22, premium).
usuario(martina, 25, estandar).
usuario(lucas, 17, estandar).
usuario(sofia, 30, premium).
usuario(tomas, 12, infantil).
usuario(camila, 40, premium).
usuario(juan, 70, estandar).
usuario(elena, 82, premium).

% contenido(Codigo, Titulo, Genero, DuracionMinutos).
contenido(c001, dark, cienciaFiccion, 50).
contenido(c002, breakingBad, drama, 47).
contenido(c003, toyStory, animacion, 90).
contenido(c004, it, terror, 135).
contenido(c005, interestelar, cienciaFiccion, 169).
contenido(c006, elPadrino, drama, 175).
contenido(c007, sherlock, policial, 55).
contenido(c008, coco, animacion, 105).

% visualizacion(Usuario, CodigoContenido, Estado).
visualizacion(vicentino, c001, completa).
visualizacion(vicentino, c005, incompleta).
visualizacion(martina, c002, completa).
visualizacion(lucas, c004, completa).
visualizacion(sofia, c006, incompleta).
visualizacion(tomas, c003, completa).
visualizacion(camila, c001, completa).
visualizacion(camila, c007, completa).
visualizacion(juan, c006, completa).
visualizacion(elena, c008, incompleta).

% problemaTecnico(Usuario, Problema, Gravedad).
problemaTecnico(vicentino, buffering, media).
problemaTecnico(sofia, subtitulos, leve).
problemaTecnico(camila, audio, grave).
problemaTecnico(elena, inicioSesion, grave).
problemaTecnico(elena, buffering, media).
problemaTecnico(lucas, calidadVideo, leve).

% costoBase(Problema, Costo).
costoBase(buffering, 5000).
costoBase(subtitulos, 3000).
costoBase(audio, 10000).
costoBase(inicioSesion, 12000).
costoBase(calidadVideo, 4000).

% soporteTecnico(Nombre, Especialidad, Experiencia).
soporteTecnico(raul, conexion, 10).
soporteTecnico(diego, cuentas, 7).
soporteTecnico(marcos, audioVideo, 6).
soporteTecnico(lucia, subtitulos, 4).
soporteTecnico(gustavo, diagnosticoGeneral, 15).
soporteTecnico(ana, streaming, 12).

/**/


/*
Parte A — Consultas en consola

Escribí las consultas que harías en Prolog e indicá sus respuestas.

¿Existe algún usuario con cuenta premium?
usuario(_, _, premium).
true. 
Para saber quien: usuario(Quienes, _, premium).
Quienes = vicentino; 
Quienes = sofia; 
Quienes = camila; 
Quienes = elena. 
¿Qué edad tiene elena?
usuario(elena, Edad, _).
Edad = 82.

¿Qué contenidos vio camila?
visualizacion(camila, Cual, _).
Cual = c001;
Cual = c007.
¿Qué género tiene interestelar?
contenido(_, interestelar, Genero, _).
Genero = cienciaFiccion. 

Parte B — Usuario problemático

Queremos saber si un usuario es problemático para soporte.

Un usuario es problemático cuando:

tiene un problema técnico grave;
o tiene más de un problema técnico cargado;
o tiene más de una visualización incompleta;
o tiene más de 75 años.

Se nos dio esta implementación:

usuarioProblematico(Usuario):-
    problemaTecnico(Usuario, _, grave).

usuarioProblematico(Usuario):-
    problemaTecnico(Usuario, _, _).

usuarioProblematico(Usuario):-
    visualizacion(Usuario, _, incompleta).

usuarioProblematico(Usuario):-
    usuario(Usuario, Edad, _),
    Edad > 75.

Responder:

¿El código resuelve correctamente el problema planteado? falso.
No el codigo resulve mal el problema ya que  hay varias reglas que no hace bien lo que pide el 
enunciado. 
¿El predicado usuarioProblematico/1 es inversible?
Es inversible el predicado, lo que no significa que sea inversible cerrado.
¿Qué problema aparece con la segunda regla?
El problema que aparece con esta segunda regla es que permite que se le ponga como usuarioProblematico
con tan solo 1 problema tecnico y el encunciado dice 2 
¿Qué problema aparece con la tercera regla?
El problema que aparece con esta tercera regla es que permite que se le ponga como usuarioProblematico
con tan solo 1 visualizacion Incompleta y el encunciado dice 2
Codificar una solución mejor.
Aqui esta: 
*/

usuarioProblematico(Usuario):-
    usuario(Usuario, _, _),
    problemaTecnico(Usuario, _, grave).

usuarioProblematico(Usuario):-
    usuario(Usuario, _, _),
    problemaTecnico(Usuario, Problema, _),
    problemaTecnico(Usuario, OtroProblema, _),
    Problema \= OtroProblema.


usuarioProblematico(Usuario):-
    usuario(Usuario, _, _),
    visualizacion(Usuario, Visualizacion, incompleta),
    visualizacion(Usuario, OtraVisualizacion, incompleta),
    Visualizacion \= OtraVisualizacion. 

usuarioProblematico(Usuario):-
    usuario(Usuario, Edad, _),
    Edad > 75.

/*
Parte C — Costo de soporte

El costo final de atender un problema técnico depende de su gravedad:

leve: costo base.
media: costo base + 50%.
grave: costo base + 120%.


*/

costoSoporte(Usuario, Problema, CostoFinal):-
    usuario(Usuario, _, _),
    problemaTecnico(Usuario, Problema, Gravedad),
    costoBase(Problema, CostoBase),
    segunGravedad(Gravedad, Multiplicador),
    CostoFinal is CostoBase * Multiplicador. 

segunGravedad(leve, 1). 
segunGravedad(media, 1.50). 
segunGravedad(grave, 2.20). 

/*
chat para no olvidarme me gustaria que me dijieras como puedo hacerle un descuento. tipo se le bonifica
la el 50%.

que suma todos los costos de soporte de ese usuario: 

Responder:

¿Dónde usaste is y por qué?
¿Dónde usaste findall y por qué?
¿Para qué sirve sum_list?
*/

costoTotalSoporte(Usuario, Total):-
    usuario(Usuario, _, _),
    findall(
        CostoFinal, 
        costoSoporte(Usuario, Problema, CostoFinal),
        ListaDeCostos
        ), 
        sum_list(ListaDeCostos, Total). 


/*
Responder: 
¿Dónde usaste is y por qué?
lo use en costoSoporte(Usuario, Problema, CostoFinal), ya que pide que asignemos una cuenta al
costo final 
¿Dónde usaste findall y por qué?
lo use en costoTotalSoporte(Usuario, Total), ya que nenecito una lista para hecer el total del costo 
y despues sumo con sum_list
¿Para qué sirve sum_list?
Para sumar la lista de costos, y ponerlo en comparacion con el Total.

Parte D — Soporte recomendado

Para saber qué técnico conviene asignar a un usuario, 
se conoce qué especialidad se necesita según el problema:

Un soporte técnico es recomendado para un usuario si:

El usuario existe.
El usuario tiene un problema técnico.
La especialidad del soporte coincide con la especialidad necesaria para ese problema.
El soporte tiene más de 5 años de experiencia.

¿El predicado es inversible?
si el mio es inverisble y cerrado ya que ligo el usuario al comienzo de todo. 
¿Por qué no hace falta usar findall?
En ningun momento necesitas crear una lista.
¿Qué consulta harías para saber qué técnicos pueden atender a elena?
soporteRecomendado(Cuales, elena).
Cuales = .
*/

% especialidadNecesaria(Problema, Especialidad).
especialidadNecesaria(buffering, conexion).
especialidadNecesaria(subtitulos, subtitulos).
especialidadNecesaria(audio, audioVideo).
especialidadNecesaria(inicioSesion, cuentas).
especialidadNecesaria(calidadVideo, streaming).

soporteRecomendado(Soporte, Usuario):-
    usuario(Usuario, _, _),
    problemaTecnico(Usuario, Problema, _),
    soporteTecnico(Soporte, Especialidad, Experiencia),
    especialidadNecesaria(Problema, Especialidad),
    Experiencia > 5.  

/*
Parte E — Plan de recomendaciones

La plataforma quiere armar un plan de recomendaciones compuesto por exactamente 3 contenidos.

Un plan válido cumple:

Tiene exactamente 3 contenidos.
Todos los contenidos existen.
Ningún contenido está repetido.
Tiene al menos un contenido de género cienciaFiccion.
Tiene al menos un contenido de duración mayor a 120 minutos.
No incluye contenidos de género terror.
La suma de las duraciones de los contenidos no supera 320 minutos.

*/

planRecomendacion(Plan):-
    findall(Contenido, contenido(Contenido, _, _, _), Contenidos),
    planPermitido(Contenidos,Plan),
    planValido(Plan).

planPermitido([],[]).

planPermitido([Contenido | Resto],[Contenido | Plan]):-
    planPermitido(Resto, Plan).

planPermitido([_| Resto], Plan):-
    planPermitido(Resto, Plan).


planValido(Plan):-
    length(Plan, 3),
    todosSonContenidos(Plan),
    tieneCienciaFiccion(Plan),
    tieneMuchaDuracion(Plan),
    noTieneTerror(Plan),
    laDuracionNoSupera(Plan, 320). 

todosSonContenidos(Plan):-
    forall(
        member(Contenido, Plan), 
        contenido(Contenido, _, _, _)
        ). %chat me explicas depues si el forall crea una lista o pregunta a todos 
        % por ejemplo esta, pregunta a cada contenido en particular o crea una lista. 

tieneCienciaFiccion(Plan):-
    member(Contenido, Plan),
    contenido(Contenido, _, cienciaFiccion, _).

tieneMuchaDuracion(Plan):-
    member(Contenido, Plan),
    contenido(Contenido, _, _, Duracion),
    Duracion >= 120. 

noTieneTerror(Plan):-
    forall(
        member(Contenido, Plan),
        not(contenido(Contenido, _, terror, _))
        ).

laDuracionNoSupera(Plan, Cantidad):-
    findall(
        Duracion, 
        (member(Contenido, Plan),
        contenido(Contenido, _, _, Duracion)),
        DuracionDePeliculas
        ),
        sum_list(DuracionDePeliculas, DuracionDePelis),
        DuracionDePelis =< Cantidad. 