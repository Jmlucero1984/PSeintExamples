Algoritmo MenuGrafico
	Definir lineaMainWindow Como Caracter
	lineaMainWindow=GraphMainWindowToChain()
	MainWindowDisplay(lineaMainWindow)
FinAlgoritmo


SubProceso MainWindowDisplay(lineaWindow)
	Definir matriz, descripciones  como Caracter
	Definir mainWindow,char, input como Texto
	Definir dimLines, dimh, dimv,numRec,prevVect,actualVect como Entero
	
	/// CREACION DEL MENU PRINCIPAL
 
	dimLines=0; dimv=0 ;dimh=0
	ObtenerDimensiones(lineaWindow,dimLines,dimv, dimh)
	Dimension descripciones[dimv*dimh,2]
	Dimension mainWindow[dimLines]
	CrearWindow(mainWindow, lineaWindow,dimLines,dimv,dimh,descripciones)
	
	
	/// PRINCIPALES MATRICES DE OPCIONES 
	Definir opciones Como Caracter
	Dimension opciones[dimv,dimh,2]
	
	Definir opcionesCoords Como Entero
	Dimension opcionesCoords[dimv,dimh,2]
	SetItemsAndCoords(mainWindow,opciones,opcionesCoords)
	
	/// DETERMINACION ZONA DE DESCRIPCION
	Definir commentInsertPoint, longCommentLine, maxLines,lineStartingPoint Como Entero
	commentInsertPoint=0; lineStartingPoint=0; longCommentLine=0; maxLines=0;
	GetCommentZoneDims(mainWindow,commentInsertPoint,lineStartingPoint, longCommentLine, maxLines)
	
	
	
	Dimension prevVect[6]; prevVect[0]=0; prevVect[1]=0; prevVect[2]=0; prevVect[3]=0; prevVect[4]=0; prevVect[5]=0
	SetOptionVect(prevVect,0,0,1)
	Definir keepCoordx,keepCoordy Como Entero
	Definir selectedOpt Como Caracter
	InicializarItems(mainWindow,prevVect,opciones,opcionesCoords,dimv,dimh)
	keepCoordx=0; keepCoordy=0
	Repetir
		Limpiar Pantalla
		SelectItem(mainWindow,opciones,opcionesCoords,prevVect)
		SetNameSelectedOption(selectedOpt,keepCoordy,keepCoordx,opciones)
		ImprimirWindow(mainWindow,dimLines)
		MostrarInstrucciones
		Leer input
		input=Minusculas(input)
		Segun input Hacer
			"a":
				si keepCoordx>0 Entonces
					keepCoordx=keepCoordx-1
					SetOptionVect(prevVect,keepCoordy,keepCoordx,1)
				FinSi
			"d":
				si keepCoordx<dimh-1 Entonces
					keepCoordx=keepCoordx+1
					SetOptionVect(prevVect,keepCoordy,keepCoordx,1)
				FinSi
			"w":
				si keepCoordy>0 Entonces
					keepCoordy=keepCoordy-1
					SetOptionVect(prevVect,keepCoordy,keepCoordx,1)
				FinSi
			"s":
				si keepCoordy<dimv-1 Entonces
					keepCoordy=keepCoordy+1
					SetOptionVect(prevVect,keepCoordy,keepCoordx,1)
				FinSi
		Fin Segun
		SetNameSelectedOption(selectedOpt,keepCoordy,keepCoordx,opciones)
		SetDescription(mainWindow,descripciones,selectedOpt,commentInsertPoint,lineStartingPoint,longCommentLine, maxLines,dimv*dimh)
		si input="e" Entonces
			Escribir selectedOpt
			ChangeWindow(selectedOpt)
		FinSi
	Hasta Que Minusculas(input)="q"
FinSubProceso
 
SubProceso SetDescription(mainWindow,descripciones, selectedOpt,commentInsertPoint,lineStartingPoint,longCommentLine, maxLines,totalDescs)
	Definir i,j,u como Entero
	Definir descVector, description,char,leftStrip, rightStrip  Como Caracter
	Dimension descVector[maxLines]
	Para cada description de descVector
		description=""
	FinPara
	Para i=0 hasta totalDescs-1
		si selectedOpt=descripciones[i,0] Entonces
			description=descripciones[i,1]
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
					j=j-1
					char=Subcadena(description,j,j)
				Hasta Que char=" "
				descVector[i]=Subcadena(description,0,j)
				description=Subcadena(description,j+1,Longitud(description)-1)
			FinSi
			si i=maxLines-1 y Longitud(description)<>0 Entonces
				j=Longitud(descVector[i])-1
				u=0
				Repetir
					u=u+1
					j=j-1
					char=Subcadena(descVector[i],j,j)
				Mientras Que u<3 o char=" "
				
				descVector[i]=Subcadena(descVector[i],0,j)+"..."
			FinSi
		FinSi
	FinPara
