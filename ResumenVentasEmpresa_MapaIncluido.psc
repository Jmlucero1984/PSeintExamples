 
Algoritmo ResumenDeVentasDeEmpresa
	Definir cantProductosDistintos,i,j,dimM_Resumen, dimN_Resumen, dimM_Nums, dimN_Nums,vectorBestSold,maxNameLenght Como Entero
	Definir matrixNum,r como Real
	Definir matrixPresentacion, tempName como Texto
	ImprimerEncabezado
	Escribir "Informe del desempeño de cada representante de ventas por región, y el aporte de estas regiones al total de la firma."
	Escribir "Ingrese a continuación los nombres de cada uno de los representantes."
	Escribir ""
	tempName=""
	dimM_Resumen=4+3
	dimN_Resumen=8
	Dimension matrixPresentacion[dimM_Resumen,dimN_Resumen]
	FormatearMatrixPresentacion(matrixPresentacion,dimM_Resumen,dimN_Resumen)	
	maxNameLenght=0
	Para i =1 hasta dimM_Resumen-3	
		Repetir 
			Escribir "Introduzca el nombre del vendedor N° ",i, " (No mayor a 15 caracateres)"
			Leer tempName
		Hasta que Longitud(tempName)>2 y Longitud(tempName)<=15
		si Longitud(tempName)>maxNameLenght Entonces
			maxNameLenght = Longitud(tempName)
		FinSi
		matrixPresentacion[i,0]=tempName
	FinPara
	Limpiar Pantalla
	ImprimerEncabezado
	ImprimirMatrixTEXTO(matrixPresentacion,dimM_Resumen,dimN_Resumen)
	dimM_Nums=6
	dimN_Nums=7
	Dimension matrixNum[dimM_Nums,dimN_Nums]
	Para cada r de matrixNum
		r=0
	FinPara
	Definir inputNum Como Caracter
	Definir validNumber como Logico
	Para i=0 hasta dimM_Nums-3
		Para j=0 hasta dimN_Nums-3
			Escribir ""
			Repetir
				Escribir "Introduzca la ventas del vendedor ",matrixPresentacion[i+1,0]," en la ZONA ", matrixPresentacion[0,j+1]
				Leer inputNum
				validNumber=ValidarNum_E_P_N(inputNum,"P") 
				Si !validNumber Entonces
					Escribir "Incorrecto, vuelva a intentar..."
				FinSi
			Hasta Que validNumber
			matrixNum[i,j]=ConvertirANumero(inputNum)
		FinPara
		Compaginar(matrixPresentacion,matrixNum,dimM_Resumen,dimN_Resumen,dimM_Nums)
		si i<>dimM_Nums-3 Entonces
			Limpiar Pantalla
			ImprimerEncabezado
			ImprimirMatrixTEXTO(matrixPresentacion,dimM_Resumen,dimN_Resumen)
		FinSi
	FinPara
	CalcularResumen(matrixNum,dimM_Nums,dimN_Nums)
	/// Vector con los largos de las barras porcentuales maxima por zona, que junton con el nombre mas largo condicionanel ancho
	/// de cada caja
	Definir percentsEachSellerByZone Como Real
	Dimension percentsEachSellerByZone[5,5]
	ObtenerMPLBZ(matrixNum, percentsEachSellerByZone)
	Compaginar(matrixPresentacion,matrixNum,dimM_Resumen,dimN_Resumen,dimM_Nums)
	Limpiar Pantalla
	ImprimerEncabezado
	Escribir ""
	Escribir "     ======================================================   TABLA RESUMEN DEL DESEMPEÑO  ======================================================"
	ImprimirMatrixTEXTO(matrixPresentacion,dimM_Resumen,dimN_Resumen)
	Escribir ""
	Definir zonasBoxesResume Como Caracter
	Dimension zonasBoxesResume[5,8]
	CompletarZoneBoxes(zonasBoxesResume,percentsEachSellerByZone,matrixPresentacion,maxNameLenght)
 	tempName="n"
	Escribir  "Desea imprimir el mapa de las zonas? (S/N)"
	Leer tempName
	si Minusculas(tempName)="s" Entonces
		Limpiar Pantalla
		ImprimerEncabezado
		Definir compressedChain como Texto
		compressedChain="{ }149{SL}{ }149{SL}{ }149{SL}{ }149{SL}{ }149{SL}{ }149{SL}{ }149{SL}{ }149{SL}{ }149{SL}{ }102{$}1{ }46{SL}{ }101{|}2{.}1{:}2{.}1{:}1{.}1{ }40{SL}{ }95{.}1{:}1{-}4{|}2{=}4{-}3{+}1{-}1{:}1{.}1{ }35{SL}{ }91{.}2{:}2{-}6{|}2{-}3{=}1{-}3{+}1{-}2{=}1{:}3{.}1{ }31{SL}{ }84{.}1{:}1{-}1{+}1{=}2{+}1{#}1{-}16{=}1{-}2{=}2{-}6{:}1{.}1{ }28{SL}{ }66{$}1{ }14{.}1{:}2{=}1{+}8{#}1{=}1{#}1{-}5{|}1{ }2{Z}1{O}1{N}1{A}1{ }3{|}1{-}7{#}2{-}1{:}1{.}1{ }25{SL}{ }66{\}2{ }10{.}1{=}1{+}16{#}1{-}3{=}1{|}1{ }2{N}1{O}1{R}1{T}1{E}1{ }2{|}1{=}4{+}1{#}2{*}3{+}1{:}1{.}1{ }24{SL}{ }67{\}2{ }7{+}19{#}1{-}5{=}1{-}10{=}1{#}1{*}7{+}1{-}1{.}1{ }25{SL}{ }68{\}2{ }5{.}1{=}1{+}12{*}1{+}6{#}1{=}1{-}1{=}2{-}14{#}1{*}8{+}1{-}1{.}1{ }22{SL}{ }69{\}2{ }3{.}1{:}1{=}1{+}9{*}1{+}2{*}1{+}4{#}1{=}1{-}1{#}1{:}1{#}1{-}14{#}2{*}11{+}1{:}1{.}1{ }19{SL}{ }69{:}1{\}2{+}7{|}1{ }3{Z}1{O}1{N}1{A}1{ }2{|}1{+}2{#}1{:}6{#}1{:}1{#}1{-}9{=}1{#}2{*}14{+}1{:}1{.}1{ }18{SL}{ }63{.}1{:}2{-}1{#}1{-}1{+}2{\}2{+}6{|}1{ }2{O}1{E}1{S}1{T}1{E}1{ }2{|}1{+}2{#}1{:}9{#}1{:}1{#}1{=}1{#}1{-}1{=}1{#}2{*}19{=}1{:}1{.}1{ }16{SL}{ }61{:}1{+}1{#}1{~}2{#}1{+}23{=}1{#}1{-}1{:}13{#}2{*}19{+}2{=}1{-}1{:}1{.}1{ }16{SL}{ }60{=}1{#}2{~}3{#}1{*}1{+}6{#}1{=}1{#}1{+}2{#}1{+}2{#}1{+}1{#}1{+}2{#}1{-}1{:}14{-}1{#}2{*}21{+}1{=}2{-}1{:}1{.}2{ }15{SL}{ }55{.}1{-}1{=}2{+}1{~}8{#}1{+}3{#}1{:}29{#}2{*}24{+}1{=}1{:}1{.}1{ }17{SL}{ }51{.}1{-}1{*}2{#}1{~}11{#}1{*}1{=}1{:}10{|}1{ }2{Z}1{O}1{N}1{A}1{ }1{C}1{E}1{N}1{T}1{R}1{O}1{ }2{|}1{:}2{-}1{#}1{*}29{-}1{:}2{ }4{.}1{:}1{-}1{*}1{+}1{-}1{ }6{SL}{ }49{-}1{+}1{*}1{#}2{~}13{#}1{=}1{:}30{#}2{*}6{|}1{ }2{Z}1{O}1{N}1{A}1{ }1{E}1{S}1{T}1{E}1{ }2{|}1{*}22{+}1{:}2{.}1{ }1{SL}{ }37{$}1{ }9{:}1{*}1{#}1{~}14{#}1{*}1{:}26{*}29{+}5{=}11{+}2{*}3{+}1{=}1{-}1{:}1{ }3{SL}{ }37{\}2{ }5{=}1{+}2{#}1{~}15{#}1{*}1{=}1{:}21{#}1{*}25{#}1{*}2{+}2{=}2{-}1{:}4{ }24{SL}{ }38{\}2{ }2{-}1{#}1{~}19{#}1{*}1{+}1{-}1{:}17{#}1{*}24{#}2{*}1{+}2{=}2{-}1{:}1{.}2{ }29{SL}{ }39{\}2{-}1{*}1{#}1{~}22{#}1{*}1{:}7{|}2{:}5{#}1{*}25{#}1{*}1{+}2{=}2{-}1{:}1{.}1{ }32{SL}{ }39{:}1{\}2{~}26{#}1{:}6{|}2{:}3{#}1{*}28{+}2{=}1{-}1{:}1{.}2{ }33{SL}{ }36{:}1{ }1{:}1{+}1{#}1{\}2{~}27{#}1{~}3{:}1{|}2{:}1{#}1{*}31{=}1{-}1{.}1{ }36{SL}{ }36{-}1{*}1{+}1{*}1{#}1{~}1{\}2{~}24{#}1{*}1{+}2{#}2{~}1{|}2{#}1{*}7{#}2{*}22{#}2{+}1{-}1{:}1{.}1{ }34{SL}{ }33{.}1{+}2{*}1{#}1{~}5{\}2{~}22{#}1{*}1{-}3{=}1{*}1{#}1{|}2{#}2{*}6{#}3{*}1{+}2{*}1{#}1{*}18{#}2{-}1{=}1{:}1{.}1{ }32{SL}{ }31{.}1{*}2{#}1{~}31{#}1{+}1{=}1{+}1{-}1{:}1{.}2{-}1{|}2{#}5{*}1{+}1{=}1{-}1{:}4{=}1{+}1{#}3{*}15{\}2{=}1{-}1{:}1{.}1{ }33{SL}{ }28{:}1{+}2{*}1{#}1{~}34{#}1{*}2{+}1{.}1{ }3{|}2{-}1{=}2{+}1{=}1{-}2{:}1{.}1{ }5{.}1{:}2{=}1{+}1{*}2{#}3{*}2{#}3{*}3{+}1{-}1{\}2{.}1{ }35{SL}{ }23{.}1{-}1{+}1{*}1{#}1{~}8{|}1{ }2{Z}1{O}1{N}1{A}1{ }1{S}1{U}1{R}1{ }2{|}1{~}11{#}1{*}8{-}1{:}2{.}1{ }1{|}2{ }1{.}6{ }11{.}2{:}1{-}1{=}2{+}2{=}1{-}7{:}1{ }1{\}2{ }34{SL}{ }22{.}1{*}1{#}1{~}33{#}1{*}2{+}1{=}2{-}2{:}7{.}1{ }1{|}2{ }22{.}3{:}6{.}4{ }2{\}2{ }33{SL}{ }15{:}1{ }1{:}2{=}1{*}1{#}1{~}25{#}1{*}2{+}3{=}1{+}1{*}1{+}3{=}2{-}1{:}1{.}2{ }10{|}2{ }39{$}1{ }32{SL}{ }12{.}1{-}1{*}1{#}1{~}29{#}1{+}1{=}1{-}1{:}2{.}4{:}5{.}2{ }13{|}2{ }72{SL}{ }10{.}1{+}1{#}1{~}32{#}1{*}1{-}1{:}1{.}1{ }25{|}2{ }72{SL}{ }9{.}1{*}1{#}1{~}33{*}1{=}1{:}1{.}1{ }26{|}2{ }72{SL}{ }9{-}1{=}1{*}1{#}1{~}33{+}1{-}1{:}1{.}1{ }25{|}2{ }72{SL}{ }10{:}1{+}1{#}1{~}32{*}1{+}1{=}1{-}1{.}1{ }25{|}2{ }72{SL}{ }8{:}1{+}1{#}1{~}23{*}4{+}7{=}2{-}1{:}1{.}1{ }25{|}2{ }72{SL}{ }8{*}1{#}1{~}21{*}1{+}3{=}1{-}3{:}7{.}1{ }28{|}2{ }72{SL}{ }8{*}1{#}2{~}11{*}2{+}8{=}1{-}1{:}1{.}2{ }39{$}1{ }72{SL}{ }9{:}1{+}1{*}1{#}1{~}6{#}1{*}1{+}2{=}1{-}2{:}6{.}2{ }115{SL}{ }10{.}1{:}1{=}1{*}1{~}4{#}1{+}2{=}1{-}1{:}1{.}1{ }124{SL}{ }13{.}1{+}1{#}2{*}1{+}2{-}1{:}1{.}1{ }126{SL}{ }15{-}1{+}1{-}1{=}1{-}1{:}1{.}1{ }127{SL}{ }16{.}2{:}1{.}2{ }128{SL}"																																																																																							
		Definir mapVector,linea, cadenaCoords Como Caracter
		Dimension mapVector[52]
		DecompressChain(mapVector,52,compressedChain)
		Definir vectorPos como Entero
		Dimension vectorPos[5,3]
		cadenaCoords="27,38,2,15,67,2,42,72,0,37,115,0,10,101,3,"
		PoblarVectorPos(vectorPos,cadenaCoords)
		PlaceBoxesOnMap(mapVector,zonasBoxesResume,vectorPos,5)
		Escribir "                                                           PARTICIPACION DE CADA VENDEDOR POR REGIONES                                                               "
		Escribir "                                                           ===========================================                                                               "
		Para cada tempName de mapVector
			Escribir tempName
		FinPara
	sino 
		Escribir ""
		Escribir "Una lástima, usted se lo pierde..."
	FinSi
	Escribir ""
	EScribir "Para terminar presione cualquier tecla...."
	Esperar Tecla
