[Go to English version](../main/README.md)

![Platform](https://img.shields.io/badge/platform-iOS-lightgrey)
![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/daniochouno/my-resume?label=version)
![Unit tests](https://img.shields.io/badge/Unit%20Tests-44-success)
![Swift](https://img.shields.io/badge/Swift-100%25-success)
![SwiftUI](https://img.shields.io/badge/-SwiftUI-green)
![UIKit](https://img.shields.io/badge/-UIKit-green)
![MVVM](https://img.shields.io/badge/-MVVM-blue)
![VIPER](https://img.shields.io/badge/-VIPER-blue)
![Async/Await](https://img.shields.io/badge/-Async%20Await-orange)
![TDD](https://img.shields.io/badge/-TDD-9cf)

# Hola 👋
Soy Daniel Martínez, un desarrollador de aplicaciones para iOS con más de 15 años de experiencia laboral, los 8 últimos de ellos especializados en iOS, y que he trabajado en el desarrollo de más de 10 aplicaciones de iOS, la mayoría de ellas en entornos de despliegue continuo en la AppStore (fast-paced environment), normalmente con un ciclo de publicación de 2 semanas.

Como proyectos adicionales a mi trabajo, he creado desde cero 3 aplicaciones que se encuentran disponibles en las tiendas de iOS y Android. Una de ellas ha sido descargada más de 100.000 veces desde que se publicó.

Mis puntos fuertes son la organización de tareas, mi alto nivel de autonomía y el compromiso al máximo con la fidelidad en la implementación de las funcionalidades.

Lo que más me motiva y la razón principal por la que me apasiona mi trabajo es poder llegar y ayudar con mis apps a cualquier persona que posea un teléfono móvil, un iPhone.

Me considero un buen trabajador en equipo, abierto a dialogar sobre la mejor forma de desarrollar una feature y a colaborar para mejorarla.

# Sobre este proyecto
Este proyecto nace para poder mostrar parte de mis capacidades como desarrollador en iOS en un proyecto real y actualizado.

He usado __SwiftUI__, __UIKit__, arquitecturas como __MVVM__ y __VIPER__, conexiones de red a una API REST utilizando __Async/Await__, etc... sin utilizar ninguna librería externa, tan sólo con las APIs que proporciona Apple en su SDK nativo. El código fuente de esta aplicación está disponible para que cualquier persona interesada pueda verlo.

A continuación describo en detalle cómo he desarrollado el proyecto y cómo he creado cada feature.

# TDD
A lo largo de todo el desarrollo he utilizado __TDD__ (__Test Driven Development__). Esta técnica de desarrollo consiste en escribir primero los tests que van a definir la feature. En esta fase se pueden descubrir __edge cases__ o casos extremos que pueden condicionar la escritura del código que después pasará los tests. 

Una vez escritos los tests pasamos a la siguiente fase: la escritura del código que cumplirá la feature. A lo largo de esta fase se irán lanzando los tests que escribimos anteriormente para comprobar la evolución del desarrollo de la feature.

Cuando todos los tests pasen, se podrá dar por finalizada la feature.

# Patrón Factory
He usado el patrón __Factory__ en todo el proyecto para la creación e inicialización de las clases y, por ejemplo, poder utilizar protocolos a lo largo de las distintas capas. El uso de este patrón también ha hecho que sea más sencillo escribir los tests, porque permite seguir los principios __SOLID__. 

# Sobre la aplicación
La versión mínima soportada es __iOS 15__. Esto me permite utilizar SwiftUI en un avanzado estado de estabilidad.

Todos los textos que aparecen en la aplicación están localizados y se muestran en __Inglés (EN)__ o en __Español (ES)__ según el idioma del dispositivo en el que se ejecute. Por defecto se utiliza el inglés.

Los datos de la aplicación están almacenados en varias colecciones de __Firebase Firestore__ y también se almacenan en una caché local de la aplicación.

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

He creado un protocolo __APIClient__ con un único método __fetch__ que será el que se encargue de hacer la llamada a la API REST. En la implementación del método creo un __URLRequest__ con los datos de la petición y después llamo a __URLSession__ utilizando __Async/Await__. Compruebo que la respuesta tiene un estado válido (entre 200 y 299) y parseo el contenido al tipo de datos esperado en la respuesta.

### Config
Aquí he incluído los archivos de configuración del proyecto y los archivos necesarios para el apartado de Ajustes de la aplicación, accesible desde los Ajustes del sistema operativo.

# Features
A continuación describo cómo he desarrollado cada una de las features/pantallas que he incluído en la aplicación.

## Splash
La vista está escrita en __SwiftUI__ y tiene una animación que consta de 2 fases inspirada en la animación inicial de la aplicación de __Twitter__. 

En la primera, el logo que he usado para esta aplicación se muestra creciendo y decreciendo durante 5 segundos con un efecto de escalado, donde cada cambio entre crecimiento/decrecimiento dura 0.65 segundos.

En la segunda, el logo crece hasta cubrir por completo la pantalla y dura 1 segundo.

Después se produce la navegación automáticamente hacia la pantalla principal de la aplicación.

Uso un __ViewModel__ para controlar las distintas fases de la animación.

## Tabs
La vista está escrita en __SwiftUI__ y contiene un TabView personalizado con 3 opciones para ver la información sobre mi carrera profesional, mis habilidades y más información sobre mí.

El TabView personalizado incluye una animación al navegar entre los distintos ítems.

Uso un __ViewModel__ para inicializar la configuración del Settings.bundle al abrirse la pantalla.

## Career
La vista está escrita en __SwiftUI__ y contiene un menú superior con 2 opciones: mis trabajos y mis proyectos personales.

## Works
![Works screenshot](../main/screenshots/es/works.jpeg)

Esta feature utiliza la arquitectura __MVVM__.

La vista está escrita en __SwiftUI__ y muestra un listado de mis trabajos y experiencia profesional. Al final del listado se muestra un texto que indica si la información se ha cargado desde la API remota o desde la caché.

Uso un __ViewModel__ para cargar la información. Este ViewModel hace una llamada al __caso de uso__ que obtiene el modelo de datos que después se parsea para obtener el __modelo__ de la vista. 

El __caso de uso__ (capa de _domain_) carga la lista de trabajos desde el repositorio de la capa de _data_ y los ordena según la fecha de comienzo del trabajo.

El __repositorio__ tiene la lógica de la carga de los datos. Es el repositorio el que determina si los datos de la caché siguen siendo válidos y, si no es así, los carga desde la API remota. Para que los datos de la caché sean válidos deben existir en la caché y deben haber sido guardados en una fecha igual o posterior a la fecha actual menos el tiempo de expiración de la caché. Este tiempo de expiración se puede cambiar en los ajustes de la aplicación y por defecto es de __3600 segundos__ (1 hora). Para acceder a los datos de la caché utilizo el __data source de LocalCache__, y para acceder a los datos de la API remota utilizo el __data source de Firebase Firestore__. Cada vez que se obtienen los datos de la API remota se actualiza la caché local.

Las llamadas a la API de Firestore tienen que estar autenticadas. Por eso, la primera vez hago una llamada para autenticarme y obtener los datos de la sesión: __access token__, __refresh token__ y __expires in__. Cuando obtengo estos datos los guardo en la caché local para las próximas llamadas, hasta que los datos de la sesión dejen de ser válidos.

Tanto el __data source de LocalCache__ como el __data source de la sesión__ utilizan __UserDefaults__ para guardar los datos de la caché.

## Work Details
![Work Details screenshot](../main/screenshots/es/workDetails.jpeg)

Esta feature utiliza la arquitectura __MVVM__.

La vista está escrita en __SwiftUI__ y muestra el detalle de un trabajo después de haberlo seleccionado en el listado anterior. Al final del listado se muestra un texto que indica si la información se ha cargado desde la API remota o desde la caché.

Uso un __ViewModel__ para cargar la información. Este ViewModel hace una llamada al __caso de uso__ que obtiene el modelo de datos que después se parsea para obtener el __modelo__ de la vista. 

El __caso de uso__ (capa de _domain_) carga todos los datos del trabajo desde el repositorio de la capa de _data_.

El __repositorio__ tiene la lógica de la carga de los datos. Es el repositorio el que determina si los datos de la caché siguen siendo válidos y, si no es así, los carga desde la API remota. Para que los datos de la caché sean válidos deben existir en la caché y deben haber sido guardados en una fecha igual o posterior a la fecha actual menos el tiempo de expiración de la caché. Este tiempo de expiración se puede cambiar en los ajustes de la aplicación y por defecto es de __3600 segundos__ (1 hora). Para acceder a los datos de la caché utilizo el __data source de LocalCache__, y para acceder a los datos de la API remota utilizo el __data source de Firebase Firestore__. Cada vez que se obtienen los datos de la API remota se actualiza la caché local.

Las llamadas a la API de Firestore tienen que estar autenticadas. Por eso, la primera vez hago una llamada para autenticarme y obtener los datos de la sesión: __access token__, __refresh token__ y __expires in__. Cuando obtengo estos datos los guardo en la caché local para las próximas llamadas, hasta que los datos de la sesión dejen de ser válidos.

Tanto el __data source de LocalCache__ como el __data source de la sesión__ utilizan __UserDefaults__ para guardar los datos de la caché.

## Pet Projects
![Pet Projects screenshot](../main/screenshots/es/petProjects.jpeg)

Esta feature utiliza la arquitectura __VIPER__.

La vista está escrita en __SwiftUI__ y muestra un listado de mis proyectos personales. Al final del listado se muestra un texto que indica si la información se ha cargado desde la API remota o desde la caché.

Uso un __Presenter__ para cargar la información. Este Presenter llama al __Interactor__ y es éste el que hace una llamada al __caso de uso__ que obtiene el modelo de datos que después se parsea para obtener las __entidades__ de la vista.

El __caso de uso__ (capa de _domain_) carga la lista de proyectos personales desde el repositorio de la capa de _data_ y los ordena según el número de descargas de las aplicaciones.

El __repositorio__ tiene la lógica de la carga de los datos. Es el repositorio el que determina si los datos de la caché siguen siendo válidos y, si no es así, los carga desde la API remota. Para que los datos de la caché sean válidos deben existir en la caché y deben haber sido guardados en una fecha igual o posterior a la fecha actual menos el tiempo de expiración de la caché. Este tiempo de expiración se puede cambiar en los ajustes de la aplicación y por defecto es de __3600 segundos__ (1 hora). Para acceder a los datos de la caché utilizo el __data source de LocalCache__, y para acceder a los datos de la API remota utilizo el __data source de Firebase Firestore__. Cada vez que se obtienen los datos de la API remota se actualiza la caché local.

Las llamadas a la API de Firestore tienen que estar autenticadas. Por eso, la primera vez hago una llamada para autenticarme y obtener los datos de la sesión: __access token__, __refresh token__ y __expires in__. Cuando obtengo estos datos los guardo en la caché local para las próximas llamadas, hasta que los datos de la sesión dejen de ser válidos.

Tanto el __data source de LocalCache__ como el __data source de la sesión__ utilizan __UserDefaults__ para guardar los datos de la caché.

Para acceder al detalle de un proyecto personal se utiliza el __Router__.

## Pet Project Details
![Pet Project Details screenshot](../main/screenshots/es/petProjectDetails.jpeg)

Esta feature utiliza la arquitectura __MVVM__.

La vista está escrita en __SwiftUI__ y muestra el detalle de un proyecto personal después de haberlo seleccionado en el listado anterior. Al final del listado se muestra un texto que indica si la información se ha cargado desde la API remota o desde la caché.

Uso un __ViewModel__ para cargar la información. Este ViewModel hace una llamada al __caso de uso__ que obtiene el modelo de datos que después se parsea para obtener el __modelo__ de la vista. 

El __caso de uso__ (capa de _domain_) carga todos los datos del proyecto personal desde el repositorio de la capa de _data_.

El __repositorio__ tiene la lógica de la carga de los datos. Es el repositorio el que determina si los datos de la caché siguen siendo válidos y, si no es así, los carga desde la API remota. Para que los datos de la caché sean válidos deben existir en la caché y deben haber sido guardados en una fecha igual o posterior a la fecha actual menos el tiempo de expiración de la caché. Este tiempo de expiración se puede cambiar en los ajustes de la aplicación y por defecto es de __3600 segundos__ (1 hora). Para acceder a los datos de la caché utilizo el __data source de LocalCache__, y para acceder a los datos de la API remota utilizo el __data source de Firebase Firestore__. Cada vez que se obtienen los datos de la API remota se actualiza la caché local.

Las llamadas a la API de Firestore tienen que estar autenticadas. Por eso, la primera vez hago una llamada para autenticarme y obtener los datos de la sesión: __access token__, __refresh token__ y __expires in__. Cuando obtengo estos datos los guardo en la caché local para las próximas llamadas, hasta que los datos de la sesión dejen de ser válidos.

Tanto el __data source de LocalCache__ como el __data source de la sesión__ utilizan __UserDefaults__ para guardar los datos de la caché.

## Skills
![Skills screenshot](../main/screenshots/es/skills.jpeg)

Esta feature utiliza la arquitectura __MVVM__.

La vista está escrita en __UIKit__ y muestra un listado agrupado de mis habilidades profesionales. Para mostrar la vista he creado un __Storyboard__ que contiene un __UICollectionView__. Este CollectionView tiene un tipo de celda __UICollectionViewCell__ para mostrar el texto que define la habilidad junto con su icono. Además, existe un __UICollectionReusableView__ que utilizo para mostrar los headers de las categorías.

Para integrar esta vista en __UIKit__ en el resto de la aplicación, que usa __SwiftUI__, he creado un __UIViewControllerRepresentable__ que se encarga de encapsularla.

Uso un __ViewModel__ para cargar la información. Este ViewModel hace una llamada al __caso de uso__ que obtiene el modelo de datos que después se parsea para obtener el __modelo__ de la vista. 

El __caso de uso__ (capa de _domain_) carga la lista de habilidades profesionales desde el repositorio de la capa de _data_.

El __repositorio__ carga los datos desde el __data source de Json__. Debido a que es un archivo local no es necesario establecer un mecanismo de caché de acceso a los datos, así que se cargan directamente desde el JSON siempre.

El __data source de Json__ lee el archivo JSON de la base de datos y parsea su contenido.

## About Me
![About me screenshot](../main/screenshots/es/aboutMe.jpeg)

La vista está escrita en __SwiftUI__ y muestra varios textos con información sobre mí y sobre este proyecto.

## PDF Viewer
![PDF Viewer screenshot](../main/screenshots/es/pdfViewer.jpeg)

La vista está escrita en __SwiftUI__ y muestra un PDF con mi curriculum. Para mostrarlo utilizo la API de Apple __PDFKit__. Como PDFKit usa UIKit, utilizo un __UIViewRepresentable__ para mostrarlo en la vista de SwiftUI.

Además, he añadido un botón en la parte superior que permite compartir el archivo PDF que se está visualizando.

