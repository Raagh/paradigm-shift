% 1 - Relevamiento Inicial

sabeProgramar(fernando,[cobol,visualbasic,java]).
sabeProgramar(santiago,[ecmascript,java]).
sabeProgramar(julieta,[java]).
sabeProgramar(marcos,[java]).

esFuncional(fernando).
esLeader(andres).
esProgramador(Alguien):-sabeProgramar(Alguien,_).


% Por principio de Universo Cerrado como no sabemos si julieta programo en go, no lo agregamos.
% Tampoco agregamos que nadie programo en Assembler por el mismo principio. 
% Que andres no programe cae en el mismo principio.

% 2 - Requerimientos Basicos
% 2.2

conoceElLenguaje(Alguien,Lenguaje):-sabeProgramar(Alguien,Lenguajes),member(Lenguaje,Lenguajes).

% a.  sabeProgramar(fernando,Lenguajes).
% b.  conoceElLenguaje(Alguien,java).
% c.  sabeProgramar(_,assembler).
% d.  esProgramador(fernando).
% e.  
% f.  esProgramador(Quien).
% g.  esLeader(_).

% 3 - Proyectos
% 3.1

proyecto(sumatra,[java,net]).
proyecto(prometeus,[cobol]).

trabajan([julieta,marcos,andres],sumatra).
trabajan([fernando,santiago],prometeus).

trabajaEn(Persona,Proyecto):-trabajan(Personas,Proyecto),member(Persona,Personas).

% 3.2

% -------- FALTA TERMINAR --------

estaAsignada(Persona,Proyecto):-trabajaEn(Persona,Proyecto). 

% -------- FALTA TERMINAR --------

estaAsignada(Persona,Proyecto):-trabajaEn(Persona,Proyecto),esFuncional(Persona).
estaAsignada(Persona,Proyecto):-trabajaEn(Persona,Proyecto),esLeader(Persona).

