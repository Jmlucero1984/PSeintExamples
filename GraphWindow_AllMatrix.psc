Algoritmo GraphicWindow
	Definir windowChain,xVal,yVal, char,matrizPuntos Como Caracter
	Definir valuePairsVector,cartesianIntervals,regressionPoints como Real
	Definir cant,i como Entero
	Definir cantValid,parValid como Logico
	Dimension matrizPuntos[21,100]
	Definir windowCharMatrix,resultadoRegression Como Caracter
	Dimension windowCharMatrix[34,130]
	MatricearWindow(windowCharMatrix)
	Para cada char de matrizPuntos hacer char=" "; FinPara
	cant=PedirCantidadDeDatos
	Dimension valuePairsVector[cant,2]
	ObtenerParesDeValores(valuePairsVector, cant)
	Dimension cartesianIntervals[2,3]
	DeterminarRangos(valuePairsVector,cant,cartesianIntervals)
	Dimension regressionPoints[100,100]
	resultadoRegression= RegresionLineal(valuePairsVector,regressionPoints,cartesianIntervals)
	MapearPuntos(valuePairsVector,cant,cartesianIntervals,matrizPuntos,regressionPoints)
	MainWindowDisplay(windowCharMatrix,"GRAPH",cartesianIntervals,matrizPuntos,resultadoRegression)
FinAlgoritmo

 
SubProceso MainWindowDisplay(windowCharMatrix,type,cartesianIntervals,matrizPuntos,resultadoRegression)
	Definir matriz   como Caracter
	Definir mainWindow,char, input como Texto
	Definir dimLines, dimR, dimC,numRec,prevVect,actualVect como Entero
	GetColumnsTheHardWay(windowCharMatrix,dimR,dimC)
	si type="GRAPH" entonces SetNumberInterval(windowCharMatrix,cartesianIntervals,dimR,dimC); FinSI
	//ResetPlotArea(windowCharMatrix)
	PlotearPuntos(windowCharMatrix,matrizPuntos,6)
	ImprimirWindowMatrix(windowCharMatrix)
	Definir optionCols, optionRows Como Entero
	optionCols=2
	optionRows=1
	
	Definir opciones Como Caracter
	Dimension opciones[optionRows,optionCols,2]
	
	Definir opcionesCoords Como Entero
	Dimension opcionesCoords[optionRows,optionCols,2]
 
	SetItemsAndCoords(windowCharMatrix,opciones,opcionesCoords,dimR,dimC,optionRows,optionCols)
 
	 
	Definir descripciones Como Caracter
	Dimension descripciones[2,2]
	
	descripciones[0,0]="INFO"
	descripciones[0,1]=resultadoRegression//"Informacion general de esta aplicacion y de sus utilidades a traves del tiempo"
	descripciones[1,0]="SALIR"
	descripciones[1,1]="           Gracias por usar esta aplicación, esperamos que los resultados obtenidos le hayan sido útiles!"
 
	/// DETERMINACION ZONA DE DESCRIPCION
	Definir commentInsertPoint, longCommentLine, maxLines,lineStartingPoint Como Entero
	commentInsertPoint=0; lineStartingPoint=0; longCommentLine=0; maxLines=0;
	GetCommentZoneDims(windowCharMatrix,dimR,dimC, commentInsertPoint,lineStartingPoint, longCommentLine, maxLines)
	
 
	Dimension prevVect[6]; prevVect[0]=0; prevVect[1]=0; prevVect[2]=0; prevVect[3]=0; prevVect[4]=0; prevVect[5]=0
	//SetOptionVect(prevVect,0,1,1)
	Definir keepCoordx,keepCoordy Como Entero
	Definir selectedOpt Como Caracter
	InicializarItems(windowCharMatrix,prevVect,opciones,opcionesCoords,1,2)
	keepCoordx=0; keepCoordy=0
	SelectItem(windowCharMatrix,opciones,opcionesCoords,prevVect)
	SetNameSelectedOption(selectedOpt,keepCoordy,keepCoordx,opciones)
	SetDescription(windowCharMatrix,dimR,dimC, descripciones,selectedOpt,commentInsertPoint,lineStartingPoint,longCommentLine, maxLines,optionRows*optionCols)
	Repetir
		Limpiar Pantalla
		SelectItem(windowCharMatrix,opciones,opcionesCoords,prevVect)
		SetNameSelectedOption(selectedOpt,keepCoordy,keepCoordx,opciones)
		//ImprimirWindow(mainWindow,dimLines)
		ImprimirWindowMatrix(windowCharMatrix)
		MostrarInstrucciones
		Leer input
		input=Minusculas(input)
		Segun input Hacer
			"a":si keepCoordx>0 Entonces
					keepCoordx=keepCoordx-1
					SetOptionVect(prevVect,keepCoordy,keepCoordx,1)
				FinSi
			"d":si keepCoordx<optionCols-1 Entonces
					keepCoordx=keepCoordx+1
					SetOptionVect(prevVect,keepCoordy,keepCoordx,1)
				FinSi
			"w":si keepCoordy>0 Entonces
					keepCoordy=keepCoordy-1
					SetOptionVect(prevVect,keepCoordy,keepCoordx,1)
				FinSi
			"s":si keepCoordy<optionRows-1 Entonces
					keepCoordy=keepCoordy+1
					SetOptionVect(prevVect,keepCoordy,keepCoordx,1)
				FinSi
		Fin Segun
		SetNameSelectedOption(selectedOpt,keepCoordy,keepCoordx,opciones)
		SetDescription(windowCharMatrix,dimR,dimC, descripciones,selectedOpt,commentInsertPoint,lineStartingPoint,longCommentLine, maxLines,optionRows*optionCols)
		si input="e" Entonces
			Escribir selectedOpt
			ChangeWindow(selectedOpt)
		FinSi
	Hasta Que Minusculas(input)="q"
