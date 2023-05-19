// We have an ASCII map with high repetitive-char-segments-ratio so, only to keep the destination program neat and clean, i generate a compressed character chain.
// Although not implemented here, just adding a header specifiyng the required destination vector dimension, this gets more flexible.

Algoritmo CompresorASCII
	Definir vector,i Como Caracter
	Dimension vector[52]
	MapearArg(vector)
	Compressor(vector,52)
FinAlgoritmo


SubProceso  Compressor(vector,dim)
	Definir compressedChain,linea,char,prevChar como Caracter
	Definir i, j,counter como Entero
	compressedChain=""
	Para cada linea de vector
		counter=0
		prevChar=Subcadena(linea,0,0)
		Para i=1 hasta Longitud(linea)-1
			char=Subcadena(linea,i,i)
			si char=prevChar Entonces
				counter=counter+1
			SiNo
				compressedChain=compressedChain+"{"+prevChar+"}"+ConvertirATexto(counter+1)
				counter=0
			FinSi
			prevChar=char
			si i=Longitud(linea)-1 Entonces
				compressedChain=compressedChain+"{"+prevChar+"}"+ConvertirATexto(counter+1)
			FinSi
		FinPara 
		compressedChain=compressedChain+"{SL}"
	FinPara
	Escribir compressedChain	
FinSubProceso

 
SubProceso MapearArg(vector Por Referencia)
	vector[0]="                                                                                                                                                    . " 
	vector[1]="                                                                                                                                                      " 
	vector[2]="                                                                                                                                                      " 
	vector[3]="                                                                                                                                                      " 
	vector[4]="                                                                                                                                                      " 
	vector[5]="                                                                                                                                                      " 
	vector[6]="                                                                                                                                                      " 
	vector[7]="                                                                                                                                                      " 
	vector[8]="                                                                                                                                                      " 
	vector[9]="                                                                                                      $                                               " 
	vector[10]="                                                                                                     ||.::.:.                                        " 
	vector[11]="                                                                                               .:----||====---+-:.                                   " 
	vector[12]="                                                                                           ..::------||---=---+--=:::.                               " 
	vector[13]="                                                                                    .:-+==+#----------------=--==------:.                            " 
	vector[14]="                                                                  $              .::=++++++++#=#-----|  ZONA   |-------##-:.                         " 
	vector[15]="                                                                  \\          .=++++++++++++++++#---=|  NORTE  |====+##***+:.                        " 
	vector[16]="                                                                   \\       +++++++++++++++++++#-----=----------=#*******+-.                         " 
	vector[17]="                                                                    \\     .=++++++++++++*++++++#=-==--------------#********+-.                      " 
	vector[18]="                                                                     \\   .:=+++++++++*++*++++#=-#:#--------------##***********+:.                   " 
	vector[19]="                                                                     :\\+++++++|   ZONA  |++#::::::#:#---------=##**************+:.                  " 
	vector[20]="                                                               .::-#-++\\++++++|  OESTE  |++#:::::::::#:#=#-=##*******************=:.                " 
	vector[21]="                                                             :+#~~#+++++++++++++++++++++++=#-:::::::::::::##*******************++=-:.                " 
	vector[22]="                                                            =##~~~#*++++++#=#++#++#+#++#-::::::::::::::-##*********************+==-:..               " 
	vector[23]="                                                       .-==+~~~~~~~~#+++#:::::::::::::::::::::::::::::##************************+=:.                 " 
	vector[24]="                                                   .-**#~~~~~~~~~~~#*=::::::::::|  ZONA CENTRO  |::-#*****************************-::    .:-*+-      " 
	vector[25]="                                                 -+*##~~~~~~~~~~~~~#=::::::::::::::::::::::::::::::##******|  ZONA ESTE  |**********************+::. " 
	vector[26]="                                     $         :*#~~~~~~~~~~~~~~#*::::::::::::::::::::::::::*****************************+++++===========++***+=-:   " 
	vector[27]="                                     \\     =++#~~~~~~~~~~~~~~~#*=:::::::::::::::::::::#*************************#**++==-::::                        " 
	vector[28]="                                      \\  -#~~~~~~~~~~~~~~~~~~~#*+-:::::::::::::::::#************************##*++==-:..                             " 
	vector[29]="                                       \\-*#~~~~~~~~~~~~~~~~~~~~~~#*:::::::||:::::#*************************#*++==-:.                                " 
	vector[30]="                                       :\\~~~~~~~~~~~~~~~~~~~~~~~~~~#::::::||:::#****************************++=-:..                                 " 
	vector[31]="                                    : :+#\\~~~~~~~~~~~~~~~~~~~~~~~~~~~#~~~:||:#*******************************=-.                                    " 
	vector[32]="                                    -*+*#~\\~~~~~~~~~~~~~~~~~~~~~~~~#*++##~||#*******##**********************##+-:.                                  " 
	vector[33]="                                 .++*#~~~~~\\~~~~~~~~~~~~~~~~~~~~~~#*---=*#||##******###*++*#******************##-=:.                                " 
	vector[34]="                               .**#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#+=+-:..-||#####*+=-::::=+###***************\\=-:.                                 " 
	vector[35]="                            :++*#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#**+.   ||-==+=--:.     .::=+**###**###***+-\\.                                   " 
	vector[36]="                       .-+*#~~~~~~~~|  ZONA SUR  |~~~~~~~~~~~#********-::. || ......           ..:-==++=-------: \\                                  " 
	vector[37]="                      .*#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#**+==--:::::::. ||                      ...::::::....  \\                                 " 
	vector[38]="               : ::=*#~~~~~~~~~~~~~~~~~~~~~~~~~#**+++=+*+++==-:..          ||                                       $                                " 
	vector[39]="            .-*#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#+=-::....:::::..             ||                                                                        " 
	vector[40]="          .+#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#*-:.                         ||                                                                        " 
	vector[41]="         .*#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*=:.                          ||                                                                        " 
	vector[42]="         -=*#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+-:.                         ||                                                                        " 
	vector[43]="          :+#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*+=-.                         ||                                                                        " 
	vector[44]="        :+#~~~~~~~~~~~~~~~~~~~~~~~****+++++++==-:.                         ||                                                                        " 
	vector[45]="        *#~~~~~~~~~~~~~~~~~~~~~*+++=---:::::::.                            ||                                                                        " 
	vector[46]="        *##~~~~~~~~~~~**++++++++=-:..                                       $                                                                        " 
	vector[47]="         :+*#~~~~~~#*++=--::::::..                                                                                                                   " 
	vector[48]="          .:=*~~~~#++=-:.                                                                                                                            " 
	vector[49]="             .+##*++-:.                                                                                                                              " 
	vector[50]="               -+-=-:.                                                                                                                               " 
	vector[51]="                ..:..                                                                                                                                " 
	
FinSubProceso
