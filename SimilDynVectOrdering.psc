
Algoritmo SimilDynVectOrdering
	Definir mainVector Como Real
	Definir dim,i como  Entero
	mainVector=0
	DefVect(mainVector,0)
FinAlgoritmo


Funcion  OrdernarVector ( vector Por Referencia, dim, order )
	Definir actualMin como Real
	Definir i,j, changePos Como Entero
	Para i=0 hasta dim-1
		actualMin=vector[i]
		changePos=i
		Para j=i hasta dim-1
			si order="A" entonces
				si vector[j] <actualMin Entonces
					changePos=j
					actualMin=vector[j]
				FinSi
			SiNo
				si vector[j]>actualMin Entonces
					changePos=j
					actualMin=vector[j]
				FinSi
			FinSi
		FinPara
		vector[changePos]=vector[i]
		vector[i]=actualMin
		Limpiar Pantalla
		si order="A" entonces
			Escribir "  | NOW SORTING ALL VALUES  - ORDERING BY ASCENDING |"
		SiNo
			Escribir "  | NOW SORTING ALL VALUES  - ORDERING BY DESCENDING |"
		FinSi
		ImprimirVectores(vector,dim)
		Esperar 300 Milisegundos
	FinPara
Fin Funcion
 

SubProceso DefVect(vector, dim)
	Definir newVector como Real
	Definir valido Como Logico
	Definir  i como Entero
	Definir char como Caracter
	Si dim=0 Entonces
		Repetir
			Escribir "  | SIMIL DYNAMIC VECTOR SIZE EXPANSION AS NUMBERS ARE INTRODUCED |"
			Escribir "  Ingrese Primer Valor"; 
			leer char
			valido=ValidarNum_E_P_N(char,"R")
			si !valido Entonces
				Escribir "  No ha ingresado un número válido"
			FinSi
		Hasta que valido
	SiNo
		Repetir
		Escribir "  Desea ingresar otro valor? (valor/n)"; 
		leer char
		si Minusculas(char)<>"n" Entonces
			valido=ValidarNum_E_P_N(char,"R")
		SiNo
			valido=Verdadero
		FinSi
		si !valido Entonces
			Escribir "  No ha ingresado un número válido"
		FinSi
		Hasta que valido
	FinSi
	si Minusculas(char)<>"n" Entonces
		Dimension newVector[dim+1]
		si dim=0 Entonces newVector[0]=vector
		SiNo
			Para i=0 hasta dim-1			
				newVector[i]=vector[i]
			FinPara	
		FinSi
		newVector[dim] = ConvertirANumero(char)
		Limpiar Pantalla
		Escribir "  | SIMIL DYNAMIC VECTOR SIZE EXPANSION AS NUMBERS ARE INTRODUCED |"
		ImprimirVectores(newVector,dim+1)
		DefVect(newVector, dim+1)
	SiNo
		// RECIEN A PARTIR DE ACA EMPEZARIA EL RESTO DEL PROGRAMA
		// SEGURAMENTE ARRASTRANDO MUCHA BASURA HASTA ESE PUNTO
		// OPTIMIZACION DE COLA?
		//Escribir "  --- ORDENANDO VECTORES ---"
		Repetir
			Escribir "  Seleccione el criterio de ordenamiento: "
			Escribir "  A - Ascendente"
			Escribir "  D - Descendente"
			Leer char
			char=Minusculas(char)
		Hasta que char="a" o char="d"
		Definir alternativa como Caracter
		si  char ="a" Entonces
			OrdernarVector(vector, dim, "A" )
			// Lo que debe presentarse como opcion alternativa
			alternativa = "Descendente"
		SiNo
			OrdernarVector(vector, dim, "D" )
			// Lo que debe presentarse como opcion alternativa
			alternativa = "Ascendente"
		FinSi
		Repetir
			Escribir "  Desea ver el ordenamiento " alternativa " ? (s/n)"
			Leer char
			char=Minusculas(char)
		Hasta que char="s" o char="n"
		si char="s" Entonces
			OrdernarVector(vector, dim, subcadena(alternativa,0,0))
		FinSi
	FinSi
FinSubProceso


Funcion ImprimirVectores(vector Por Referencia,dim)
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

//Funcion vector <- DarVector ( dimen )
//	Definir vector,i Como Entero
//	Dimension vector[dimen]
//	Para i=0 hasta dimen-1
//		vector[i]=Azar(20)
//	FinPara
//	Para i=0 hasta dimen-1
//		Escribir "VALOR N° ",i+1,": ",vector[i]
//	FinPara
//Fin Funcion

Funcion valido <- ValidarNum_E_P_N ( variable, modoOption )
	Definir valido Como Logico
	Definir charValidos Como Caracter
	Definir i,j Como Entero
	valido = Verdadero
	charValidos= "0123456789.-"
	i=0
	Repetir
		valido=Falso
		j=0
		Repetir
			si Subcadena(variable,i,i)=Subcadena(charValidos,j,j) Entonces
				valido=Verdadero
				si Subcadena(charValidos,j,j)="-" y i<>0 Entonces
					valido=Falso
				FinSi
			FinSi
			j=j+1
		Mientras Que j<Longitud(charValidos)
		i=i+1
	Mientras Que i<Longitud(variable) y valido
	si valido entonces
		Segun modoOption Hacer
			"P":
				si Subcadena(variable,0,0)="-" Entonces
					valido=Falso
				FinSi
			"N":
				si Subcadena(variable,0,0)<>"-" Entonces
					valido=Falso
				FinSi
			"E":
				Para i=0 hasta Longitud(variable)
					si Subcadena(variable,i,i)="." Entonces
						valido=Falso
					FinSi
				FinPara
		FinSegun
	FinSi
Fin Funcion