//	Para cada description de descVector
//		Escribir description
//	FinPara
	
	Definir emptyLine Como Caracter
	emptyLine=mainWindow[commentInsertPoint-1]
	Para i=0 hasta maxLines-1
		mainWindow[commentInsertPoint+i]=emptyLine
		si descVector[i]<>"" Entonces
			//Escribir descVector[i]+"//"
			leftStrip=subcadena(mainWindow[commentInsertPoint+i],0,lineStartingPoint)
			rightStrip=subcadena(mainWindow[commentInsertPoint+i],Longitud(leftStrip)+Longitud(descVector[i]),Longitud(mainWindow[commentInsertPoint+i]))
			//Escribir rightStrip+"/-/"
			mainWindow[commentInsertPoint+i]=leftStrip+descVector[i]+rightStrip
			
		FinSi
	FinPara
 
FinSubProceso
 
SubProceso GetCommentZoneDims(mainWindow,commentInsertPoint Por Referencia, lineStartingPoint Por Referencia, longCommentLine Por Referencia, maxLines Por Referencia)
	Definir i,j, marks Como Entero
	Definir linea,char Como Caracter
	marks=0
	i=-1
	Para cada linea de mainWindow
		i=i+1
		char=Subcadena(mainWindow[i],0,0)
		si char="»" Entonces
			si marks=0 Entonces
				marks=1
				commentInsertPoint=i
				j=-1
				Repetir
					j=j+1
					char=subcadena(mainWindow[i],j,j)
				Hasta Que char="|"
				lineStartingPoint=j+2
			 
				Repetir
					j=j+1
					char=subcadena(mainWindow[i],j,j)
				Hasta Que char="|"
				longCommentLine=j-lineStartingPoint-3
				 
			SiNo
				maxLines=i-commentInsertPoint+1
			FinSi
			
			linea=" "+Subcadena(mainWindow[i],1,Longitud(mainWindow[i])-1)
		FinSi
		
	FinPara
//	Escribir "commentInsertPoint: " commentInsertPoint
//	EScribir "maxLines: " maxLines
//	Escribir "longCommentLine:" longCommentLine
 
FinSubProceso


SubProceso MostrarInstrucciones
	Escribir "  Utilice teclas A S D W para moverse por el menu, tecla E para confimar o Q para interrumpir, "
	Escribir "  Introduzca de a una instrucción a la vez, presionando ENTER para ejecutar..."
	Escribir "                           --------------v------------v--------------     "     
	Escribir "                        /    Q - Quit    | W - Arriba |  E - CONFIRM   \  "
	Escribir "                        ---------------- + ---------- + ----------------  "
	Escribir "                        \  A - Izquierda | S - Abajo  |  D - Derecha   /  "
	Escribir "                          ---------------^------------^---------------    " 
FinSubProceso

SubProceso InicializarItems(mainWindow,prevVect,opciones,opcionesCoords,dimv,dimh)
	Definir i,j Como Entero
	Para i=0 hasta dimv-1
		Para j=0 hasta dimh-1
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
			 
			MainWindowDisplay(GraphSecondWindowToChain())
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
	prevVect[0]=prevVect[3]
	prevVect[1]=prevVect[4]
	prevVect[2]=0
	prevVect[3]=ny
	prevVect[4]=nx
	prevVect[5]=ns
FinSubProceso

SubProceso  ObtenerDimensiones ( windowChain Por Referencia,dimLines Por Referencia, dimR Por Referencia, dimC Por Referencia)
	Definir linea,char,windowFragment Como Caracter
	Definir i,j,k,cantByLine Como Entero
	Definir founded como Logico
	dimC=0; dimR=0; j=0; dimLines=0
	j=-1
	Repetir
		j=j+1
		char= Subcadena(windowChain,j,j)
	Hasta Que char="¢"
	windowFragment=Subcadena(windowChain,0,j)
	j=0
	Para i=0 hasta Longitud(windowFragment)-1
		char= Subcadena(windowFragment,i,i)
		si char="¶" Entonces
			cantByLine=0
			founded=Falso
			linea =Subcadena(windowFragment,j,i-1)
			dimLines=dimLines+1
			Para k=0 hasta Longitud(linea)-1
				si Subcadena(linea,k,k)="§" Entonces
					founded=Verdadero
					cantByLine=cantByLine+1
				FinSi
			FinPara
			si cantByLine>dimC Entonces
				dimC=cantByLine
			FinSi
			si founded Entonces
				dimR=dimR+1
			FinSi
		i=i+1; j=i
		FinSi
	FinPara
Fin Subproceso

