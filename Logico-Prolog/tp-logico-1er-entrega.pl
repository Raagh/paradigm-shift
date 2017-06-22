% Punto 1

programaEn(fernando, cobol).
programaEn(fernando, visualbasic).
programaEn(fernando, java).
programaEn(julieta, java).
programaEn(marcos, java).
programaEn(santiago, ecmascript).
programaEn(santiago, java).
esAnalistaFuncional(fernando).
esProyectLeader(andres).
esProgramador(Alguien):-
	programaEn(Alguien, Lenguaje).


% Punto 2

% Por principio de Universo Cerrado como no sabemos si julieta programo en go, no lo agregamos.
% Tampoco agregamos que nadie programo en Assembler por el mismo principio. 
% Que andres no programe cae en el mismo principio.


% Punto 3

trabajaEn(prometeus, fernando).	
trabajaEn(prometeus, santiago).	
trabajaEn(sumatra, julieta).	
trabajaEn(sumatra, marcos).	
trabajaEn(sumatra, andres).

construidoEn(sumatra, java).
construidoEn(sumatra, net).
construidoEn(prometeus, cobol).

programanEnProyecto(Alguien, Proyecto):-
	trabajaEn(Proyecto, Alguien),
	construidoEn(Proyecto, Lenguaje1),
	programaEn(Alguien, Lenguaje2),
	not(Lenguaje1 \= Lenguaje2).

correctamenteAsignada(Alguien, Proyecto):-
	trabajaEn(Proyecto, Alguien),
	esAnalistaFuncional(Alguien).
correctamenteAsignada(Alguien, Proyecto):-	
	trabajaEn(Proyecto, Alguien),
	esProyectLeader(Alguien).
correctamenteAsignada(Alguien, Proyecto):-	
	trabajaEn(Proyecto, Alguien),
	construidoEn(Proyecto, Lenguaje1),
	programaEn(Alguien, Lenguaje2),
	not(Lenguaje1 \= Lenguaje2).	