# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


p1 = Product.find_or_create_by!(codigo_unico: "agk123456", descripcion: "Agua Kin 500cc", detalle: "Agua 100 por ciento natural. Botella plástica no retornable", monto: 35.5, cantidad_stock: 4)
p2 = Product.find_or_create_by!(codigo_unico: "ymt259820", descripcion:"Yerba Mate Playadito 1kg", detalle: "Elaborado con Palo, libre de gluten", monto:90, cantidad_stock: 3)
p3 = Product.find_or_create_by!(codigo_unico: "pso107622", descripcion: "Protector Solar Nivea Sun 208g", detalle: "Protección UVA UVB inmediata. Factor 20. Resistente al agua", monto:250, cantidad_stock: 2)
p4 = Product.find_or_create_by!(codigo_unico: "mml174391", descripcion:"Mermelada Arcor Durazno light 390g", detalle: "Mermelada de durazno reducida 47 por ciento en calorías, libre de gluten", monto: 100, cantidad_stock: 1)

p1.items.create(estado: "disponible", valor_venta: 15)
p1.items.create(estado: "disponible", valor_venta: 15)
p1.items.create(estado: "disponible", valor_venta: 15)
p1.items.create(estado: "disponible", valor_venta: 15)

p2.items.create(estado: "disponible", valor_venta: 30)
p2.items.create(estado: "disponible", valor_venta: 30)
p2.items.create(estado: "disponible", valor_venta: 30)

p3.items.create(estado: "disponible", valor_venta: 90)
p3.items.create(estado: "disponible", valor_venta: 90)

p4.items.create(estado: "disponible", valor_venta: 100)

User.find_or_create_by!(username: "matias"){|u| u.update(password: "123456")}

c = Client.new(cuil_o_cuit: "123456789", razon_social:"cliente1", condicion_iva: 4, email: "cliente1@gmail.com").contacts.new(telefono: "2214903456")
c.save