FinAlgoritmo

SubProceso ImprimerEncabezado
	Escribir "/////////////////////////////////////////////////////////  NESCAFÉ ~ RESÚMEN DE VENTAS-VENDEDOR-REGIÓN  ///////////////////////////////////////////////////////// "
	Escribir ""
Fin Subproceso

SubProceso PlaceBoxesOnMap(mapVector por Referencia,zonasBoxesResume por Referencia,vectorPos por Referencia,boxes)
	Definir i,insPosx, insPosy Como Entero
	insPosx=0
	insPosy=0
	para i =0 hasta boxes-1
		insPosy=vectorPos[i,0]
		insPosx=vectorPos[i,1]
		segun vectorPos[i,2] Hacer
			0:
			1: insPosx=insPosx-Longitud(zonasBoxesResume[i,1])
			2: insPosy=insPosy-8
				insPosx=insPosx-Longitud(zonasBoxesResume[i,1])
			3: insPosy=insPosy-8
		FinSegun
		Replace(insPosy,insPosx,mapVector,zonasBoxesResume,i,8)
	FinPara
FinSubProceso

SubProceso Replace(insPosy,insPosx,mapVector,zonasBoxesResume,item,cantLineas)
	Definir i como Entero
	Definir leftFragment, rightFrament como Caracter
	Para i=0 hasta cantLineas-1
		leftFragment=subcadena(mapVector[insPosy+i],0,insPosx)
		rightFrament=subcadena(mapVector[insPosy+i],insPosx+Longitud(zonasBoxesResume[item,1]),Longitud(mapVector[insPosy+i])-1)
		leftFragment=leftFragment+zonasBoxesResume[item,i]
		leftFragment=leftFragment+rightFrament
		mapVector[insPosy+i]=leftFragment
	FinPara
