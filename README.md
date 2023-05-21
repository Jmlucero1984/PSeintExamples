# PSeintExamples
Some stuff on PSeint at Globant+Egg QA Automation Course


## ResumenVentasEmpresa_MapaIncluido.psc

*Example of ResumenVentasEmpresa_MapaIncluido.psc output*

![alt text](https://github.com/Jmlucero1984/PSeintExamples/blob/main/map.JPG?raw=true)



## Labyrinth Pathfinder with Recursion 

![alt text](https://github.com/Jmlucero1984/PSeintExamples/blob/main/Labyrinth%20Recursion.gif?raw=true)



## Labyrinth Pathfinder with No Recursion (double While)

![alt text](https://github.com/Jmlucero1984/PSeintExamples/blob/main/Labyrinth%20No%20Recursion.gif?raw=true)


## AlignWordsFullFlexible

In particular, i'd like to highlight this little tricky method to find matrix dimension.

 
/// DIMC Y DIMR AUN NO LAS CONOZCO, PERO LAS PASO IGUAL PARA PODER OBTENER AMBOS VALORES EN UN MISMO SUBPROCESO ///
'SubProceso GetColumnsTheHardWay(tablero Por Referencia, dimR Por Referencia,dimC Por Referencia)
	Definir item, safeBack, safeFront Como Caracter
 Definir founded como Logico
 Definir lenght Como Entero
	lenght=0
	Para cada item de tablero
  lenght=lenght+1
 FinPara
	dimC=0
 founded=Falso
 safeBack=tablero[0,0]
 safeFront=tablero[0,1]
	Para cada item de tablero
		Si !founded Entonces
			Si dimC>1 Entonces
    tablero[0,dimC-2]=safeBack;
   FinSi
			Si tablero[1,0]="¶" Entonces 
    founded=!founded
    tablero[1,0]=safeFront
    tablero[1,1]=safeFront
    dimC=dimC-1;
			SiNo 
    safeBack=safeFront
    safeFront=item
    item="¶"
    dimC=dimC+1
   FinSi
		FinSi
	FinPara
	dimR=lenght/dimC
FinFuncion'
