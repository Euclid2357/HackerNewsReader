# HackerNewsReader

Aquí quiero explicar algunas de las decisiones tomadas y cosas que asumí, en la resolución del ejercicio

**LIBRERÍAS** 

Aquí se me presentó un dilema: 
La utilización de librerías de terceros en un examen, podría ser vista como algo negativo puesto que no muestro conocimientos propios para resolver algunas cuestiones, sino que muestro los de otros. Pero también podría ser vista como algo positivo en el sentido de no estar reinventando la rueda para resolver algo que ya está bien resuelto y con una solución reutilizable a mi disposición.
La decisión que terminé tomando es la de NO utilizar librerías de terceros en este proyecto, pero contarles que generalmente si lo hago, aunque cuidando hacerlo solo con aquellas que son muy confiables, ya que mi proyecto va a quedar dependiente de ellas. 
Suelo utilizar Alamofire para Networking, Kingfisher ó SDWebImage para la carga asincrónica de imágenes y cache de las mismas, las de Firebase, las de Google… y alguna que otra muy puntuales. En este caso opté por manejar el networking utilizando URLSession (Apple nativo)

**ARQUITECTURA: MVVM**

Considero a MVVM la mejor arquitectura para proyectos medianos y grandes. Dado que este  es un proyecto pequeño, perfectamente podría haber sido realizado utilizando MVC (Model View Controller) sin mayores riesgos de caer en un “Massive View Controller”. Pero por tratarse de un examen, me pareció oportuno tomarlo como si fuese un proyecto grande, a fin de que puedan evaluar el uso de una arquitectura que permite escalabilidad, logrando una mejor separación de concerns entre la capa de vista y el modelo (Incluyendo a los ViewControllers como parte de la capa de Vista)

**BINDING ENTRE CAPAS DE MVVM**

Consistente con la decisión de no utilizar librerías de terceros, y dado el tamaño del proyecto, preferí no usar RxSwift o algo parecido (Aún no he probado Combine, la solución de Apple).
Preferí hacerlo más “a mano”mediante closures y/o delegates y observers.

**SIN PAGINADO**

El ejercicio no pedía paginar, y dadas las limitaciones de tiempo para realizarlo, me pareció correcto no paginar, y que la app cumpla con el propósito de mostrar “recently posted news” como dice el enunciado, y no ir a buscar los más antiguos. De todas maneras quiero dejar escrito que sería un feature interesante agregar paginado, y también un Search, para poder encontrar más interesantes Hacker news

**DELETE “Persistente”**

El enunciado aclara que los posts eliminados no deben volver a mostrarse cuando se hace refresh, (“Once a post is deleted it should not reappear even if the data is refreshed. “) . Lo que de algún modo sugiere que el borrado “persiste” durante la sesión (Dice que no deben reaparecer al hacer refresh, y no al volver a ejecutar la app en una nueva “sesión”). Teniendo en cuenta esto, decidí que la persistencia de la lista de borrados sea solo en memoria. Teniendo en cuenta además que no hay paginado, y siempre se muestran los últimos 20, y que estos se renuevan muy rápidamente (Hay posts muy frecuentemente) no vale la pena persistir en forma permanente la lista de eliminados, ya que en muy poco tiempo más, la app los considerará lo suficientemente antiguos como para ya no mostrarlos

**Hacker Newa Service & API**

Hay un objeto encargado de obtener el JSON de la Web y transformarlo en una collection de Posts, se trata del HnAPIClient, hay otro que hace lo propio pero de un cache local, almacenado en el fileSystem, para cuando no hay internet. Se trata de CacheClient. Ambos conforman HackerNewsService protocol
El View Model de la primer pantalla, conoce al client y lo utiliza, pero sólo a través de su protocolo, de este modo es simple inyectarle uno u otro, o incluso algún otro nuevo en el futuro, que por ejemplo, traiga posts de otro sitio, o de un archivo local con datos MOCK.

**UI Construcción**

Este es otro punto polémico: Xibs?, Storyboards? Programático? SwiftUI? Decidí hacerlo con Storyboards pues es un proyecto pequeño, y lo trabajo solo, y me resulta más simple. 

**Persistencia Local**

La persistencia local es solo para “recordar” lo eliminado y para guardar los resultados de la ultima consulta, para mostrarlos cuando no haya conexión a Internet.
Ninguno de los dos casos justifica agregar un modo de persistencia como CoreData o Realm. El primer caso ya lo expliqué más arriba (Sección DELETE) y el segundo, es guardar todos los resultados de una búsqueda. No hay ni altas, ni bajas ni modificaciones, ni queries complejas ni nada. Lo más simple es almacenar el último json que trajo la consulta, e ir pisando el que tenemos con el nuevo cada vez, en el fileSystem del device/app

**WARNING**

Para determinar si hay o no conexión a Internet, utilicé el “Nuevo” framework de Apple, Networking. Hay un Bug que hace que no funcione correctamente en el simulador, por lo que este feature tiene que probarse en un device real.
