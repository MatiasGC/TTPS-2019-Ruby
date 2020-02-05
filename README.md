# README

ACLARACIÓN RUTAS

GET 'productos'
Para ver los productos por alguno de los filtros se debe mandar el parámetro q en la url. Por ejemplo: http://localhost:3000/productos?q=all

Para crear items en la ruta "POST /productos/:codigo/items" puede utilizarse Postman o curl para enviar el parámetro 'items' en peticion, de la siguiente manera:

curl -i -X POST -H "Content-Type:application/json" -d '{"items":"2"}' http://localhost:3000/productos/agk123456/items

El :código puede reemplazar por otro; 'items' es la palabra clave para recuperar la cantidad solicitada para crear nuevos items del producto.


PARA CREAR UN USUARIO EN EL POST /usuarios ENVIAR EN EL CUERPO DE LA PETICIÓN LOS PARÁMETROS "u": nombre de usuario, y "p": password

PARA GET /productos ENVIAR EL PARÁMETRO 'q' EN LA URL, POR EJEMPLO http://....?q=all

EN EL POST /productos/:codigo/items, LA CANTIDAD DE ITEMS SE IDENTIFICA CON LA PALABRA "items": cantidad. LOS ITEMS SE CREAN CON VALOR_VENTA: 0

EN EL GET /reservas/:id LA FORMA DE ENVIARSE EL PARÁMETRO PARA SOLICITAR LOS ITEMS SERÍA ?include=items
MISMO CASO PARA EL GET /ventas/:id



