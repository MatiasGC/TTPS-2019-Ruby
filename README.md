# README

ACLARACIÓN RUTAS

GET 'productos'
Para ver los productos por alguno de los filtros se debe mandar el parámetro q en la url. Por ejemplo: http://localhost:3000/productos?q=all

Para crear items en la ruta "POST /productos/:codigo/items" puede utilizarse Postman o curl para enviar el parámetro 'items' en peticion, de la siguiente manera:

curl -i -X POST -H "Content-Type:application/json" -d '{"items":"2"}' http://localhost:3000/productos/agk123456/items

El :código puede reemplazar por otro; 'items' es la palabra clave para recuperar la cantidad solicitada para crear nuevos items del producto.


ACLARACIÓN AUTENTICACIÓN DE USUARIOS

El tema de la autenticación de usuario me generó bastantes complicaciones; encontré mucho material en internet pero no supe cómo bajarlo a este proyecto y en un momento tuve que darle un corte para poder continuar con el resto de las funciones y no retrasarme. Utilicé la gema Devise para generar el token y luego utilicé un método que ya viene provisto por Rails llamado "authenticate_or_request_with_http_token" que accede automáticamente a la cabecera 'Authorization' y recupera el valor. El token del usuario se genera cuando se dirige a la url /sesiones y luego para ingresar a los otros endpoints que requieren autenticación debe copiarse y pegarse el token generado en la cabecera 'Authorization', tanto en Curl como en Postman.

En Curl: $ curl http://localhost:3000/productos -H "Authorization: Token token='el token generado'"
En Postman en la pestaña Headers como key: Authorization value: el token generado



