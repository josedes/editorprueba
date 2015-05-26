# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Crear el usuario de prueba"
u = Usuario.new(
#  :username => "#{title} #{name} #{surname}",
#  :email => "#{name}.#{surname}_#{num}@localtinkers.com",
#  :password => '12341234'

  username: "root",
  nombre: "Usuario root",
  apellido: "",
  email: "root@gmail.com",
  password: '12345678'

)
u.save!(validate: false)

puts "Creación de las opciones del Menú principal"

#titulos_vinculos = [
#  "Qué es la Alergia?",
#  "Tipos de Alergia",
#  "Embarazos y Alergia",
#  "Alergia y Medicamentos",
#  "Asma", 
#  "Cirugía y Alergia", 
#  "Contacto"
#]

titulos_vinculos = {
  :alergia => "Qué es la Alergia?",
  :tipos => "Tipos de Alergia",
  :embarazos => "Embarazos y alergia",
  :asma => "Asma",
  :medicamentos => "Alergia y medicamentos",
  :cirugia => "Cirugía y Alergia",
  :contacto => "Contacto"

}

#Generar los registros para cada enlace del menu principal en la BD
titulos_vinculos.each do |enlace, titulo|
 MenuNivel0.create( titulo: titulo, enlace: enlace, usuario_id: u.id )
end

#titulos_vinculos.each do |titulo|
#  MenuNivel0.create( titulo: titulo, usuario_id: u.id )
#end