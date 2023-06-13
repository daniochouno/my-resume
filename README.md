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
Throughout the development I have used __TDD__ (__Test Driven Development__). This development technique consists of first writing the tests that will define the feature. In this phase, __edge cases__ or extreme cases can be discovered that can condition the writing of the code that will later pass the tests.

Once the tests have been written, we move on to the next phase: writing the code that will fulfill the feature. Throughout this phase, the tests that we wrote previously will be launched to check the evolution of the development of the feature.

When all the tests pass, the feature can be terminated.

# Factory Pattern
I have used the __Factory__ pattern throughout the project for the creation and initialization of the classes and, for example, to be able to use protocols throughout the different layers. Using this pattern has also made it easier to write tests, because it allows you to follow __SOLID__ principles.

# About the app
The minimum supported version is __iOS 15__. This allows me to use SwiftUI in an advanced state of stability.

All the texts that appear in the application are localized and are displayed in __English (EN)__ or __Spanish (ES)__ depending on the language of the device on which it is run. By default English is used.

Application data is stored in various collections in __Firebase Firestore__ and is stored in a local application cache.

# Project structure
I have divided the project into different layers, following the principles of the __Clean__ architecture:

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

In the first one, the logo that I have used for this application is shown growing and decreasing hard.
