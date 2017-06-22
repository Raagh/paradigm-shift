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
esProgramador(fernando).
esProgramador(Alguien):-programaEn(Alguien,_).
rol(Persona,analista):-esAnalistaFuncional(Persona).
rol(Persona,programador):-esProgramador(Persona).
rol(Persona,leader):-esProyectLeader(Persona).


% Punto 2

% Por principio de Universo Cerrado como no sabemos si julieta programo en go, no lo agregamos.
% Tampoco agregamos que nadie programo en Assembler por el mismo principio. 
% Que andres no programe cae en el mismo principio.

% trabajaEn(sumatra, Alguien).

% Punto 3
trabajaEn(prometeus, fernando).	
trabajaEn(prometeus, santiago).	
trabajaEn(sumatra, julieta).	
trabajaEn(sumatra, marcos).	
trabajaEn(sumatra, andres).

construidoEn(sumatra, java).
construidoEn(sumatra, net).
construidoEn(prometeus, cobol).

correctamenteAsignada(Alguien, Proyecto):-
	trabajaEn(Proyecto, Alguien),
	esAnalistaFuncional(Alguien).
correctamenteAsignada(Alguien, Proyecto):-	
	trabajaEn(Proyecto, Alguien),
	esProyectLeader(Alguien).
correctamenteAsignada(Alguien, Proyecto):-	
	trabajaEn(Proyecto, Alguien),
	construidoEn(Proyecto, Lenguaje),
	programaEn(Alguien, Lenguaje).


% Segunda Entrega

bienDefinido(Proyecto):-
	forall(trabajaEn(Proyecto, Persona), correctamenteAsignada(Persona, Proyecto)),esProyectLeader(Persona). 


estanBienDefinidos([sumatra]).
estanMalDefinidos([prometeus]).

esCopado(fernando, santiago).
esCopado(santiago, julieta).
esCopado(santiago, marcos).
esCopado(julieta, andres).

lePuedeEnseniar(Alguien, Lenguaje, AlguienMas):-
	programaEn(Alguien, Lenguaje),
	not(programaEn(AlguienMas,Lenguaje)),
	esCopado(Alguien, AlguienMas).

lePuedeEnseniar(Alguien, Lenguaje, AlguienMas):-
	programaEn(Alguien, Lenguaje),
	not(programaEn(AlguienMas,Lenguaje)),
	esCopado(Alguien, _),
	esCopado(_, AlguienMas).





	