require 'date'

#se eliminan todos los datos que pueden estar en la tabla usuarios

#guardo los datos del excel en un arreglo llamado celdas
       ex = Roo::Excel.new("#{Rails.root}/db/pacientes-de-Inmunoterapia.xls")
       ex.default_sheet = ex.sheets.first
       posC=0
       puts "MIGRACION DATOS DE USUARIOS DEL ARCHIVO DE EXCEL A LA TABLA USUARIOS"
       #puts ex.last_row
      #fechaActual = Time.new.to_a
      fechaActual = DateTime.now
      puts fechaActual << 10
      #puts fechaActual
      #puts fechaActual.to_a
      pos=''
       for fila in (4 .. ex.last_row)
       #for fila in (4 .. 8)
            puts "FILA = #{fila}"
            usuario = {
              :numeroExcel => ex.cell(fila,1).to_s.sub(".0",""),
              :apellido => ex.cell(fila,2).strip,
              :nombre => ex.cell(fila,3).strip,
              :historia => ex.cell(fila,4).to_s.sub(".0",""),
              :fechaNacimiento => ex.cell(fila,5).to_s.sub(".0",""),
              :telefonoHabitacion => ex.cell(fila,6).to_s.sub(".0",""),
              :telefonoTrabajo => ex.cell(fila,7).to_s.sub(".0",""),                
              :celular1 => nil,
              :celular2 => nil,
              :email => ex.cell(fila,8),
              :email2 => ex.cell(fila,9),
              #se esta colocando como username y password:
              #historia-numero
              #por ejemplo para el usuario 
              :username => ex.cell(fila,4).to_s.sub(".0","") + "-" + ex.cell(fila,1).to_s.sub(".0",""),
              :password => ex.cell(fila,4).to_s.sub(".0","") + "-" + ex.cell(fila,1).to_s.sub(".0","")
            }
            if usuario[:telefonoHabitacion].strip.length ==0
                  usuario[:telefonoHabitacion] = nil
            end      
            if usuario[:telefonoTrabajo].strip.length ==0
                  usuario[:telefonoTrabajo] = nil
            end 
 
            if !usuario[:email].nil? 
              if usuario[:email].strip.length == 0
                 usuario[:email] = usuario[:apellido]+"-"+usuario[:numeroExcel]+"@cambiarcorreo.com"   
              end
            else
              usuario[:email] = usuario[:apellido].gsub(" ", "-")+"-"+usuario[:numeroExcel]+"@cambiarcorreo.com"   
            end      

            expresion = /(0416|0412|0414|0424)-\d{7}/
            m = expresion.match(usuario[:telefono1])

            if expresion.match(usuario[:telefonoHabitacion]) 
                usuario[:celular1] = usuario[:telefonoHabitacion]
                usuario[:telefonoHabitacion] = nil
                if expresion.match(usuario[:telefonoTrabajo])                
                  usuario[:celular2] = usuario[:telefonoTrabajo]
                  usuario[:telefonoTrabajo] = nil 
                end
            else
                if expresion.match(usuario[:telefonoTrabajo])                
                  usuario[:celular1] = usuario[:telefonoTrabajo]
                  usuario[:telefonoTrabajo] = nil 
                end
            end
                      
            puts usuario                      
            u = Usuario.new(numeroExcel: usuario[:numeroExcel].to_i,
                           nombre: usuario[:nombre], 
                           apellido: usuario[:apellido],
                           historia: usuario[:historia],
                           telefonoHabitacion: usuario[:telefonoHabitacion],
                           telefonoTrabajo: usuario[:telefonoTrabajo],
                           celular1: usuario[:celular1],
                           celular2: usuario[:celular2],
                           email: usuario[:email],
                           email2: usuario[:email2],
                           username: usuario[:username],
                           password: usuario[:password],
                           rol: 2  
                        )
            u.save(validate: false)

            puts "EL ID ES #{u.id}" 
        end      