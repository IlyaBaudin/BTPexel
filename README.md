# BTPexel

Test project for loading curated photos using PexelAPI.

There are many possible ways how to implement this basic application. I have chosen classic approach with MVC on UI side and POP approach on SDK side. This technical challenge can be solved using MVVM & SwiftUI, or VIPER or any another pattern.

Core logic implemented in PexelSDK target. Implementation using some abstractions for communication with backend. It allow application be very flexible for migration between different implementations like something ready, for example, Parse or Firebase or something custom like basic HTTP(S) backend or gRPC. 

Some code in SDK covered by simple tests for quick debug and demonstration XCTest framework usage. In real project it should be much more tests especially for edge cases and errors. These kind of scenarios should be reproduced using Mock implementations that conforms to required protocols (like NetworkServiceProtocol, RequestComposerProtocol, etc)

 Personally I prefer avoid using 3rd party libraries. However, I used SDWebImage for a long time in another projects and it handle asynchronous image loading for UIImageViews. In previous project, I implemented asynchronous downloading of images using GCD by hands without any libraries but here make sense to save some time and use this small Swift Package. 
