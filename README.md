[Ver versión en Español](../main/README_es.md)

![Platform](https://img.shields.io/badge/platform-iOS-lightgrey)
![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/daniochouno/my-resume?label=version)
![Unit tests](https://img.shields.io/badge/Unit%20Tests-44-success)
![SwiftUI](https://img.shields.io/badge/-SwiftUI-green)
![UIKit](https://img.shields.io/badge/-UIKit-green)
![MVVM](https://img.shields.io/badge/-MVVM-blue)
![VIPER](https://img.shields.io/badge/-VIPER-blue)
![Async/Await](https://img.shields.io/badge/-Async%20Await-orange)
![TDD](https://img.shields.io/badge/-TDD-9cf)

# Hello 👋
I am Daniel Martínez, an iOS application developer with more than 15 years of work experience, the last 8 of them specialized in iOS, and I have worked on the development of more than 10 iOS applications, most of them in desktop environments. continuous deployment on the AppStore (fast-paced environment), typically with a 2-week release cycle.

As additional projects to my work, I have created 3 applications from scratch that are available in the iOS and Android stores. One of them has been downloaded more than 100,000 times since it was published.

My strengths are the organization of tasks, my high level of autonomy and the maximum commitment to fidelity in the implementation of functionalities.

What motivates me the most and the main reason why I am passionate about my job is to be able to reach out and help anyone who owns a mobile phone, an iPhone, with my apps.

I consider myself a good team worker, open to discuss the best way to develop a feature and collaborate to improve it.

# About this project
This project was born to be able to show part of my skills as an iOS developer in a real and updated project.

I have used __SwiftUI__, __UIKit__, architectures like __MVVM__ and __VIPER__, network connections to a REST API using __Async/Await__, etc... without using any external library, only with the APIs provided by Apple in its native SDK. The source code of this application is available for anyone interested to view.

Below I describe in detail how I have developed the project and how I have created each feature.

# TDD
Throughout the development I have used __TDD__ (__Test Driven Development__). This development technique consists of first writing the tests that will define the feature. In this phase, __edge cases__ can be discovered that can condition the writing of the code that will later pass the tests.

Once the tests have been written, we move on to the next phase: writing the code that will fulfill the feature. Throughout this phase, the tests that we wrote previously will be launched to check the evolution of the development of the feature.

When all the tests pass, the feature can be finished.

# Factory Pattern
I have used the __Factory__ pattern throughout the project for the creation and initialization of the classes and, for example, to be able to use protocols throughout the different layers. Using this pattern has also made it easier to write tests, because it allows you to follow __SOLID__ principles.

# About the app
The minimum version supported is __iOS 15__. This allows me to use SwiftUI in an advanced state of stability.

All the texts that appear in the application are localized and are displayed in __English (EN)__ or __Spanish (ES)__ depending on the language of the device on which it is run. By default English is used.

Application data is stored in various collections in __Firebase Firestore__ and it is stored in a local cache too.

# Project structure
I have split the project into different layers, following the principles of the __Clean__ architecture:

### Data
Contains the __databases__, __Data Sources__, __Repositories__, and models used in this layer.

### Domain
Contains the __use cases__ and models used in this layer.

### Presentation
Contains the __resources__ (Assets, localized text strings, etc...) and the __views__ that are displayed in the application. Within this layer I have created a __features__ folder where I have subdivided each screen/view and I have included its ViewModels, Models, Interactors, Presenters, etc... according to the architecture used in each feature.

### Networking
In this layer I have included everything necessary to make the network connections. It is normally included in the __Data__ layer, but I wanted to separate it to give it more importance.

I have created a protocol __APIClient__ with a single method __fetch__ that will be in charge of making the call to the REST API. In the method implementation I create a __URLRequest__ with the request data and then call __URLSession__ using __Async/Await__. I check that the response has a valid status (between 200 and 299) and parse the content to the data type expected in the response.

### Settings
Here I have included the project configuration files and the necessary files for the Application Settings section, accessible from the operating system Settings.

# Features
Below I describe how I have developed each of the features/screens that I have included in the application.

## Splash
The view is written in __SwiftUI__ and has a 2-phase animation inspired by the initial animation of the __Twitter__ app.

In the first one, the logo I've used for this app is shown growing and shrinking for 5 seconds with a scaling effect, where each change between growing/decreasing lasts 0.65 seconds.

In the second, the logo grows until it completely covers the screen and lasts 1 second.

Afterwards, the navigation automatically takes place towards the main screen of the application.

I use a __ViewModel__ to control the various phases of the animation.

## Tabs
The view is written in __SwiftUI__ and contains a custom TabView with 3 options to view information about my career, skills, and other information about me.

The custom TabView includes an animation when navigating between the different items.

I use a __ViewModel__ to initialize the settings in the Settings.bundle when the screen is opened.

## Career
The view is written in __SwiftUI__ and contains a top menu with 2 options: my works and my personal projects.

## Works
This feature uses the __MVVM__ architecture.

The view is written in __SwiftUI__ and displays a listing of my work and professional experience. At the end of the list, a text is shown indicating whether the information has been loaded from the remote API or from the cache.

I use a __ViewModel__ to load the information. This ViewModel makes a call to the __use case__ that gets the data model which is then parsed to get the __model__ of the view.

The __use case__ (_domain_ layer) loads the list of jobs from the _data_ layer repository and sorts them by job start date.

The __repository__ has the logic of loading the data. It is the repository that determines whether the data in the cache is still valid, and if not, loads it from the remote API. For cache data to be valid, it must exist in the cache and must have been saved on or after the current date minus the cache expiration time. This expiration time can be changed in the application settings and by default it is __3600 seconds__ (1 hour). To access the cache data I use the __LocalCache__ data source, and to access the remote API data I use the __Firebase Firestore__ data source. Every time the data is fetched from the remote API the local cache is updated.

Firestore API calls need to be authenticated. So the first time I make a call to authenticate and get the session data: __access token__, __refresh token__ and __expires in__. When I get this data I store it in the local cache for the next calls, until the session data is no longer valid.

Both the __LocalCache__ data source and the __Session__ data source use __UserDefaults__ to hold cache data.

## Work Details
This feature uses the __MVVM__ architecture.

The view is written in __SwiftUI__ and shows the detail of a job after having selected it in the list above. At the end of the list, a text is shown indicating whether the information has been loaded from the remote API or from the cache.

I use a __ViewModel__ to load the information. This ViewModel makes a call to the __use case__ that gets the data model which is then parsed to get the __model__ of the view.

The __use case__ (_domain_ layer) loads all job data from the _data_ layer repository.

The __repository__ has the logic of loading the data. It is the repository that determines whether the data in the cache is still valid, and if not, loads it from the remote API. For cache data to be valid, it must exist in the cache and must have been saved on or after the current date minus the cache expiration time. This expiration time can be changed in the application settings and by default it is __3600 seconds__ (1 hour). To access the cache data I use the __LocalCache__ data source, and to access the remote API data I use the __Firebase Firestore__ data source. Every time the data is fetched from the remote API the local cache is updated.

Firestore API calls need to be authenticated. So the first time I make a call to authenticate and get the session data: __access token__, __refresh token__ and __expires in__. When I get this data I store it in the local cache for the next calls, until the session data is no longer valid.

Both the __LocalCache__ data source and the __Session__ data source use __UserDefaults__ to hold cache data.

## Pet Projects
This feature uses the __VIPER__ architecture.

The view is written in __SwiftUI__ and displays a list of my personal projects. At the end of the list, a text is shown indicating whether the information has been loaded from the remote API or from the cache.

I use a __Presenter__ to load the information. This Presenter calls the __Interactor__ and it is this that makes a call to the __use case__ that obtains the data model that is later parsed to obtain the __entities__ of the view.

The __use case__ (_domain_ layer) loads the list of personal projects from the _data_ layer repository and sorts them by number of app downloads.

The __repository__ has the logic of loading the data. It is the repository that determines whether the data in the cache is still valid, and if not, loads it from the remote API. For cache data to be valid, it must exist in the cache and must have been saved on or after the current date minus the cache expiration time. This expiration time can be changed in the application settings and by default it is __3600 seconds__ (1 hour). To access the cache data I use the __LocalCache__ data source, and to access the remote API data I use the __Firebase Firestore__ data source. Every time the data is fetched from the remote API the local cache is updated.

Firestore API calls need to be authenticated. So the first time I make a call to authenticate and get the session data: __access token__, __refresh token__ and __expires in__. When I get this data I store it in the local cache for the next calls, until the session data is no longer valid.

Both the __LocalCache__ data source and the __Session__ data source use __UserDefaults__ to hold cache data.

To access the detail of a personal project, use the __Router__.

## Pet Project Details
This feature uses the __MVVM__ architecture.

The view is written in __SwiftUI__ and shows the detail of a personal project after having selected it in the list above. At the end of the list, a text is shown indicating whether the information has been loaded from the remote API or from the cache.

I use a __ViewModel__ to load the information. This ViewModel makes a call to the __use case__ that gets the data model which is then parsed to get the __model__ of the view.

The __use case__ (_domain_ layer) loads all personal project data from the _data_ layer repository.

The __repository__ has the logic of loading the data. It is the repository that determines whether the data in the cache is still valid, and if not, loads it from the remote API. For cache data to be valid, it must exist in the cache and must have been saved on or after the current date minus the cache expiration time. This expiration time can be changed in the application settings and by default it is __3600 seconds__ (1 hour). To access the cache data I use the __LocalCache__ data source, and to access the remote API data I use the __Firebase Firestore__ data source. Every time the data is fetched from the remote API the local cache is updated.

Firestore API calls need to be authenticated. So the first time I make a call to authenticate and get the session data: __access token__, __refresh token__ and __expires in__. When I get this data I store it in the local cache for the next calls, until the session data is no longer valid.

Both the __LocalCache__ data source and the __Session__ data source use __UserDefaults__ to hold cache data.

## Skills
This feature uses the __MVVM__ architecture.

The view is written in __UIKit__ and displays a grouped listing of my professional skills. To display the view I have created a __Storyboard__ which contains a __UICollectionView__. This CollectionView has a cell type of __UICollectionViewCell__ to display the text that defines the skill along with its icon. Also, there is a __UICollectionReusableView__ that I use to display the category headers.

To integrate this view into __UIKit__ in the rest of the app, which uses __SwiftUI__, I've created a __UIViewControllerRepresentable__ that encapsulates it.

I use a __ViewModel__ to load the information. This ViewModel makes a call to the __use case__ that gets the data model which is then parsed to get the __model__ of the view.

The __use case__ (_domain_ layer) loads the list of professional skills from the _data_ layer repository.

The __repository__ loads the data from the __Json__ data source. Because it is a local file there is no need to establish a cache mechanism to access the data, so it is always loaded directly from the JSON.

The Json__ __data source reads the JSON file from the database and parses its content.

## About me
The view is written in __SwiftUI__ and displays various texts with information about me and this project.

## PDF Viewer
The view is written in __SwiftUI__ and displays a PDF of my resume. To display it I use the Apple API __PDFKit__. Since PDFKit uses UIKit, I use a __UIViewRepresentable__ to display it in the SwiftUI view.

In addition, I have added a button at the top that allows you to share the PDF file that is being viewed.