FinSubProceso



SubProceso SelectItem(mainWindow,opciones,opcionesCoords,prevVect)
	SetItem(mainWindow,opciones,opcionesCoords,prevVect[0],prevVect[1],prevVect[2])
	SetItem(mainWindow,opciones,opcionesCoords,prevVect[3],prevVect[4],prevVect[5])
FinSubProceso

SubProceso SetItem(matriz,opciones,opcionesCoords,itemR,itemC,estado)
	/// InsertStringInMatrix_B_F(matriz,row,col,string,dir)
	InsertStringInMatrix_B_F(matriz, opcionesCoords[itemR,itemC,0],opcionesCoords[itemR,itemC,1], opciones[itemR,itemC,estado],"F")
FinSubProceso
///SetItemsAndCoords(windowCharMatrix,opciones,opcionesCoords,1,2)
SubProceso SetItemsAndCoords(window, opciones, opcionesCoords,dimR,dimC,optRows,optCols )
	Definir linea,char Como Caracter
	Definir i,j,k,p,backPole,row,col,numLine como Entero
	row=0
	Para i=0 hasta dimR-1
	   col=-1
		Para k=0 hasta 2 // Por si tenemos mas de un caracter especial
			si window[i,k]="§" Entonces 
				window[i,k]=" "
				k=2
				Para j=0 hasta dimC-1
					si window[i,j]="§" Entonces
						window[i,j]=" "; col=col+1; backPole=j; char=""; j=j+1
						Repetir
							char=char+window[i,j]; j=j+1
						Hasta que window[i,j]="¤"
						opciones[row,col,0]="  "+char+"   "; opciones[row,col,1]="<["+char+"]>"
						opcionesCoords[row,col,0]=i; opcionesCoords[row,col,1]=backPole
					FinSi
				FinPara
			FinSi
			si col>0 Entonces; row=row+1
			FinSi
		FinPara
	FinPara
FinSubProceso

 
SubProceso ImprimirWindowMatrix(windowMatrix)
	Definir i, j, dimR, dimC como Entero
	GetColumnsTheHardWay(windowMatrix,dimR,dimC)
	Definir lineas, linea Como Caracter
	Dimension lineas[dimR]
	Para i=0 hasta dimR-1
		linea=""
		Para j=0 hasta dimC-1
			linea=linea+windowMatrix[i,j]
		FinPara
		Escribir linea
	FinPara
FinSubProceso

 
SubProceso PlotearPuntos(windowCharMatrix,matrizPuntos,insertionRow)
	Definir col,i,j Como Entero
	Definir char Como Caracter
	i=-1
	Repetir 
		i=i+1; char=windowCharMatrix[insertionRow,i]
	Hasta Que char="-"
	col=i 
	Para i=0 hasta 20
		Para j=0 hasta 99
			si matrizPuntos[i,j]<>" "  entonces
				windowCharMatrix[insertionRow+i,j+col]=matrizPuntos[i,j]
			FinSi
		FinPara
	FinPara
FinSubProceso


 SubProceso ResetPlotArea(matrizPuntos)
	Definir i, j Como Entero
	Definir lineaEjex,lineaEjey,item Como Caracter
	Para cada item de matrizPuntos
		item=" "
	FinPara
	lineaEjex="X---------+---------+---------+---------+---------+---------+---------+---------+---------+---------+"
	lineaEjey="-!-!-!-!-!-!-!-!-!-!-P"
	Para i= 0 hasta 20
		matrizPuntos[i,0]=Subcadena(lineaEjey,i,i)
	FinPara
	Para i=0 hasta 99 Hacer
		matrizPuntos[20,i]=Subcadena(lineaEjex,i,i)
	FinPara
