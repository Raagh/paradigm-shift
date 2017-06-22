-- PRIMER ENTREGA:

-- 1)
data Cliente = Cliente{
	nombre::String,
	resistencia::Int,
	amigos::[Cliente]
	}deriving(Show, Eq)

{- Utilizamos la expresion data para poder modelar a los clientes en 
 notacion record syntax mediante un nuevo tipo de dato, llamado Cliente,
 ya que suma expresividad y evita tener que crear funciones para acceder 
 a la informacion de cada cliente ya que le da entidad a cada dato que posee
 este ultimo -}

--------------------------------------------------------------------------------
-- 2)
rodri = Cliente{
	nombre = "rodri",
	resistencia = 55,
	amigos = []
	}

marcos = Cliente{
	nombre = "marcos",
	resistencia = 40,
	amigos = [rodri]
	}

cristian = Cliente{
	nombre = "cristian",
	resistencia = 2,
	amigos = []
	}

ana = Cliente{
	nombre = "ana",
	resistencia = 120,
	amigos = [marcos,rodri]
	}
--------------------------------------------------------------------------------
-- 3)
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

--------------------------------------------------------------------------------
-- 4)

agregarAmigo::Cliente->Cliente->Cliente
agregarAmigo cl clAmigo
 |puedeAgregarAmigo cl clAmigo = cl{amigos = clAmigo:amigos cl}
 |otherwise = cl

puedeAgregarAmigo cl clAmigo = (not.yaEsAmigo cl) clAmigo && (not.esElMismo cl) clAmigo

yaEsAmigo::Cliente->Cliente->Bool
yaEsAmigo cl clAmigo = ((elem (nombre clAmigo)).listaNombresDeAmigos) cl

listaNombresDeAmigos::Cliente->[String]
listaNombresDeAmigos = (map (nombre)).amigos

esElMismo::Cliente->Cliente->Bool
esElMismo clAmigo = (== nombre clAmigo).nombre

--------------------------------------------------------------------------------
-- 5)

tomarGrogXD::Cliente->Cliente
tomarGrogXD cl = cl{resistencia = 0}

tomarKlusener::String->Cliente->Cliente
tomarKlusener gusto cl = (bajarResistencia cl.length) gusto

tomarTintico::Cliente->Cliente
tomarTintico cl = cl{resistencia = resistencia cl + (5 * cantAmigos cl)}

tomarJarraLoca::Cliente->[Cliente]
tomarJarraLoca cl
 |cantAmigos cl == 0 = [bajarResistencia cl 10]
 |otherwise = (bajarResistencia cl 10):(bajaResistenciaAmigos (amigos cl))

bajaResistenciaAmigos::[Cliente]->[Cliente]
bajaResistenciaAmigos [x] = [bajarResistencia x 10]
bajaResistenciaAmigos (x:xs) = (bajarResistencia x 10):(bajaResistenciaAmigos xs)

bajarResistencia::Cliente->Int->Cliente
bajarResistencia cl cant= cl{resistencia = resistencia cl - cant}

tomarSoda::Cliente->Int->Cliente
tomarSoda cl fuerza
 |fuerza >= 0 = cl{nombre = ('e':(replicate fuerza 'r'))++('p':nombre cl)}
 |otherwise = cl

--------------------------------------------------------------------------------
-- 6)

rescatarse::Int->Cliente->Cliente
rescatarse horas cl
 |horas > 3 = cl{resistencia = resistencia cl + 200}
 |otherwise = cl{resistencia = resistencia cl + 100}
 
--------------------------------------------------------------------------------
-- 7)

--(tomarJarraLoca.((tomarKlusener "Chocolate").((rescatarse 2).(tomarKlusener "Huevo")))) ana

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------