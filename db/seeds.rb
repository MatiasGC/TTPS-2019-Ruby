# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


p1 = Product.find_or_create_by!(codigo_unico: "agk123456", descripcion: "Agua Kin 500cc", detalle: "Agua 100 por ciento natural. Botella plástica no retornable", monto: 30, cantidad_stock: 4)
p2 = Product.find_or_create_by!(codigo_unico: "ymt259820", descripcion:"Yerba Mate Playadito 1kg", detalle: "Elaborado con Palo, libre de gluten", monto:150, cantidad_stock: 3)
p3 = Product.find_or_create_by!(codigo_unico: "pso107622", descripcion: "Protector Solar Nivea Sun 208g", detalle: "Protección UVA UVB inmediata. Factor 20. Resistente al agua", monto:90, cantidad_stock: 2)
p4 = Product.find_or_create_by!(codigo_unico: "mml174391", descripcion: "Mermelada Arcor Durazno light 390g", detalle: "Mermelada de durazno reducida 47 por ciento en calorías, libre de gluten", monto: 100, cantidad_stock: 1)
p5 = Product.find_or_create_by!(codigo_unico: "cai456123", descripcion: "Leche La Serenísima", detalle: "Leche La Serenísima por 1 litro. Parcialmente descremada", monto: 80, cantidad_stock: 0)
p6 = Product.find_or_create_by!(codigo_unico: "jup890160", descripcion: "Fernet Branca 1L", detalle: "Fernet Branca 1 Litro", monto: 380, cantidad_stock: 10)



p1.items.create(estado: "disponible", valor_venta: 0)
p1.items.create(estado: "disponible", valor_venta: 0)
p1.items.create(estado: "disponible", valor_venta: 0)
p1.items.create(estado: "disponible", valor_venta: 0)

p2.items.create(estado: "disponible", valor_venta: 0)
p2.items.create(estado: "disponible", valor_venta: 0)
p2.items.create(estado: "disponible", valor_venta: 0)

p3.items.create(estado: "disponible", valor_venta: 0)
p3.items.create(estado: "disponible", valor_venta: 0)

p4.items.create(estado: "disponible", valor_venta: 0)

p6.items.create(estado: "disponible", valor_venta: 0)
p6.items.create(estado: "disponible", valor_venta: 0)
p6.items.create(estado: "disponible", valor_venta: 0)
p6.items.create(estado: "disponible", valor_venta: 0)
p6.items.create(estado: "disponible", valor_venta: 0)
p6.items.create(estado: "disponible", valor_venta: 0)
p6.items.create(estado: "disponible", valor_venta: 0)
p6.items.create(estado: "disponible", valor_venta: 0)
p6.items.create(estado: "disponible", valor_venta: 0)
p6.items.create(estado: "disponible", valor_venta: 0)

User.find_or_create_by!(username: "tpi_ruby"){|u| u.update(password: "123456")}
User.find_or_create_by!(username: "matias"){|u| u.update(password: "123456")}

c = Client.new(cuil_o_cuit: "123456789", razon_social:"cliente1", condicion_iva: 4, email: "cliente1@gmail.com").contacts.new(telefono: "2214903456")
c.save