FinSubProceso


SubProceso PoblarVectorPos(vectorPos por Referencia, cadenaCoords)
	Definir slot, backInd,frontInd como Entero
	backInd=0
	frontInd=0
	Para cada slot de vectorPos
		Repetir
			frontInd=frontInd+1
		Hasta Que Subcadena(cadenaCoords,frontInd,frontInd)=","
		slot=ConvertirANumero(Subcadena(cadenaCoords,backInd,frontInd-1))
		frontInd=frontInd+1
		backInd=frontInd
	FinPara
FinSubProceso

Subproceso CompletarZoneBoxes(zonasBoxesResume por Referencia, percentsEachSellerByZone por Referencia,matrixPresentacion por Referencia,maxNameLenght)
	Definir i,j,k,largoBox,padLeft, padRight,longNumber Como Entero
	Definir topLine, bottomLine, titulo,char Como Caracter
	Definir num Como Real
	Para i=0 hasta 4 
		largoBox=maxNameLenght+16+trunc(percentsEachSellerByZone[4,i])
		si largoBox<32 Entonces
			largoBox=32
		FinSi
		si largoBox%2=0 Entonces
			largoBox=largoBox+1
		FinSi
		topLine=" "
		bottomLine=" "
		Para j=0 hasta largoBox-1
			topLine=topLine+"_"
			bottomLine=bottomLine+"-"
		FinPara
		topLine=topLine+" "
		bottomLine=bottomLine+" "
		zonasBoxesResume[i,0]=topLine
		zonasBoxesResume[i,7]=bottomLine
		titulo="ZONA SOBRE TOTAL: "+matrixPresentacion[6,i+1]+" %"
		char="| "
		padLeft=trunc((largoBox-4-Longitud(titulo))/2)
		padRight=largoBox-4-Longitud(titulo)-padLeft
		Para j=0 hasta padLeft
			char=char+" "
		FinPara
		char=char+titulo
		Para j=0 hasta padRight
			char=char+" "
		FinPara
		char=char+" |"
		zonasBoxesResume[i,1]=char
		titulo=" Participacion "
		char="| "
		padLeft=trunc((largoBox-4-Longitud(titulo))/2)
		padRight=largoBox-4-Longitud(titulo)-padLeft
		Para j=0 hasta padLeft
			char=char+"-"
		FinPara
		char=char+titulo
		Para j=0 hasta padRight
			char=char+"-"
		FinPara
		zonasBoxesResume[i,2]=char+" |"
		Para j=0 hasta 3
			char="| "+matrixPresentacion[j+1,0]+" "
			Para k=0 hasta  maxNameLenght-Longitud(matrixPresentacion[j+1,0])
				char=char+" "
			FinPara
			num=percentsEachSellerByZone[j,i]
			si num >5 entonces
				Para k=0 hasta trunc(redon(redon(num/10)))-1
					char=char+"*"
				FinPara
			SiNo
				char=char+"~"
			fin si
			longNumber=Longitud(ConvertirATexto(percentsEachSellerByZone[j,i]))
			para k=0 hasta largoBox-4-longNumber-Longitud(char)+1
				char=char+" "
			FinPara
			char=char+ConvertirATexto(percentsEachSellerByZone[j,i])+" % |"
			zonasBoxesResume[i,3+j]=char
		FinPara
	FinPara
