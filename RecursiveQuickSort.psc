Funcion  QuickSort ( vectorOriginal, vectorOrdenado Por Referencia, index Por Referencia, dim )
	Definir min, max,rango,i,counterLeft, counterRight,vectorLeft,vectorRight Como Entero
	Definir pivot Como Real
	Escribir ""
	Escribir "Entrando con este vector "
	ImprimirVectoresBracket(vectorOriginal,GetDimension(vectorOriginal))
	Escribir ""
	Esperar 600 Milisegundos
	min=2^31-1; max=-(2^31)
	//BUSCAMOS EL MINIMO Y EL MAXIMO
	Para i=0 hasta GetDimension(vectorOriginal)-1 Hacer
		Si vectorOriginal[i]>max Entonces max=vectorOriginal[i]
		FinSi
		Si vectorOriginal[i]<min Entonces min=vectorOriginal[i]
		FinSi
	FinPara
	rango=max-min; pivot=rango/2; i=0
	counterLeft =0; counterRight =0
	//Escribir "min, max, rango, pivot: ",min," ",max," ",rango," ",pivot
	Para i=0 hasta GetDimension(vectorOriginal)-1 Hacer
		Si vectorOriginal[i] <pivot+min Entonces counterLeft=counterLeft+1;
		SiNo counterRight=counterRight+1; FinSi
	FinPara
	Dimension vectorLeft(counterLeft+1)
	Dimension vectorRight(counterRight+1)
	counterLeft =0; counterRight =0
	Para i=0 hasta GetDimension(vectorOriginal)-1 Hacer
		Si vectorOriginal[i] <pivot+min entonces
			vectorLeft[counterLeft]=vectorOriginal[i]
			counterLeft=counterLeft+1
		SiNo
			vectorRight[counterRight]=vectorOriginal[i]
			counterRight=counterRight+1
		FinSi
	FinPara
	vectorLeft[counterLeft]=-(2^31); vectorRight[counterRight]=-(2^31) // COLOCAMOS LOS  FLAGS AL FINAL
	counterLeft=GetDimension(vectorLeft)// SI...se usa una variable para otro fin..
	Si counterLeft>1 Entonces
		Si  CheckIguales(vectorLeft) Entonces
			Escribir "VALORES FINALES LEFT: "
			ImprimirVectores(vectorLeft,counterLeft)
			Esperar 600 Milisegundos
			Para i=0 hasta counterLeft-1 Hacer
				vectorOrdenado[index]=vectorLeft[i]
				index=index+1
			FinPara
		Sino QuickSort( vectorLeft, vectorOrdenado, index,counterLeft)
		FinSi
	SiNo
		Escribir "VALOR FINAL LEFT: ",vectorLeft[0]
		Esperar 600 Milisegundos
		vectorOrdenado[index]=vectorLeft[0]
		index=index+1
	FinSi
	counterRight=GetDimension(vectorRight) // SI...se usa una variable para otro fin..
	Si counterRight>1 Entonces
		Si CheckIguales(vectorRight) Entonces
			Escribir "VALORES FINALES RIGHT: "
			ImprimirVectores(vectorRight,counterRight)
			Esperar 600 Milisegundos
			Para i=0 hasta counterRight-1 Hacer
				vectorOrdenado[index]=vectorRight[i]
				index=index+1
			FinPara
		Sino QuickSort( vectorRight, vectorOrdenado, index,counterRight)
		FinSi
	SiNo
		Escribir "VALOR FINAL RIGHT: ",vectorRight[0]
		Esperar 600 Milisegundos
		vectorOrdenado[index]=vectorRight[0]
		index=index+1
	FinSi
	Escribir "REGRESANDO DE LA RECURSION... "
	ImprimirVectoresBracket(vectorOrdenado,index)
	Escribir ""
Fin Funcion

Algoritmo QuickSortProg
	Definir valores,ordenado,dim,i,index Como Entero
	Escribir "Introduzca cantidad de numeros aleatorios con los cuales poblar un vector para luego ordenarlos en forma Ascendente"
	Escribir "Cantidad: "
	Leer dim
	dim=dim+1 // Agregamos un lugar más para la FLAG
	index=0
	Dimension valores(dim);
	Dimension ordenado(dim)
	FillVector(valores,dim)
	ImprimirVectoresBracket(valores,GetDimension(valores))
	Escribir ""
	EScribir "--------------~~ INICIANDO QUICK SORT ~~-----------------------"
	QuickSort(valores,ordenado,index,dim)
	Escribir ""
	Escribir "// RESULTADO FINAL DEL ORDENAMIENTO QUICK SORT //"	 
	ImprimirVectoresBracket(ordenado,index)
FinAlgoritmo

Funcion iguales <- CheckIguales ( vector Por Referencia )
	Escribir "CHECKING EQUALITY"
	Definir iguales Como Logico
	Definir i Como Entero
	iguales=Verdadero
	Para i=1 Hasta GetDimension(vector)-1 Hacer
		si vector[i]<>vector[i-1]  iguales=Falso; FinSi
	FinPara
	si iguales Escribir "SON IGUALES" ; FinSi
Fin Funcion

Funcion  FillVector ( vector Por Referencia, dim )
	Definir i como Entero
	Para i= 0 hasta dim-2 Hacer vector[i]=Aleatorio(1,50); FinPara
	vector[dim-1]=-(2^31)
Fin Funcion

Funcion dim <- GetDimension ( vector Por Referencia )
	Definir dim,i como Entero
	dim=0; i=0
	Mientras vector[i]>-(2^31) Hacer
		dim=dim+1
		i=i+1
	FinMientras
Fin Funcion

Funcion ImprimirVectores(vector Por Referencia,dim)
	Definir i como Entero
	Para i=0 hasta dim-1 Hacer
		Escribir Sin Saltar vector[i]
		si(i<dim-1) Entonces
			Escribir Sin Saltar ", "
		FinSi
	FinPara
	Escribir " "
FinFuncion

Funcion ImprimirVectoresBracket(vector Por Referencia,dim)
	Definir i como Entero
	Escribir  Sin Saltar "  [ "
	Para i=0 hasta dim-1 Hacer
		Escribir Sin Saltar vector[i]
		si(i<dim-1) Entonces
			Escribir Sin Saltar ", "
		FinSi
	FinPara
	Escribir  Sin Saltar " ]"
	Escribir " "
FinFuncion