FinSubProceso


SubProceso MapearPuntos(valuePairsVector,cant,cartesianIntervals,matrizPuntos,regressionPoints)
	Definir i, j Como Entero
	Definir lineaEjex,lineaEjey,regChars Como Caracter
	Definir percentx, percenty como Real
	regChars=".·´" 
	Para i=0 hasta 99
		si regressionPoints[1,i]<=cartesianIntervals[1,2] y regressionPoints[1,i]>=cartesianIntervals[1,0] Entonces
			percentx=redon(((regressionPoints[0,i]-cartesianIntervals[0,0])/(cartesianIntervals[0,2]-cartesianIntervals[0,0]))*99)
			percenty=redon(((regressionPoints[1,i]-cartesianIntervals[1,0])/(cartesianIntervals[1,2]-cartesianIntervals[1,0]))*60)		 
			matrizPuntos[20-trunc(percenty/3),percentx]=Subcadena(regChars,percenty%3,percenty%3)
		FinSi
	FinPara
	Para i=0 hasta cant-1
		//Escribir "VALUEX: " valuePairsVector[i,0]
		percentx=redon(((valuePairsVector[i,0]-cartesianIntervals[0,0])/(cartesianIntervals[0,2]-cartesianIntervals[0,0]))*99)
		//EScribir "PERCENTX: " percentx
		percenty=redon(((valuePairsVector[i,1]-cartesianIntervals[1,0])/(cartesianIntervals[1,2]-cartesianIntervals[1,0]))*20)
		//EScribir "PERCENTY: " percenty
		matrizPuntos[20-percenty,percentx]="o"
	FinPara
FinSubProceso


Funcion resultado =  RegresionLineal(datos,regressionPoints, cartesianIntervals)
	Definir i,counter como Entero
	Definir resultado,signo como Caracter
	Definir item,xPot2, _x, _y,_ymed, _xmed, xy, sum_xy, sumy,sumx,sumxPot2, coeff_a, coeff_b como Real
	xPot2=0; xy=0; sum_xy=0; sumy=0; sumx=0; sumxPot2=0; coeff_a=0; coeff_b=0; _ymed=0; _xmed=0; counter=0
	Para cada item de datos hacer counter=counter+1; FinPara
	counter=counter/2
	Para i=0 hasta counter-1
		_x=datos[i,0]; _y=datos[i,1]; sumx=sumx+_x; sumy=sumy+_y; sum_xy=sum_xy+_x*_y; sumxPot2=sumxPot2+_x*_x
	FinPara
	coeff_a=(counter*sum_xy-sumx*sumy)/(counter*sumxPot2-sumx*sumx);  coeff_b=(sumy-coeff_a*sumx)/counter
	_ymed=sumy/counter;  _xmed=sumx/counter
	Definir sum_difX_by_difY, difX,sumDifYpredichos, difY,sumDifY, sumDifX, r,R2 como Real
	sum_difX_by_difY=0; difX=0; difY=0; sumDifY=0; sumDifX=0 ;sumDifYpredichos=0
	Para i=0 hasta counter-1
		difX=difX+(datos[i,0]-_xmed); difY=difY+(datos[i,1]-_ymed); sum_difX_by_difY=sum_difX_by_difY+difX*difY
		sumDifY=sumDifY+difY^2; sumDifX=sumDifX+difX^2; sumDifYpredichos=sumdifYpredichos+((coeff_b+datos[i,0]*coeff_a)-_ymed)^2 
	FinPara
	R2= redon(((sumDifYpredichos/sumDifY)^0.5)*1000)/1000
	r=redon((sum_difX_by_difY/((sumDifY*sumDifX)^0.5))*1000)/1000
	//Escribir  " La coeficiente de correlacion es r = " r
	si coeff_b>=0 Entonces
		signo="+ "
	SiNo
		signo="- "
	FinSi
	resultado = "         La Ec. de Correlación es  y = "+ConvertirATexto(coeff_a)+"·x "+signo+ConvertirATexto(abs(coeff_b))+" r = "+ConvertirATexto(r)+"   R² = "+ConvertirATexto(R2) 
	Para i=0 hasta 99
		item=cartesianIntervals[0,0]+i*cartesianIntervals[0,1]/10
		regressionPoints[0,i]=item
		regressionPoints[1,i]=coeff_b+item*coeff_a
	FinPara
