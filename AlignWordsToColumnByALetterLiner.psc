/// Este ejercicio es bastante sencillo si la ubicacion de las palabras de realiza al momento de la inserción, conociendo de antemano las condiciones tal como lo planteaba la consigna.
/// Más alla de esto, se presentan distintas soluciones para diversas situaciones.


Algoritmo ejercicioCooperativoGuia4
	Definir tablero como Cadena
	Definir dimR, dimC como Entero
	dimR=9
	dimC=12
	Dimension tablero[dimR, dimC]
	inicializarMatriz(tablero,dimR, dimC, " ")
	/// Todo este boilerplate es parte de la consigna inicial
	agregarPalabra(tablero, "vector", 0)
	agregarPalabra(tablero, "matrix", 1)
	agregarPalabra(tablero, "programa", 2)
	agregarPalabra(tablero, "subpfogramamlopo", 3)
	agregarPalabra(tablero, "subproceso", 4)
	agregarPalabra(tablero, "variable", 5)
	agregarPalabra(tablero, "entero", 6)
	agregarPalabra(tablero, "para", 7)
	agregarPalabra(tablero, "mientras", 8)
	matrixAMayusculas(tablero)
	imprimirMatriz(tablero,dimR, dimC)
	acomodarPalabras(tablero,6, "R")
	imprimirMatriz(tablero,dimR, dimC)
FinAlgoritmo

///** Se omite el paso de las dimensiones en forma intencional como una complicación extra
SubProceso acomodarPalabras(tablero,columna, liner)
	Definir i,j,index,delta,dimR,dimC Como Entero
	GetColumnsTheHardWay(tablero,dimR,dimC)
	si columna<dimC entonces
		Para i=0 hasta dimR-1
			index=GetIndexFirstAppear(tablero,dimC,i,liner) 
			si index=-(2^31) Entonces
				Escribir "En la fila " i " no se encontró la letra especificada"
				Escribir "-- IMPOSIBLE REUBICAR LOS VALORES EN ESTA FILA ---"
			SiNo
				RotarVectorCant(tablero,i,dimC,columna-index)
			FinSi
		FinPara
	SiNo
		Escribir "La columna indicada está fuera de los limites de la matriz"
		Escribir "-- NO ES POSIBLE REALIZA EL PROCESO DE REUBICACION ---"
	FinSi
FinSubProceso


///** VERSION MAS SENCILLA PARA ACOMODAR LAS PALABRAS CON LOS SUPUESTOS DE:
/// - el indice de la letra alineadora para cada palabra se encuentra antes de la columna objetivo
/// - todas las palabras tiene un margen de espacio vacio al final para poder trasladarse
/// - todas las palabras se ubicaron a partir del indice 0
///SubProceso AcomodarPalabras(tablero,columna, liner)
//	Definir offset,dimR,dimC,i,j,k  Como Entero
//	Definir temp Como Caracter
//	GetColumnsTheHardWay(tablero,dimR,dimC)
//	Para i=0 hasta dimR-1
//		offset=columna-GetIndexOfLetter(tablero,i,liner)
//		si offset>0 entonces
//			Para j=1 hasta offset
//				temp=tablero[i,dimC-1]
//				Para k=dimC-1 hasta 1
//					tablero[i,k]=tablero[i,k-1]
//				FinPara
//				tablero[i,0]=temp
//			FinPara
//		FinSi
//	FinPara
//FinSubProceso

 
SubProceso RotarVectorCant(tablero,row,dimC,dir)
	Definir i,j como Entero
	Definir temp Como Caracter
	si dir>0 entonces
		Para i=1 hasta dir
			temp=tablero[row,dimC-1]
			Para j=dimC-1 hasta 1
				tablero[row,j]=tablero[row,j-1]
			FinPara
			tablero[row,0]=temp
		FinPara
	FinSi
	si dir<0 entonces
		Para i=-1 hasta dir
			temp=tablero[row,0]
			Para j=0 hasta dimC-2
				tablero[row,j]=tablero[row,j+1]
			FinPara
			tablero[row,dimC-1]=temp
		FinPara
	FinSi
FinSubProceso



