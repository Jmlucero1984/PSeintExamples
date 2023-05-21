Funcion laberintoChar = LaberintoToChain()
	Definir vl,laberintoChar,item Como Caracter
	Dimension vl[16]
	vl[0]= "*.xx.......xxx....xx...............xxx...xxx...........xxxx"
	vl[1]= "x.xxxxxxxxx.x...x...x.xxxxxxx..xxxxxxxx.xxx.xxxxxxxxxx...xx"
	vl[2]= "x........x.x.xxxxx.x.x...xxxx.xxxxxxx...xx.xxxxxxxxxxx.xxxx"
	vl[3]= "xxxxxxxx.x.x.xx..x.x.xxx...............xx..............xxxx"
	vl[4]= "xxxx.......x.xx.xx.x.xxx.xx..xxxxxx.xx.xxxxxxxxxxxx.xx.xxxx"
	vl[5]= "x....xxxxxxx.x..xx.x.xx..xxxxxx.....x.......xxxxxxx.....xxx"
	vl[6]= "x.xx.........xx.xx.x..xx.xxxxxx.xxxxxxxxxxxxxxxxxxx.xxxxxxx"
	vl[7]= "x.xxxxxxxxxxxx..xx.xx.x.......x.xxxxx.............x.xxxxxxx"
	vl[8]= "x.....x....x...xxxxxxxxxxxxxxxxxxxxxx..xxxxxxxxxx.x.xxxxxxx"
	vl[9]= "xxxxx.x.xx.xx..xxx......xxxxxxx.......xxxxxxxxxxx.....xxxxx"
	vl[10]="x.xxx.xx......xxxx.xxx.xxxxxx....xxxx.........xxx.xxx...xxx"
	vl[11]="x........xxxx.xxxx..xx.xxxxx..xx......xxxxxx..xxx.xxxxx.xxx"
	vl[12]="x..xxxxxxxxx.....xx.xx........xx.xxxxxxxxxxx..xxx.xxxxx.xxx"
	vl[13]="x........xxx.xx.xxx.xxxxxxxxxxxx......xxxxxx..xxx.xxxxx.xxx"
	vl[14]="xxxxx.xxx.....x..xx.xx..xxxxxxxxxxxxx......xxxxxx..xxxx.xxx"
	vl[15]="x.........xxxxxx.....xx........xx......xxxxxx..xxxxxxxx...$"
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
		Escribir sin saltar "    "
		Para j=0 hasta dimh-1
			Escribir sin saltar matriz[i,j]
		FinPara
		Escribir ""
	FinPara
	Escribir ""
Fin Subproceso

Algoritmo LaberintoNoRecursion
	Definir matriz como Caracter
	Definir lineaLaberinto,char,flag como Texto
	Definir dimh, dimv, newPosx, newPosy, posx, posy,opciones como Entero
	Definir weAreOut,alreadySet como Logico
	weAreOut=Falso
	lineaLaberinto=LaberintoToChain()
	ObtenerDimensiones(lineaLaberinto,dimh, dimv)
	Dimension matriz[dimv,dimh]
	Escribir "La dimension h de la matrix es: ",dimh
	Escribir "La dimension v de la matrix es: ",dimv
	CrearLaberinto(matriz, lineaLaberinto,dimh, dimv)
	ImprimirLaberinto(matriz,dimh,dimv)
	flag="*"
	posx=0
	posy=0
	newPosx=0
	newPosy=0
	repetir
		opciones=0
		si matriz[newPosy,newPosx]="$" Entonces
			Escribir "    Enontramos la salida del laberinto!"	
			weAreOut=Verdadero
		SiNo
			matriz[newPosy,newPosx]=flag
			Limpiar Pantalla
			Escribir "    Avanzando..."
			EScribir "    newPosy: " newPosy
			Escribir "    newPosx: " newPosx
			posy=newPosy
			posx=newPosx
			si newPosx=dimh-1 y newPosy=dimv-1 y !weAreOut  Entonces
				weAreOut=Verdadero
			FinSi
			alreadySet=Falso
			si posx>0 Entonces
				si (matriz[posy,posx-1]=="." o matriz[posy,posx-1]=="$") y !weAreOut  Entonces
					newPosy=posy
					newPosx=posx-1
					opciones=opciones+1
					flag="<"
				FinSi
			FinSi
			si posx<dimh-1 Entonces
				si (matriz[posy,posx+1]=="." o matriz[posy,posx+1]=="$") y !weAreOut  Entonces
					newPosy=posy
					newPosx=posx+1
					opciones=opciones+1
					flag=">"
				FinSi
			FinSi
			si posy>0 Entonces
				si (matriz[posy-1,posx]=="." o matriz[posy-1,posx]=="$") y !weAreOut  Entonces
					newPosy=posy-1
					newPosx=posx
					opciones=opciones+1
					flag="^"
				FinSi
			FinSi
			si posy<dimv-1 Entonces
				si (matriz[posy+1,posx]=="." o matriz[posy+1,posx]=="$") y !weAreOut  Entonces
					newPosy=posy+1
					newPosx=posx
					opciones=opciones+1
					flag="v"
				FinSi
			FinSi
			si opciones>1 Entonces
				matriz[posy,posx]="H"
			FinSi
		 
			ImprimirLaberinto(matriz,dimh,dimv)
			//Escribir "    Continuar?"
			//Esperar Tecla
			Esperar 50 milisegundos
			si opciones=0 y !weAreOut  Entonces
					Mientras matriz[newPosy,newPosx]<>"H" hacer
					posx=newPosx
					posy=newPosy
					Limpiar Pantalla
					Escribir "    Volviendo..."
					EScribir "    newPosy: " newPosy
					Escribir "    newPosx: " newPosx
					matriz[newPosy,newPosx]="#"
					si posx>0 Entonces
						si matriz[posy,posx-1]<>"x" y matriz[posy,posx-1]<>"#" Entonces
							newPosx=posx-1
							newPosy=posy
						FinSi
					FinSi
					si posx<dimh-1 Entonces
						Si matriz[posy,posx+1]<>"x" y matriz[posy,posx+1]<>"#" Entonces
							newPosx=posx+1
							newPosy=posy
						FinSi	 
					FinSi
					si posy>0 Entonces
						si matriz[posy-1,posx]<>"x" y matriz[posy-1,posx]<>"#" Entonces
							newPosy=posy-1
							newPosx=posx
						FinSi
					FinSi
					si posy<dimv-1 Entonces
						si matriz[posy+1,posx]<>"x" y matriz[posy+1,posx]<>"#" Entonces
							newPosy=posy+1
							newPosx=posx
						FinSi
					FinSi
					ImprimirLaberinto(matriz,dimh,dimv)
					//Escribir "    Continuar?"
					//Esperar Tecla
					Esperar 50 milisegundos
				fin mientras
			FinSi
		FinSi
	Mientras Que !weAreOut
FinAlgoritmo