FinFuncion



Funcion framed = FrameNumer_L_H_CH(numer, decimalObjective,dir)
	Definir i como Entero
	Definir framed como Real
	si decimalObjective>0 entonces 
		Para i=0 hasta decimalObjective hacer numer=numer*10; FinPara
	FinSi
	si dir="L" Entonces numer=trunc(numer); FinSi
	si dir="H" Entonces numer=trunc(numer)+1; FinSi
	si dir="CH" Entonces
		si numer - trunc(numer)<0.5 Entonces numer=trunc(numer)+0.5
		SiNo numer=trunc(numer)+1; FinSi
	FinSi
	si decimalObjective>0 entonces 
		Para i=0 hasta decimalObjective hacer numer=numer/10; FinPara
	FinSi
	framed=numer
FinFuncion


Funcion zerosAfter = GetZerosAfterComma(numer)
	Definir zerosAfter Como Entero
	zerosAfter=-1
	Repetir
		zerosAfter=zerosAfter+1
		numer=numer*10
	Hasta Que trunc(numer)>0
FinFuncion


SubProceso DeterminarRangos(valuePairsVector,dim,cartesianIntervals)
	Definir i, minX, maxX,miny,maxY, rangex, stepx, rangey,stepy Como Real
	minX=(2^31)-1; minY=minX
	maxX=-(2^31); maxY=maxX
	Para i =0 Hasta dim-1
		si valuePairsVector[i,1]>maxY Entonces maxY=valuePairsVector[i,1]; FinSi
		si valuePairsVector[i,1]<minY Entonces minY=valuePairsVector[i,1]; FinSi
		si valuePairsVector[i,0]>maxX Entonces maxX=valuePairsVector[i,0]; FinSi
		si valuePairsVector[i,0]<minX Entonces minX=valuePairsVector[i,0]; FinSi
	FinPara
	rangex=maxX-minX; rangey=maxY-minY
	stepx=rangex/10; stepy=rangey/10
	Escribir "stepx: " stepx
	Escribir "stepy: " stepy
	Escribir "El rango de los x = " maxX-minX
	Escribir "El rango de los y = " maxY-minY
	stepx=FrameNumer_L_H_CH(stepx, GetZerosAfterComma(stepx)+1,"CH")
	stepy=FrameNumer_L_H_CH(stepy, GetZerosAfterComma(stepy)+1,"CH")
	Escribir "stepx: " stepx
	Escribir "stepy: " stepy
	minX=FrameNumer_L_H_CH(minX, GetZerosAfterComma(stepx),"L")
	si minX+10*stepx<maxX Entonces
		stepx=FrameNumer_L_H_CH(stepx, GetZerosAfterComma(stepx),"CH")
		maxX=10*stepx
	FinSi
	minY=FrameNumer_L_H_CH(minY, GetZerosAfterComma(stepy),"L")
	si minY+10*stepy<maxY Entonces
		stepy=FrameNumer_L_H_CH(stepy, GetZerosAfterComma(stepy),"CH") 
		maxY=10*stepy
	FinSi
	Escribir "-------------------------RESUMEN-----------------------------------------"
	Escribir "                minX: " minX   " stepx: " stepx "  maxX: " minX+10*stepx
	Escribir "                minY: " minY   " stepy: " stepy "  maxY: " minY+10*stepy
	Escribir "-------------------------------------------------------------------------"
	cartesianIntervals[0,0]=minX; cartesianIntervals[0,1]=stepx; cartesianIntervals[0,2]=minX+10*stepx; 
	cartesianIntervals[1,0]=minY; cartesianIntervals[1,1]=stepy; cartesianIntervals[1,2]=minY+10*stepy
FinSubProceso

SubProceso SetNumberInterval(windowCharMatrix,cartesianIntervals,dimR,dimC)
	Definir linea,char, leftStrip,rightStrip,numText, xline Como Caracter
	Definir i,j,iter  como Entero
	Definir k como Real
	k=-1
	Para i=0 hasta dimR-1
		si windowCharMatrix[i,0] ="#" Entonces
			windowCharMatrix[i,0]=" "
			k=k+1; iter=-1
			Repetir
				iter=iter+1; char=windowCharMatrix[i,iter]
			Hasta Que char="<"
			numText=ConvertirATexto(cartesianIntervals[1,2]-k*cartesianIntervals[1,1])
			InsertStringInMatrix_B_F(windowCharMatrix,i,iter,numText,"B")
		FinSi
		si windowCharMatrix[i,0] ="@" Entonces
			windowCharMatrix[i,0]=" "
			iter=-1; k=0
			Para j=0 hasta 10
				Repetir
					iter=iter+1; 
					char=windowCharMatrix[i,iter]
				Hasta Que char="<"
				numText=ConvertirATexto(cartesianIntervals[0,0]+j*cartesianIntervals[0,1])
				InsertStringInMatrix_B_F(windowCharMatrix,i,iter,numText,"B")
			FinPara
		FinSi
	FinPara