Funcion index = GetIndexFirstAppear(tablero,dimC,row,char)
	Definir index,i Como Entero
	index=-(2^31)
	Para i=0 hasta dimC-1
		si  tablero[row,i] =char Entonces
			index=i
			i=dimC-1
		FinSi
	FinPara
FinFuncion


SubProceso matrixAMayusculas(tablero) 
	Definir i Como Caracter
	Para cada i de tablero
		i=Mayusculas(i)
	FinPara
FinSubProceso

/// DIMC Y DIMR AUN NO LAS CONOZCO, PERO LAS PASO IGUAL PARA PODER OBTENER AMBOS VALORES EN UN MISMO SUBPROCESO ///
SubProceso GetColumnsTheHardWay(tablero Por Referencia, dimR Por Referencia,dimC Por Referencia)
	Definir item,safeBack,safeFront Como Caracter; Definir founded como Logico; Definir lenght Como Entero
	lenght=0
	Para cada item de tablero Hacer lenght=lenght+1; FinPara
	dimC=0; founded=Falso; safeBack=tablero[0,0]; safeFront=tablero[0,1]
	Para cada item de tablero
		si !founded Entonces
			si dimC>1 Entonces tablero[0,dimC-2]=safeBack; FinSi
			si tablero[1,0]="¶" Entonces founded=!founded; tablero[1,0]=safeFront; tablero[1,1]=safeFront; dimC=dimC-1;
			SiNo safeBack=safeFront; safeFront=item; item="¶"; dimC=dimC+1; FinSi
		FinSi
	FinPara
	dimR=lenght/dimC
FinFuncion

 

SubProceso agregarPalabra(matrix, palabra, row)
	Definir i,l,dimR,dimC Como Entero
	Definir j,k Como Caracter
	GetColumnsTheHardWay(matrix,dimR,dimC)
	si Longitud(palabra)>dimC  Entonces
		Escribir "La palabra tiene más caracteres que columnas disponibles"
		Escribir "Se procederá a truncar la palabra"
		palabra=Subcadena(palabra,0,dimC-1)
	FinSi	
		Para i=0 hasta Longitud(palabra)-1
			matrix[row,i] = Subcadena(palabra,i,i)
		FinPara
FinSubProceso

/// Directamente se pueden colocar las palabras en el orden deseado al momento de distribuir los caracteres
/// SubProceso agregarPalabra(tablero, palabra, fila)
//	Definir i, insertionIndex Como Entero
//	insertionIndex=5-GetIndexInWord(Mayusculas(palabra),"R")
//	Para i=0 hasta Longitud(palabra)-1
//		tablero[fila,i+insertionIndex] = Mayusculas(Subcadena(palabra,i,i))
//	FinPara
//FinSubProceso

	
SubProceso inicializarMatriz(matrix,dimR,dimC,filler)
	Definir slot Como Caracter
	Para cada slot de matrix
		slot=filler
	FinPara
FinSubProceso
 
SubProceso imprimirMatriz(matrix Por Referencia,dimR,dimC)
	Definir places,i,j,f,g,h, counter,extraSpaces Como Entero
	places =GetMaxDigitLengthTEXTO(matrix)
	Para f=0 hasta dimC*(places+5)
		Escribir Sin Saltar "_"
	FinPara
	Para i=0 hasta dimR-1
		Escribir ""
		Para j=0 hasta dimC-1
			h=Longitud(matrix[i,j])
			Escribir sin saltar "|"
			extraSpaces=trunc((places+2-h)/2)
			Para g=0 hasta extraSpaces
				Escribir sin saltar " "
			FinPara
			Escribir sin saltar matrix[i,j]
			Para g=0 hasta (places+2-h)-extraSpaces
				Escribir sin saltar " "
			FinPara
		FinPara
		Escribir "|"
		Para f=0 hasta dimC*(places+5)
			Escribir Sin Saltar "-"
		FinPara	
	FinPara
	Escribir ""
FinSubProceso


Funcion maxLength = GetMaxDigitLengthTEXTO(matrix Por Referencia)
	Definir maxLength, len Como Entero
	Definir i como Texto
	maxLength=0
	Para cada i en matrix
		len=Longitud(i)
		si len>maxLength Entonces
			maxLength=len
		FinSi
	FinPara
FinFuncion
 
