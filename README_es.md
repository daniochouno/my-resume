# Hola 👋
Soy Daniel Martínez, un desarrollador de aplicaciones para iOS con más de 15 años de experiencia laboral, los 8 últimos de ellos especializados en iOS, y que he trabajado en el desarrollo de más de 10 aplicaciones de iOS, la mayoría de ellas en entornos de despliegue continuo en la AppStore (fast-paced environment), normalmente con un ciclo de publicación de 2 semanas.

Como proyectos adicionales a mi trabajo, he creado desde cero 3 aplicaciones que se encuentran disponibles en las tiendas de iOS y Android. Una de ellas ha sido descargada más de 100.000 veces desde que se publicó.

Mis puntos fuertes son la organización de tareas, mi alto nivel de autonomía y el compromiso al máximo con la fidelidad en la implementación de las funcionalidades.

Lo que más me motiva y la razón principal por la que me apasiona mi trabajo es poder llegar y ayudar con mis apps a cualquier persona que posea un teléfono móvil, un iPhone.

Me considero un buen trabajador en equipo, abierto a dialogar sobre la mejor forma de desarrollar una feature y a colaborar para mejorarla.

# Sobre este proyecto
Este proyecto nace para poder mostrar parte de mis capacidades como desarrollador en iOS en un proyecto real y actualizado.

He usado __SwiftUI__, __UIKit__, arquitecturas como __MVVM__ y __VIPER__, conexiones de red a una API REST, etc... sin utilizar ninguna librería externa, tan sólo con las APIs que proporciona Apple en su SDK nativo. El código fuente de esta aplicación está disponible para que cualquier persona interesada pueda verlo.

A continuación describo en detalle cómo he desarrollado el proyecto y cómo he creado cada feature.

# TDD
A lo largo de todo el desarrollo he utilizado __TDD__ (__Test Driven Development__). Esta técnica de desarrollo consiste en escribir primero los tests que van a definir la feature. En esta fase se pueden descubrir __edge cases__ o casos extremos que pueden condicionar la escritura del código que después pasará los tests. 

Una vez escritos los tests pasamos a la siguiente fase: la escritura del código que cumplirá la feature. A lo largo de esta fase se irán lanzando los tests que escribimos anteriormente para comprobar la evolución del desarrollo de la feature.

Cuando todos los tests pasen, se podrá dar por finalizada la feature.

# Patrón Factory
He usado el patrón __Factory__ en todo el proyecto para la creación e inicialización de las clases y, por ejemplo, poder utilizar protocolos a lo largo de las distintas capas. El uso de este patrón también ha hecho que sea más sencillo escribir los tests, porque permite seguir los principios __SOLID__. 

# Versión mínima
La versión mínima soportada es __iOS 15__. Esto me permite utilizar SwiftUI en un avanzado estado de estabilidad.

# Estructura del proyecto
He dividido el proyecto en distintas capas, siguiendo los principios de la __arquitectura Clean__:

### Data
Contiene las __bases de datos__, __Data Sources__, __Repositorios__ y los modelos que se usan en esta capa.

### Domain
Contiene los __casos de uso__ y los modelos que se usan en esta capa.

### Presentation
Contiene los __recursos__ (Assets, cadenas de texto localizadas, etc...) y las __vistas__ que se muestran en la aplicación. Dentro de esta capa he creado una carpeta __features__ donde he subdividido cada pantalla/vista y he incluído ahí sus ViewModels, Models, Interactors, Presenters, etc... según la arquitectura utilizada en cada feature.

### Networking
En esta capa he incluído todo lo necesario para hacer las conexiones de red. Normalmente se incluye en la capa __Data__, pero he querido separarla para darle más importancia.

### Config
Aquí he incluído los archivos de configuración del proyecto y los archivos necesarios para el apartado de Ajustes de la aplicación, accesible desde los Ajustes del sistema operativo.