FinSubProceso




SubProceso InsertStringInMatrix_B_F(matriz,row,col,string,dir)
	Definir long,i,j Como Entero
	long=Longitud(string)
	si dir ="B" Entonces
		col=col+1
		Para i=0 hasta long-1
			matriz[row,col-long+i] = Subcadena(string,i,i)
		FinPara
	FinSi
	si dir ="F" Entonces
		Para i=0 hasta long-1
			matriz[row,col+i] = Subcadena(string,i,i)
		FinPara
	FinSi
FinSubProceso

SubProceso SetDescription(matrixWindow,dimR,dimC, descripciones, selectedOpt,commentInsertPoint,lineStartingPoint,longCommentLine, maxLines,totalDescs)
	Definir i,j,u como Entero
	Definir descVector, description,char,leftStrip, rightStrip  Como Caracter
	Dimension descVector[maxLines]
	Para cada description de descVector
		description=""
	FinPara
	Para i=0 hasta totalDescs-1
		Escribir  descripciones[i,0]
		si selectedOpt=descripciones[i,0] Entonces description=descripciones[i,1]
		FinSi
	FinPara
	Para i=0 hasta maxLines-1
		si Longitud(description)<=longCommentLine Entonces
			descVector[i]=description
			i=maxLines-1
		SiNo
			si Subcadena(description,longCommentLine,longCommentLine)=" " Entonces
				descVector[i]=Subcadena(description,0,longCommentLine)
				description=Subcadena(description,longCommentLine,Longitud(description)-1)
				description=RemoveWhiteSpaces(description,Verdadero,Falso)
			SiNo
				j=longCommentLine
				Repetir
					j=j-1; char=Subcadena(description,j,j)
				Hasta Que char=" "
				descVector[i]=Subcadena(description,0,j)
				description=Subcadena(description,j+1,Longitud(description)-1)
			FinSi
			si i=maxLines-1 y Longitud(description)<>0 Entonces
				j=Longitud(descVector[i])-1
				u=0
				Repetir
					u=u+1; j=j-1
					char=Subcadena(descVector[i],j,j)
				Mientras Que u<3 o char=" "
				descVector[i]=Subcadena(descVector[i],0,j)+"..."
			FinSi
		FinSi
	FinPara
	Definir emptyLine Como Caracter
	emptyLine=""
	Para i=0 hasta dimC-1
		emptyLine=emptyLine+matrixWindow[commentInsertPoint-1,i]
	FinPara
	Para i=0 hasta maxLines-1
		InsertStringInMatrix_B_F(matrixWindow,commentInsertPoint+i,0,emptyLine,"F")
		si descVector[i]<>"" Entonces InsertStringInMatrix_B_F(matrixWindow,commentInsertPoint+i,lineStartingPoint,descVector[i],"F"); FinSi
	FinPara
	
FinSubProceso

SubProceso GetCommentZoneDims(windowCharMatrix, dimR,dimC,commentInsertPoint Por Referencia, lineStartingPoint Por Referencia, longCommentLine Por Referencia, maxLines Por Referencia)
	Definir i,j, marks Como Entero
	Definir char Como Caracter
	marks=0;  
	Para i=0 hasta dimR-1
		si windowCharMatrix[i,0]="»"
			windowCharMatrix[i,0]=" "
			si marks=0 Entonces
				marks=1; commentInsertPoint=i; j=-1
				Repetir
					j=j+1; char=windowCharMatrix[i,j]
				Hasta Que char="|"
				lineStartingPoint=j+5
				Repetir
					j=j+1; char=windowCharMatrix[i,j]
				Hasta Que char="|"
				longCommentLine=j-lineStartingPoint-6
			SiNo
				maxLines=i-commentInsertPoint+1
			FinSi 
		FinSi
	FinPara
FinSubProceso


SubProceso MostrarInstrucciones
	Escribir "                     Utilice teclas A S D W para moverse por el menu, tecla E para confimar o Q para interrumpir, "
	Escribir "                                  Introduzca de a una instrucción a la vez, presionando ENTER para ejecutar..."
	Escribir "                                              --------------v------------v--------------     "     
	Escribir "                                           /    Q - Quit    | W - Arriba |  E - CONFIRM   \  "
	Escribir "                                           ---------------- + ---------- + ----------------  "
	Escribir "                                           \  A - Izquierda | S - Abajo  |  D - Derecha   /  "
	Escribir "                                             ---------------^------------^---------------    " 