FinSubProceso

 
SubProceso ObtenerMPLBZ(matrixNum por Referencia, precentsEachSellerByZone por Referencia)
	Definir i,j como Entero
	Definir totalZona, porcentual, maxPercent, percent como Real
	Para j=0 hasta 4 // HARD CODDED NO TIME
		totalZona=matrixNum[4,j]
		maxPercent=0
		Para i=0 hasta 3
			percent=(trunc((matrixNum[i,j]/totalZona)*10000))/100
			precentsEachSellerByZone[i,j] = percent
			si percent > maxPercent Entonces
				maxPercent=percent
			FinSi
		FinPara
		precentsEachSellerByZone[4,j]=trunc(maxPercent/10)
	Fin Para
FinSubProceso

SubProceso CalcularResumen(matrixNum por Referencia,dimM_Nums,dimN_Nums)
	Definir i, j Como Entero
	Definir sumaVendedor, sumaZona, total como Real
	Para i = 0 hasta dimM_Nums-3
		sumaVendedor=0
		Para j=0 hasta dimN_Nums-3
			sumaVendedor=sumaVendedor+matrixNum[i,j]
		FinPara
		matrixNum[i,dimN_Nums-2]=sumaVendedor
	FinPara
	Para j = 0 hasta dimN_Nums-2
		sumaZona=0
		Para i=0 hasta dimN_Nums-3
			sumaZona=sumaZona+matrixNum[i,j]
		FinPara
		matrixNum[dimM_Nums-2,j]=sumaZona
	FinPara
	total=matrixNum[dimM_Nums-2,dimN_Nums-2]
	Para i=0 hasta dimM_Nums-3
		matrixNum[i,dimN_Nums-1]=(trunc((matrixNum[i,dimN_Nums-2]/total)*10000))/100
	FinPara
	Para j=0 hasta dimN_Nums-3
		matrixNum[dimM_Nums-1,j]=(trunc((matrixNum[dimM_Nums-2,j]/total)*10000))/100
	FinPara
	matrixNum[dimM_Nums-1,dimN_Nums-1]=100.00
