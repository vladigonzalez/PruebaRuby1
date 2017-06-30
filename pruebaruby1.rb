# pruebaruby1.rb

file = File.open('alumnos.csv', 'r')
alumnos = file.read.split("\n")
file.close

# ejercicio
# Creo archivo con promedio
def creoarchivo(nom,promedio)
	file = File.open("#{nom}", 'w')
	file.puts promedio
	file.close	
end 

def creoarchivonotas(hs)
	file = File.open('notas.txt', 'w')
	hs.each{ |key , val| 	file.puts "Alumno: #{key}   Nota: #{val}"}
	file.close
end

def presionatecla()
  puts "+-------------------------------------------------+" 
  puts "|             presione una tecla para             |" 
  puts "|              volver a menú inicial              |" 
  puts "+-------------------------------------------------+" 
  puts "" 
	puts ""
	x = gets.chomp
end

# Genera Promedio Alumnos notas
# elimino nombre y elimino A
# calculo promedios
# retorna hash con alumnos==>promedios
def damepromedio(arr)
	hprom = {}
	arr.each do |linea|
		data = linea.split(', ')  # separo los datos
		cantnotas = data.count - 1
		promedio = data.inject(0) {|sum, x| sum + x.to_f} / cantnotas
		hprom[data[0]] = promedio  # retorno hash con nombre y promedio
	end
	hprom
end

def creoarchivosprom(arr)
	hprom = damepromedio(arr)
	hprom.each{ |key , val| creoarchivo("#{key}.txt",val)}
	system('clear')
	puts ""
 	puts "+-------------------------------------------------+" 
  puts "                                                   "
  puts "          Archivos por alumnos creados!!           " 
  puts "                                                   " 
	hprom.each{ |key , val| puts "      #{key}.txt  ==>  Promedio: #{val}"}
  puts "" 
  puts "" 
  puts "  NOTA: Archivo notas.txt contiene todos los alumnos"
  puts "" 
  creoarchivonotas(hprom)
  presionatecla()
	partida_inicial(menu_inicial(),arr)
end

def verasistencia(arr)
	system('clear')
	puts ""
 	puts "+-------------------------------------------------+" 
 	puts "                                                   "
 	puts "             Inasistencia de Alumnos               " 
 	puts "                                                   " 
	arr.each do |linea|
  	puts "         #{linea.split(', ')[0]}   ==>>>   #{linea.scan("A").count}  "
  	puts ""
	end
  puts "                                                   " 
  presionatecla()
	partida_inicial(menu_inicial(),arr)
end

def aprobados(arr,notabase)
	system('clear')
  puts ""
  puts "+-------------------------------------------------+" 
  puts ""
  puts "       ALUMNOS APROBADOS (Nota: #{notabase})" 
  puts "" 
	hprom = damepromedio(arr)
	hprom.each{ |key , val| puts "         #{key}   ===>    #{val}" if val >= notabase}
  puts ""
  presionatecla()
	partida_inicial(menu_inicial(),arr)
end

def menu_inicial() 
  system('clear')
  puts ""
  puts "+-------------------------------------------------+" 
  puts "|                MENU  PRINCIPAL                  |" 
  puts "|                                                 |" 
  puts "+-------------------------------------------------+" 
  puts "|             Selecciona una opción:              |" 
  puts "|                                                 |" 
  puts "|     1 - Crear Archivo con nombre del alumno     |" 
  puts "|                                                 |" 
  puts "|     2 - Ver  Inasistencias por pantalla         |"
  puts "|                                                 |" 
  puts "|     3 - Ver Alumnos Aprobados (nota 5)          |"
  puts "|                                                 |" 
  puts "|     4 - Salir                                   |"
  puts "|                                                 |" 
  puts "+-------------------------------------------------+" 
  puts "" 
  print "      Ingresa Opción: " 
  opc = gets.chomp.to_i
  return opc
end   

def salida()
	system('clear')
	puts ""
  puts "+-------------------------------------------------+" 
  puts "|                                                 |"
  puts "|                Fin del Programa!!               |" 
  puts "|                                                 |" 
  puts "+-------------------------------------------------+" 
  puts "|             Adios...   Buena Suerte!!           |" 
  puts "+-------------------------------------------------+" 
	puts ""
  puts ""
  exit
end

def error()
	system('clear')
	puts ""
  puts "+-------------------------------------------------+" 
  puts "|                                                 |"
  puts "|          Error , opción invalida !!             |" 
  puts "|                                                 |" 
  presionatecla()
end   

def partida_inicial(opc,alumnos)
  case opc
    when 1 then creoarchivosprom(alumnos) 
    when 2 then verasistencia(alumnos) 
    when 3 then aprobados(alumnos,5)             
    when 4 then salida             
    else error()
			partida_inicial(menu_inicial(),alumnos)     
  end            
end                 

partida_inicial(menu_inicial(),alumnos) 