FinSubProceso

SubProceso InicializarItems(mainWindow,prevVect,opciones,opcionesCoords,dimR,dimC)
	Definir i,j Como Entero
	Para i=0 hasta dimR-1
		Para j=0 hasta dimC-1
			SetOptionVect(prevVect,i,j,1)
			SelectItem(mainWindow,opciones,opcionesCoords,prevVect)
		FinPara
	FinPara
	SetOptionVect(prevVect,0,0,1)
FinSubProceso

SubProceso ChangeWindow(selectedOpt)
	Escribir "Entrando con " selectedOpt
	Segun selectedOpt Hacer
		"OPCION 1":
			Escribir "Ha seleccionado opcion 1"
			//MainWindowDisplay(GraphSecondWindowToChain())
		"OPCION 2":
			Escribir "Ha seleccionado opcion 2"
		"OPCION 3":
			Escribir "Ha seleccionado opcion 3"
		"OPCION 4":
			Escribir "Ha seleccionado opcion 4"
		"OPCION 5":
			Escribir "Ha seleccionado opcion 5"
		De Otro Modo:
			Escribir "OPCION POR DEFECTO"
	Fin Segun
 
FinSubProceso

SubProceso SetNameSelectedOption(selectedOpt Por Referencia, keepCoordy,keepCoordx,opciones)
	selectedOpt = RemoveWhiteSpaces(opciones[keepCoordy,keepCoordx,0],Verdadero,Verdadero)
FinSubProceso

SubProceso SetOptionVect(prevVect,ny,nx,ns)
	prevVect[0]=prevVect[3]; prevVect[1]=prevVect[4]; prevVect[2]=0; 
	prevVect[3]=ny; prevVect[4]=nx; prevVect[5]=ns
FinSubProceso
 
Funcion stripped =  RemoveWhiteSpaces(string Por Referencia,left,right)
	Definir i, j como  Entero
	Definir char,stripped Como Caracter
	i=0; j=Longitud(string)-1
	si left Entonces
		i=-1
		Repetir
			i=i+1; char=subcadena(string,i,i)
		Hasta Que char<>" "
	FinSi
	si right entonces
		j=Longitud(string)
		Repetir
			j=j-1; char=subcadena(string,j,j)
		Hasta Que char<>" "
	FinSi
	stripped=Subcadena(string,i,j)
FinSubProceso
 
 
Funcion cantidad = PedirCantidadDeDatos()
	Definir cantidad como Entero
	Definir char Como Caracter
	Definir cantValid como Logico
	Repetir
		Escribir "Introduzca la cantidad de pares de valores X-Y para regresion (max 30)"
		Leer char
		cantValid=ValidarNum_E_P_N__limit(char,"P",30)
		si !cantValid Entonces
			Escribir "El numero ingresado no es válido o excede el limite, reintente..."
		FinSi
	Hasta que cantValid
	cantidad=ConvertirANumero(char)
FinFuncion
 
SubProceso ObtenerParesDeValores(valuePairsVector, cant)
	Definir i Como Entero
	Definir parValid Como Logico
	Definir xVal,yVal Como Caracter
	Para i=0 hasta cant-1
		Limpiar Pantalla
		Escribir "Introduzca cada uno de los pares X-Y (0 <= Reales <= 100)"
		si i>0 Entonces
			PresentarMatrixDatos(valuePairsVector,i)
		FinSi
		Repetir
			Escribir "Par de valores N° " i+1
			Escribir "Ingrese el valor de X, ENTER, el valor de Y, ENTER nuevamente..."
			Leer xVal,yVal
			parValid=ValidarNum_E_P_N__limit(xVal,"P",100) y ValidarNum_E_P_N__limit(yVal,"P",100)
			si !parValid Entonces
				Escribir "Al menos unos de los valores ingresados no es válido.... Reintente..."
			FinSi
		Hasta que parValid
		valuePairsVector[i,0] = ConvertirANumero(xVal)
		valuePairsVector[i,1] = ConvertirANumero(yVal)
	FinPara
FinSubProceso

SubProceso DataFindRowsAndColumns(cant,filas Por Referencia,columnas Por Referencia)
	si cant<9 Entonces
		columnas=1
		filas=cant
	SiNo
		si cant<=16 Entonces
			columnas =2
			si cant%2=0 Entonces
				filas=cant/2
			SiNo
				filas=(cant+1)/2
			FinSi
		SiNo
			si cant<=22 Entonces
				columnas =3
				si cant%2=0 Entonces
					filas=cant/2
				SiNo
					filas=(cant+1)/2
				FinSi
			SiNo
				columnas=4
				filas=8
			FinSi
		FinSi
	FinSi