Funcion windowCharChained = GraphMainWindowToChain()
	/// Por el momento, debe haber igual cantidad de opciones en todas las columnas
	/// Cada item debe estar precedido por § y terminado con ¤, de manera tal de que
	/// las matrices de opciones y de coordenadas de las mismas se generen automaticamente
	Definir vl,vr,windowCharChained,item Como Caracter
	Dimension vl[16]  
	vl[0]=  "                                                                                        "
	vl[1]=  "        *==============================================================================*"
	vl[2]=  "        |                               MENU PRINCIPAL                                 |"
	vl[3]=  "        |------------------------------------------------------------------------------|"
	vl[4]=  "        |            §OPCION 1¤                               §OPCION 5¤               |"
	vl[5]=  "        |              §OPCION 2¤                           §OPCION 6¤                 |"
	vl[6]=  "        |                §OPCION 3¤                       §OPCION 7¤                   |"
	vl[7]=  "        |                  §OPCION 4¤                   §OPCION 8¤                     |"
	vl[8]=  "        |                                                                              |"
	vl[9]=  "        |                                                                              |"
	vl[10]= "        |                                                                              |"
	vl[11]= "»       |                                                                              |"
	vl[12]= "»       |                                                                              |"
	vl[13]= "        |------------------------------------------------------------------------------|"
	vl[14]= "        |                     §INFO¤                     §SALIR¤                       |"
	vl[15]= "        *==============================================================================*"
	windowCharChained=""
	Para cada item de vl
		windowCharChained=windowCharChained+item+"¶"
	FinPara
	windowCharChained=windowCharChained+"¢"
	Dimension vr[10]
	vr[0]="OPCION 1¥Descripción de la opción 1, que en este caso no es más que un texto genérico para demostrar como se puede establecer una referencia en la parte baja de esta ventana"
	vr[1]="OPCION 2¥Respecto de la opción 2, no olvide que usted puede en todo momento entrar y salir sin ningun compromiso"
	vr[2]="OPCION 3¥So you have intentions to get into this one, but remember that if you are not sure..."
	vr[3]="OPCION 4¥Concise description about the fourth option before being selected"
	vr[4]="OPCION 5¥As you can see, it doesnt matter the alignment of the options..."
	vr[5]="OPCION 6¥You can add more columns if you want, but the all options must emulate a matrix with no empty slots"
	vr[6]="OPCION 7¥If you have quite longer description you will note that the program will try to fit the lines, applying elipsis if it were necessary, but in case that you"
	vr[7]="OPCION 8¥A little bit tire about descriptions?"
	vr[8]="INFO¥Informacion general de esta aplicacion y de sus utilidades a traves del tiempo"
	vr[9]="SALIR¥La forma más directa de salir de una ventana secundaria o del programa si asi lo desea..."
	Para cada item de vr
		windowCharChained=windowCharChained+item+"¶"
	FinPara
	
	
FinFuncion

Funcion windowCharChained = GraphSecondWindowToChain()
	/// Por el momento, debe haber igual cantidad de opciones en todas las columnas
	/// Cada item debe estar precedido por § y terminado con ¤, de manera tal de que
	/// las matrices de opciones y de coordenadas de las mismas se generen automaticamente
	Definir vl,vr,windowCharChained,item Como Caracter
	Dimension vl[19]  
	vl[0]=  "                                                                                  "
	vl[1]=  "        *==============================================================================*"
	vl[2]=  "        |                            VENTANA SECUNDARIA                                |"
	vl[3]=  "        |------------------------------------------------------------------------------|"
	vl[4]=  "        |                                                                              |"
	vl[5]=  "        |          :::    ::: :::::::::: :::        :::         ::::::::  :::          |"                                                                                                      
	vl[6]=  "        |          :+:    :+: :+:        :+:        :+:        :+:    :+: :+:          |"                                                                                                     
	vl[7]=  "        |          +:+    +:+ +:+        +:+        +:+        +:+    +:+ +:+          |"                                                                                                     
	vl[8]=  "        |          +#++:++#++ +#++:++#   +#+        +#+        +#+    +:+ +#+          |"
	vl[9]=  "        |          +#+    +#+ +#+        +#+        +#+        +#+    +#+ +#+          |"
	vl[10]= "        |          #+#    #+# #+#        #+#        #+#        #+#    #+#              |"
	vl[11]= "        |          ###    ### ########## ########## ##########  ########  ###          |"
	vl[12]= "        |                                                                              |"
	vl[13]= "»       |                                                                              |"
	vl[14]= "        |                                                                              |"
	vl[15]= "»       |                                                                              |"
	vl[16]= "        |------------------------------------------------------------------------------|"
	vl[17]= "        |                   §INFO¤                       §SALIR¤                       |"
	vl[18]= "        *==============================================================================*"
	windowCharChained=""
	Para cada item de vl
		windowCharChained=windowCharChained+item+"¶"
	FinPara
	windowCharChained=windowCharChained+"¢"
	Dimension vr[2]
	vr[0]="INFO¥Informacion general de esta aplicacion y de sus utilidades a traves del tiempo"
	vr[1]="SALIR¥La forma más directa de salir de una ventana secundaria o del programa si asi lo desea..."
	Para cada item de vr
		windowCharChained=windowCharChained+item+"¶"
	FinPara
	
	
