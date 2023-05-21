# PSeintExamples
Some stuff on PSeint at Globant+Egg QA Automation Course


## Informe de Ventas de Una Empresa + Mapa Resúmen

*Example of ResumenVentasEmpresa_MapaIncluido.psc output*  

![alt text](https://github.com/Jmlucero1984/PSeintExamples/blob/main/map.JPG?raw=true)



## Labyrinth Pathfinder with Recursion  
*Issue: This way i got up to ~77 recursion calls, then execution was interrupted... no crash, just interrupted.*  
![alt text](https://github.com/Jmlucero1984/PSeintExamples/blob/main/Labyrinth%20Recursion.gif?raw=true)

## Labyrinth Pathfinder with No Recursion (double While)  
*Pro: You can perform on much more bigger mazes, with no recursion call-stack issues.*  
![alt text](https://github.com/Jmlucero1984/PSeintExamples/blob/main/Labyrinth%20No%20Recursion.gif?raw=true)

## Simil Dynamic Vector Dimensioning (using recursion) and Ordering

![alt text](https://github.com/Jmlucero1984/PSeintExamples/blob/main/DynVectOrdering_1.gif?raw=true)

*Question: How far can we go deep in recursion? Is there such a thing like Tail Optimization in PSeint?*  
![alt text](https://github.com/Jmlucero1984/PSeintExamples/blob/main/DynVectOrdering_2.gif?raw=true)  
 

## Recursive Quick Sort  

![alt text](https://github.com/Jmlucero1984/PSeintExamples/blob/main/RecursiveQuickSort.gif?raw=true)  

## AlignWordsFullFlexible

In particular, i'd like to highlight this little tricky method to find matrix dimensions.  
Althought we start from assumptions:  
		  a) We deal with a matrix (at least 2 rows and 2 columns).  
		  b) The matrix data type is known.  
	
 ```
/// DIMC and DIMR are the ones we are looking for, but i have to pass them via reference to take back the values after ///
/// Using a function only allows me to return just one value (no reference types created under function scope) ///

SubProceso GetColumnsTheHardWay(tablero Por Referencia, dimR Por Referencia,dimC Por Referencia)
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
				// like a juggler, to avoid self iteration referencing
				safeBack=safeFront 
				safeFront=item	
				item="¶"
				dimC=dimC+1
			FinSi
		FinSi
	FinPara
	dimR=lenght/dimC
FinFuncion
```