FinSubProceso

SubProceso PresentarMatrixDatos(data, cant)
	Definir columnas, filas, minWidthx, minWidthy, r,c Como Entero
	Definir matriz Como Caracter
	minWidthx=GetMaxLenght(data,cant,0)+2
	minWidthy=GetMaxLenght(data,cant,1)+2
	DataFindRowsAndColumns(cant,filas,columnas)
	Definir anchoColumna,cantLineas,i,j, interColumna Como Entero
	Definir interCell, item Como Caracter
	si minWidthx <6 Entonces minWidthx=6; FinSi
	si minWidthy <7 Entonces minWidthy=7; FinSi
	interColumna=6
	anchoColumna=3+interColumna+minWidthx+minWidthy
	cantLineas=3+2*filas
	Dimension matriz[cantLineas,10+columnas*anchoColumna]
	Para cada item de matriz hacer item=" "; FinPara
	interCell=""
	Para i=1 hasta anchoColumna -interColumna Hacer interCell=interCell+"-"; FinPara
	Para i=0 hasta cantLineas-1 Con Paso 2
		Para j=0 hasta columnas-1
			InsertStringInMatrix_B_F(matriz,i,10+j*anchoColumna,interCell,"F")
		FinPara
	FinPara
	interCell=GetRowDefaultContent_Header_Values(minWidthx,minWidthy,"Header")
	Definir index,k como Entero
	k=-1
	Para i=1 hasta cantLineas-1 Con Paso 2
		Para j=0 hasta columnas-1
			si i=1 entonces
				interCell=GetRowDefaultContent_Header_Values(minWidthx,minWidthy,"Header")
				InsertStringInMatrix_B_F(matriz,i,10+j*anchoColumna,interCell,"F")
			SiNo
				interCell=GetRowDefaultContent_Header_Values(minWidthx,minWidthy,"Values")
				InsertStringInMatrix_B_F(matriz,i,10+j*anchoColumna,interCell,"F")
				index=(k)+j*filas
				//EScribir filas
				si index<cant Entonces
					//Escribir "i, j, k, index  " i " " j " " k " "  index
					InsertStringInMatrix_B_F(matriz,i,10+j*anchoColumna+minWidthx-1,ConvertirATexto(data[index,0]),"B")
					InsertStringInMatrix_B_F(matriz,i,10+j*anchoColumna+minWidthx+1+minWidthy-1,ConvertirATexto(data[index,1]),"B")
				FinSi
				
			FinSi
		FinPara
		k=k+1
	FinPara
	ImprimirWindowMatrix(matriz)
FinSubProceso

Funcion maxLength = GetMaxLenght(data,cant,index)
	Definir maxLength, i, long Como Entero
	maxLength=0
	Para i=0 hasta cant-1
		long=Longitud(ConvertirATexto(data[i,index]))
		si long>maxLength Entonces	maxLength=long; FinSi
	FinPara
FinFuncion



SubProceso GetFalseData(data,cant)
	data[0,0]=	1   	 	;  	data[0,1]=	3
	data[1,0]=	2.1   		; 	data[1,1]=	3.5
	data[2,0]=	2.5   		;  	data[2,1]=	3.6
	data[3,0]= 	3   		;  	data[3,1]=	4.5
	data[4,0]=	3.23    	;  	data[4,1]=	4.5
	data[5,0]=	3.235    	;  	data[5,1]=	6.2356
	data[6,0]=	3.2653    	;  	data[6,1]=	6.25
	data[7,0]=	5.23656   	;  	data[7,1]=	2.5
	data[8,0]=	5.28    	;  	data[8,1]=	2.5
	data[9,0]=	5.3    		;  	data[9,1]=	2.5
	data[10,0]=	555.23656   ;  	data[10,1]=	2.5
	data[11,0]=	556    		;  	data[11,1]=	6645452.5
	data[12,0]=	5600   		;	data[12,1]=	2.5
	data[13,0]=	6000    	;  	data[13,1]=	2.5
	data[14,0]=	6050   		;  	data[14,1]=	2.5
	data[15,0]=	60536.562   ;  	data[15,1]=	2.5
	data[16,0]=	78095.56  	;  	data[16,1]=	2.5
	data[17,0]=	1505230   	;  	data[17,1]=	2.5
FinSubProceso