FinFuncion




SubProceso SelectItem(mainWindow,opciones,opcionesCoords,prevVect)
	SetItem(mainWindow,opciones,opcionesCoords,prevVect[0],prevVect[1],prevVect[2])
	SetItem(mainWindow,opciones,opcionesCoords,prevVect[3],prevVect[4],prevVect[5])
FinSubProceso

SubProceso SetItem(mainWindow,opciones,opcionesCoords,itemR,itemC,estado)
	Definir strip,leftStrip, rightStrip,patch Como Caracter
	Definir initStrip Como Entero
	strip=mainWindow[opcionesCoords[itemR,itemC,0]]
	initStrip=opcionesCoords[itemR,itemC,1]
	patch= opciones[itemR,itemC,estado]
	leftStrip=Subcadena(strip,0,initStrip-1)
	rightStrip=Subcadena(strip,initStrip+Longitud(patch),Longitud(strip)-1)
	strip=leftStrip+patch+rightStrip
	mainWindow[opcionesCoords[itemR,itemC,0]]=strip
FinSubProceso

SubProceso SetItemsAndCoords(window, opciones, opcionesCoords)
	Definir linea,char Como Caracter
	Definir i,backPole,row,col,numLine como Entero
	numLine=-1; row=0
	Para cada linea de window
		numLine=numLine+1; col=0
		Para i=0 hasta Longitud(linea)-1
			char= Subcadena(linea,i,i)
			si char="§" Entonces
				backPole=i
			FinSi
			si char="¤" Entonces
				opciones[row,col,0]="  "+Subcadena(linea,backPole+1,i-1)+"   "
				opciones[row,col,1]="<["+Subcadena(linea,backPole+1,i-1)+"]>"
				opcionesCoords[row,col,0]=numLine
				opcionesCoords[row,col,1]=backPole
				col=col+1
			FinSi
		FinPara
		si col<>0 Entonces
			row=row+1
		FinSi
	FinPara
FinSubProceso

Funcion stripped =  RemoveWhiteSpaces(string Por Referencia,left,right)
	Definir i, j como  Entero
	Definir char,stripped Como Caracter
	i=0; j=Longitud(string)-1
	si left Entonces
		i=-1
		Repetir
			i=i+1
			char=subcadena(string,i,i)
		Hasta Que char<>" "
	FinSi
	si right entonces
		j=Longitud(string)
		Repetir
			j=j-1
			char=subcadena(string,j,j)
		Hasta Que char<>" "
	FinSi
	stripped=Subcadena(string,i,j)
FinSubProceso


SubProceso  CrearWindow ( matriz Por Referencia,string Por Referencia,dimLines,dimv, dimh,descripciones)
	 
	Definir char, windowFragment, descriptionFragment,description Como Caracter
	
	Definir i,j,u,k Como Entero
	u=-1
	Repetir
		u=u+1
		char= Subcadena(string,u,u)
	Hasta Que char="¢"
	windowFragment=Subcadena(string,0,u)
	descriptionFragment=Subcadena(string,u+1,Longitud(string)-1)
	j=0; u=-1
	Para i=0 hasta dimLines-1
		Repetir
			u=u+1
			char= Subcadena(windowFragment,u,u)
		Hasta Que char="¶"
		matriz[i]=Subcadena(windowFragment,j,u-1)
		//Escribir matriz[i]
		u=u+1
		j=u
	FinPara
	j=0; u=-1
	//escribir "pahse"
	Para i=0 hasta (dimv*dimh)-1
		Repetir
			u=u+1
			char= Subcadena(descriptionFragment,u,u)
		Hasta Que char="¶"
		description=Subcadena(descriptionFragment,j,u-1)
//		Escribir description
		k=-1
		Repetir
			k=k+1
			char=Subcadena(description,k,k)
		Hasta Que char="¥"
		descripciones[i,0]=Subcadena(description,0,k-1)
//		Escribir descripciones[i,0]
		descripciones[i,1]=Subcadena(description,k+1,Longitud(description)-1)
//		Escribir descripciones[i,1]
		u=u+1
		j=u
	FinPara
	EScribir "fin"
Fin Subproceso

SubProceso  ImprimirWindow ( matriz Por Referencia,dimv)
	Definir i,j Como Entero
	Para i=0 hasta dimv-1
			Escribir  matriz[i]
	FinPara
	Escribir ""
Fin Subproceso


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