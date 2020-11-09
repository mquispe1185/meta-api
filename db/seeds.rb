# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Rol.create([{descripcion: 'admin'},{descripcion: 'comerciante'},{descripcion: 'usuario final'}])

#Promocion.create(comercio_id: com.id, usuario_id: com.usuario.id, desde: '2020-10-21', hasta: '2020-10-25', titulo: 'PRIMER SUPER PROMO', descripcion: 'esta es una promo de prueba', duracion: 5, vencido: false, prioridad: 1, estado: 0, habilitado: false)