FinSubProceso

SubProceso Compaginar(matrixPresentacion Por Referencia, matrixNum Por Referencia,dimM_Resumen,dimN_Resumen, dimM_Nums)
	Definir i, j Como Entero
	Para i=1 hasta dimM_Resumen-1
		Para j=1 hasta dimN_Resumen-1
			matrixPresentacion[i,j] = ConvertirATexto(matrixNum[i-1,j-1])
		FinPara
	FinPara
FinSubProceso


SubProceso FormatearMatrixPresentacion(matrixPresentacion Por Referencia,dimM_Resumen,dimN_Resumen)
	matrixPresentacion[0,0] ="VENDEDOR\ZONA"
	matrixPresentacion[0,1] ="SUR"
	matrixPresentacion[0,2] ="OESTE"
	matrixPresentacion[0,3] ="CENTRO"
	matrixPresentacion[0,4] ="ESTE"
	matrixPresentacion[0,5] ="NORTE"
	matrixPresentacion[0,6] ="TOTAL VENDEDOR"
	matrixPresentacion[0,7] ="%"
	matrixPresentacion[dimM_Resumen-2,0] ="TOTAL ZONA"
	matrixPresentacion[dimM_Resumen-1,0] ="%"	
FinSubProceso

SubProceso ImprimirMatrixTEXTO(matrix Por Referencia,dimR,dimC)
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

 
SubProceso ImprimirMatrix(matrix Por Referencia,dimR,dimC)
	si (dimR>0 y dimC>0) y (dimR<11 y dimC<11) entonces
		Definir places,i,j,f,g,h, counter,extraSpaces Como Entero
		Escribir ""
		places =GetMaxDigitLength(matrix)
		Para f=0 hasta dimC*(places+5)
			Escribir Sin Saltar "_"
		FinPara
		Para i=0 hasta dimR-1
			Escribir ""
			Para j=0 hasta dimC-1
				h=Longitud(ConvertirATexto(matrix[i,j]))
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
		Escribir""
	SiNo
		Escribir "NI EN PEDO TE DIBUJO ESO..."
	FinSi
