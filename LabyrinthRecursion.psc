 Funcion laberintoChar = LaberintoToChain()
	Definir vl,laberintoChar,item Como Caracter
	Dimension vl[12]
	vl[0]= "..xx.......xxx....xx...........xxxxxxxx"
	vl[1]= "x.xxxxxxxx.x...x...x.xxxxxxx..xxxxxxxxx"
	vl[2]= "x........x.x.xxxxx.x.x...xxxx.xxxxxxxxx"
	vl[3]= "xxxxxxxx.x.x.xx..x.x.xxx.......xxxxxxxx"
	vl[4]= "xxxx.......xxxxxxx.x.xxx.xx..xxxxxx...x"
	vl[5]= "x....xxxxxxx....xxxxxxxxxxx.....xxxxxxx"
	vl[6]= "xxxx.........xx.......xxxxxxxxxxxxxxxxx"
	vl[7]= "x.xxxxxxxxxxxxxxxxxxx.x.........xxx...x"
	vl[8]= "x.....x....x...xxx.xx.x.xxxxxxx.xxx.x.x"
	vl[9]= "xxxxx.x.xx.xx..xxx.x....xxxxxxx.x.x.x.x"
	vl[10]="x.xxxxxx......xxxx.xxx.xxxxxx.x..xx.x.x"
	vl[11]="x........xxx.....x...x........xx....x.."
	laberintoChar=""
	Para cada item de vl
		laberintoChar=laberintoChar+item+"-"
	FinPara
FinFuncion

SubProceso  ObtenerDimensiones ( lineaLaberinto Por Referencia,dimh Por Referencia, dimv Por Referencia)
	Definir char Como Caracter
	dimh=0
	dimv=0
	Repetir
		dimh=dimh+1
		char=Subcadena(lineaLaberinto,dimh,dimh)
	Mientras Que char<>"-"
	dimv=Longitud(lineaLaberinto)/(dimh+1)
Fin Subproceso

SubProceso  CrearLaberinto ( matriz Por Referencia,lineaLaberinto Por Referencia,dimh, dimv)
	Definir char Como Caracter
	Definir i,j,u Como Entero
	Para i=0 hasta dimv-1
		Para j=0 hasta dimh-1
			matriz[i,j]=Subcadena(lineaLaberinto,i*dimh+i+j,i*dimh+i+j)
		FinPara
	FinPara
Fin Subproceso

SubProceso  ImprimirLaberinto ( matriz Por Referencia,dimh, dimv)
	Definir i,j Como Entero
	Para i=0 hasta dimv-1
		Escribir sin saltar"    "
		Para j=0 hasta dimh-1
			Escribir sin saltar matriz[i,j]
		FinPara
		Escribir ""
	FinPara
	Escribir ""
Fin Subproceso

SubProceso BuscarSalida(matriz Por Referencia, posy, posx,dimh,dimv, weAreOut Por Referencia, dir,numRec Por Referencia)
	numRec=numRec+1
	si posy=dimv-1 y posx=dimh-1 Entonces
		matriz[posy,posx]="$"
		Limpiar Pantalla
		Escribir ""
		Escribir ""
		ImprimirLaberinto(matriz, dimh, dimv)
		weAreOut=Verdadero
		Escribir "    ~~ Encontramos la salida! ~~"
	SiNo
		si !weAreOut entonces
			Limpiar Pantalla
			Escribir "    Entrando en recursión N° " numRec
			Escribir ""
			ImprimirLaberinto(matriz, dimh, dimv)
			Escribir "    Avanzando..."
			Esperar 50 Milisegundos
			matriz[posy,posx]=dir
			si posx>0 Y matriz[posy,posx-1]=="." y !weAreOut Entonces
				BuscarSalida(matriz, posy, posx-1,dimh,dimv, weAreOut,"<",numRec)
			FinSi
			si posx<dimh-1 Y matriz[posy,posx+1]=="." y !weAreOut Entonces
				BuscarSalida(matriz, posy, posx+1,dimh,dimv,weAreOut,">",numRec)
			FinSi
			si posy>0 Y matriz[posy-1,posx]=="." y !weAreOut Entonces
				BuscarSalida(matriz, posy-1, posx,dimh,dimv,weAreOut,"^",numRec)
			FinSi
			si posy<dimv-1 Y matriz[posy+1,posx]=="." y !weAreOut Entonces
				BuscarSalida(matriz, posy+1, posx,dimh,dimv,weAreOut,"V",numRec)
			FinSi
			si !weAreOut entonces 
				Limpiar Pantalla
				matriz[posy,posx]="#"
				numRec=numRec-1
				Escribir ""
				Escribir ""
				ImprimirLaberinto(matriz, dimh, dimv)
				Escribir "    Volviendo a recursión N° " numRec 
				Escribir ""
				Esperar 50 Milisegundos
			FinSi
		Fin si
	FinSi
FinSubProceso

Algoritmo LaberitoRecursivo
	Definir matriz como Caracter
	Definir lineaLaberinto,char como Texto
	Definir dimh, dimv,numRec como Entero
	Definir weAreOut como Logico
	weAreOut=Falso
	lineaLaberinto=LaberintoToChain()
	ObtenerDimensiones(lineaLaberinto,dimh, dimv)
	Dimension matriz[dimv,dimh]
	Escribir "La dimension h de la matrix es: ",dimh
	Escribir "La dimension v de la matrix es: ",dimv
	CrearLaberinto(matriz, lineaLaberinto,dimh, dimv)
	ImprimirLaberinto(matriz,dimh,dimv)
	numRec=0
	BuscarSalida(matriz,0,0,dimh,dimv,weAreOut,"*",numRec)
	si!weAreOut Entonces
		Escribir "Que lástima, no encontramos la salida del laberinto"
	FinSi
FinAlgoritmo
