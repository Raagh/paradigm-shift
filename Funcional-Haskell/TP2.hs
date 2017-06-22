-- SEGUNDA ENTREGA:

import Data.List
import Text.Show.Functions

-- Punto 1)
data Cliente = Cliente{
	nombre::String,
	resistencia::Int,
	amigos::[Cliente],
	bebidas::[Bebida]
	}deriving(Show)

	
type Bebida = Cliente->Cliente

{- Utilizamos la expresion data para poder modelar a los clientes en 
 notacion record syntax mediante un nuevo tipo de dato, llamado Cliente,
 ya que suma expresividad y evita tener que crear funciones para acceder 
 a la informacion de cada cliente ya que le da entidad a cada dato que posee
 este ultimo -}

--------------------------------------------------------------------------------
-- a)
rodri = Cliente{
	nombre = "rodri",
	resistencia = 55,
	amigos = [],
	bebidas = [tintico]
	}

marcos = Cliente{
	nombre = "marcos",
	resistencia = 40,
	amigos = [rodri],
	bebidas = [klusener "Guinda"]
	}

cristian = Cliente{
	nombre = "cristian",
	resistencia = 2,
	amigos = [],
	bebidas = [grogXD,jarraLoca]
	}

ana = Cliente{
	nombre = "ana",
	resistencia = 120,
	amigos = [marcos,rodri],
	bebidas = []
	}

robertoCarlos = Cliente{
	nombre = "Roberto Carlos",
	resistencia = 165,
	amigos = [],
	bebidas = []
	}

--------------------------------------------------------------------------------
-- b)
grogXD::Bebida
grogXD cl = cl{resistencia = 0, bebidas = (bebidas cl)++[grogXD]}

klusener::String->Bebida
klusener gusto cl =  ((bajarResistencia cl.length) gusto){bebidas = (bebidas cl)++[klusener gusto]}

tintico::Bebida
tintico cl = cl{resistencia = resistencia cl + (5 * cantAmigos cl), bebidas = (bebidas cl)++[tintico]}

jarraLoca::Bebida
jarraLoca cl
 |cantAmigos cl == 0 = (bajarResistencia cl 10){bebidas = (bebidas cl)++[jarraLoca]}
 |otherwise = ( (bajarResistencia cl 10){bebidas = (bebidas cl)++[jarraLoca]} ){ amigos = bajaResistenciaAmigos (amigos cl) } 

bajaResistenciaAmigos::[Cliente]->[Cliente]
bajaResistenciaAmigos [x] = [(bajarResistencia x 10)]
bajaResistenciaAmigos (x:xs) = ((bajarResistencia x 10)):(bajaResistenciaAmigos xs)

bajarResistencia::Cliente->Int->Cliente
bajarResistencia cl cant= cl{resistencia = resistencia cl - cant}

soda::Int->Bebida
soda fuerza cl
 |fuerza >= 0 = cl{nombre = ('e':(replicate (fuerza) 'r'))++('p':nombre cl), bebidas = (bebidas cl)++[soda fuerza]}
 |otherwise = cl

--------------------------------------------------------------------------------
-- c)
tomarBebida::Bebida->Cliente->Cliente
tomarBebida bebida cl = bebida cl

tomarTragos::[Bebida]->Cliente->Cliente
tomarTragos [x] cl = tomarBebida x cl
tomarTragos (x:xs) cl = tomarTragos xs (tomarBebida x cl) 

--------------------------------------------------------------------------------
-- d)
dameOtro::Cliente->Cliente
dameOtro cl = tomarBebida (last (bebidas cl)) cl

--------------------------------------------------------------------------------
-- Punto 2
-- a)
cualesPuedeTomar::[Bebida]->Cliente->[Bebida]
cualesPuedeTomar bebidas cl = filter (puedeTomar cl) bebidas

puedeTomar::Cliente->Bebida->Bool
puedeTomar cl trago = (resistencia cl{resistencia = (resistencia (tomarBebida trago cl))} > 0)

-- b)
cuantasPuedeTomar::[Bebida]->Cliente->Int
cuantasPuedeTomar tragos cl = length (cualesPuedeTomar tragos cl)