Funcion interCell=  GetRowDefaultContent_Header_Values(minWidthx,minWidthy,type)
	Definir interCell Como Caracter
	Definir i como Entero
	interCell="|"
	Para i=1 hasta minWidthx
		si type = "Header" Entonces
			si i=trunc(minWidthx/2)+1 Entonces interCell=interCell+"X"; SiNo interCell=interCell+" "; FinSi
			SiNo interCell=interCell+" "; FinSi
		FinPara
		interCell=interCell+"|"
		Para i=1 hasta minWidthy
			si type = "Header" Entonces
				si i=trunc(minWidthy/2)+1 Entonces interCell=interCell+"Y"; sino interCell=interCell+" "; FinSi
				sino; interCell=interCell+" "; FinSi
			FinPara
			interCell=interCell+"|"	
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


Funcion valido <- ValidarNum_E_P_N__limit ( variable, modoOption, limit )
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
			si Subcadena(variable,i,i)=Subcadena(charValidos,j,j) Entonces valido=Verdadero
				si Subcadena(charValidos,j,j)="-" y i<>0 Entonces valido=Falso
				FinSi
			FinSi
			j=j+1
		Mientras Que j<Longitud(charValidos)
		i=i+1
	Mientras Que i<Longitud(variable) y valido
	si valido entonces
		Segun modoOption Hacer
			"P":si Subcadena(variable,0,0)="-" Entonces valido=Falso
				FinSi
			"N":si Subcadena(variable,0,0)<>"-" Entonces valido=Falso
				FinSi
			"E":Para i=0 hasta Longitud(variable)
					si Subcadena(variable,i,i)="." Entonces valido=Falso
					FinSi
				FinPara
		FinSegun
	FinSi
	si valido Entonces
		si ConvertirANumero(variable)>limit Entonces valido=Falso
		FinSi
	FinSi
Fin Funcion




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


SubProceso MatricearWindow(windowCharMatrix) 
	/// Por el momento, debe haber igual cantidad de opciones en todas las columnas
	/// Cada item debe estar precedido por § y terminado con ¤, de manera tal de que
	/// las matrices de opciones y de coordenadas de las mismas se generen automaticamente
	Definir vl,vr,windowCharChained,item Como Caracter
	Definir cols,i,j como Entero
	Dimension vl[34]  
	vl[0]=  "                                                                                                                                  "
	vl[1]=  "        *========================================================================================================================*"
	vl[2]=  "£       |                                                PLOTEO DE REGRESION                                                     |"
	vl[3]=  "        |------------------------------------------------------------------------------------------------------------------------|"
	vl[4]=  "        |        (Y) ^                                                                                                           |"
	vl[5]=  "        |            !                                                                                                           |"
	vl[6]=  "#       |          < -                                                                                                           |"
	vl[7]=  "        |            !                                                                                                           |"
	vl[8]=  "#       |          < -                                                                                                           |"
	vl[9]=  "        |            !                                                                                                           |"
	vl[10]= "#       |          < -                                                                                                           |"
	vl[11]= "        |            !                                                                                                           |"
	vl[12]= "#       |          < -                                                                                                           |"
	vl[13]= "        |            !                                                                                                           |"
	vl[14]= "#       |          < -                                                                                                           |"
	vl[15]= "        |            !                                                                                                           |"
	vl[16]= "#       |          < -                                                                                                           |"
	vl[17]= "        |            !                                                                                                           |"
	vl[18]= "#       |          < -                                                                                                           |"
	vl[19]= "        |            !                                                                                                           |"
	vl[20]= "#       |          < -                                                                                                           |"
	vl[21]= "        |            !                                                                                                           |"
	vl[22]= "#       |          < -                                                                                                           |"
	vl[23]= "        |            !                                                                                                           |"
	vl[24]= "#       |          < -                                                                                                           |"
	vl[25]= "        |            !                                                                                                           |"
	vl[26]= "#       |          < x---------+---------+---------+---------+---------+---------+---------+---------+---------+---------+--->   |"
	vl[27]= "@       |            <         <         <         <         <         <         <         <         <         <         <  (X)  |"
	vl[28]= "        |                                                                                                                        |"
	vl[29]= "»       |                                                                                                                        |"
	vl[30]= "»       |                                                                                                                        |"
	vl[31]= "        |------------------------------------------------------------------------------------------------------------------------|"
	vl[32]= "§       |                                       §INFO¤                             §SALIR¤                                       |"
    vl[33]= "        *========================================================================================================================*"
	cols=Longitud(vl[1])
	Para i=0 hasta 33
		Para j=0 hasta cols-1
			windowCharMatrix[i,j]=Subcadena(vl[i],j,j)
		FinPara
	FinPara
FinSubProceso