FinSubProceso

Funcion maxLength = GetMaxDigitLength(matrix Por Referencia)
	Definir maxLength,i, len Como Entero
	maxLength=0
	Para cada i en matrix
		len=Longitud(ConvertirATexto(i))
		si len>maxLength Entonces
			maxLength=len
		FinSi
	FinPara
FinFuncion


SubProceso DecompressChain(vector Por Referencia, dim, compressedChain)
	Definir i, j,index, backInd,frontInd, num como  Entero
	Definir linea, unPackedChain,pattern  Como Caracter
	backInd=1
	frontInd=1
	Para cada linea de vector
		unPackedChain=""
		pattern=""
		Repetir
			Repetir
				frontInd=frontInd+1
			hasta Que Subcadena(compressedChain,frontInd,frontInd)="}"
			pattern=Subcadena(compressedChain,backInd,frontInd-1)
			si pattern<>"SL" Entonces
				backInd=frontInd+1
				Repetir
					frontInd=frontInd+1
				hasta Que Subcadena(compressedChain,frontInd,frontInd)="{"
				num=ConvertirANumero(Subcadena(compressedChain,backInd,frontInd-1))
				frontInd=frontInd+1
				backInd=frontInd
				Para j=0 hasta num-1
					unPackedChain=unPackedChain+pattern
				FinPara
			FinSi
		Mientras Que pattern<>"SL"		
		linea=unPackedChain
		frontInd=frontInd+2
		backInd=frontInd
	FinPara
FinSubProceso



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