--------------------------------------------------------------------------------
-- Punto 3)
-- a)
type Accion = Cliente->Cliente

data Itinerario = Itinerario{
	nombreItinerario::String,
	duracion::Float,
	acciones::[Accion]
	}deriving(Show)

itinerarioBasico = Itinerario{
	nombreItinerario = "Basico",
	duracion = 5.0,
	acciones = [
		rescatarse 2,
		jarraLoca,
		klusener "Huevo",
		klusener "Chocolate"
	]
}

salidaDeAmigos = Itinerario{
	nombreItinerario = "Salida de Amigos",
	duracion = 1.0,
	acciones = [
		soda 1,		
		tintico,
		agregarAmigo robertoCarlos,
		jarraLoca  
		]
	}

mezclaExplosiva = Itinerario{
	nombreItinerario = "Mezcla Explosiva",
	duracion = 2.50,
	acciones = [
		grogXD,
		grogXD,
		klusener "Huevo",
		klusener "Frutilla"
	]
}

hacerItinerario::Cliente->Itinerario->Cliente
hacerItinerario cl itinerario  = foldl (hacerAccion) cl (acciones itinerario)

hacerAccion::Cliente->Accion->Cliente
hacerAccion cl accion = accion cl

-- b)
-- >hacerItinerario rodri salidaDeAmigos
-- >hacerItinerario marcos mezclaExplosiva

-- Punto 4)
-- a)
calcularIntensidad::Itinerario->Float
calcularIntensidad it = (genericLength (acciones it)) / (duracion it)

-- b)
hacerItinerarioMasIntenso::Cliente->[Itinerario]->Cliente
hacerItinerarioMasIntenso cl itinerarios = hacerItinerario cl $ (itinerarioMasIntenso itinerarios)

itinerarioMasIntenso::[Itinerario]->Itinerario
itinerarioMasIntenso (x:xs) = foldl (maxIntensidad) x xs

maxIntensidad::Itinerario->Itinerario->Itinerario
maxIntensidad it1 it2
 |calcularIntensidad it1 > calcularIntensidad it2 = it1
 |otherwise = it2

-- Punto 5)
-- a)
chuckNorris = Cliente{
	nombre = "Chuck",
	resistencia = 1000,
	amigos = [ana],
	bebidas = map (soda) (iterate (+1)1)
}

-- b) 	No, no puede pedir otro trago con la función dameOtro porque la lista de bebidas que tomó es infinita,
--		por lo tanto, no se sabe cual es la ultima bebida que tomó

-- c)	Sí, de la siguiente manera en el terminal:
--		>resistencia $ hacerItinerario chuckNorris itinerarioBasico
--		>1076

-- d)	Sí, de la siguiente manera en el terminal:
--		>resistencia chuckNorris > resistencia ana
--		>True

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Funciones de Primer Entrega 

comoEsta::Cliente->[Char]
comoEsta cl
 |estaFresco cl = "fresco"
 |estaPiola cl = "piola"
 |otherwise = "duro"

estaFresco::Cliente->Bool
estaFresco cl = (resistencia cl > 50) 
 
estaPiola::Cliente->Bool
estaPiola cl = (not.estaFresco) cl && (cantAmigos cl > 1) 

cantAmigos = length.amigos
--
agregarAmigo::Cliente->Cliente->Cliente
agregarAmigo clAmigo cl
 |puedeAgregarAmigo cl clAmigo = cl{amigos = clAmigo:amigos cl}
 |otherwise = cl

puedeAgregarAmigo cl clAmigo = (not.yaEsAmigo cl) clAmigo && (not.esElMismo cl) clAmigo

yaEsAmigo::Cliente->Cliente->Bool
yaEsAmigo cl clAmigo = ((elem (nombre clAmigo)).listaNombresDeAmigos) cl

listaNombresDeAmigos::Cliente->[String]
listaNombresDeAmigos = (map (nombre)).amigos

esElMismo::Cliente->Cliente->Bool
esElMismo clAmigo = (== nombre clAmigo).nombre
--
rescatarse::Int->Cliente->Cliente
rescatarse horas cl
 |horas > 3 = cl{resistencia = resistencia cl + 200}
 |otherwise = cl{resistencia = resistencia cl + 100}
 
 
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------