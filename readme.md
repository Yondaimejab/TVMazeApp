TVMazeApp

TVMazeApp is an iOS application built using SwiftUI that provides users with TV show schedules, episode details, and more, leveraging the TVMaze API.

Features

Browse TV shows and schedules.

View detailed episode information.

Organized using MVVM architecture.

Utilizes SwiftUI for a seamless UI experience.

Handles networking with a custom API client.

Technologies Used

SwiftUI – Declarative UI framework.

Combine – Manages asynchronous data flow.

Async/await  – Manages asynchronous data flow.

MVVM Architecture – Separates concerns for better maintainability.

Networking Layer – Custom-built API client.

Asset Management – Uses Assets.xcassets for design elements.


Video
-----

<video controls>
  <source src="appInPlay.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>

Project Structure

TVMazeApp/
│── TVMazeAppApp.swift       # App entry point
│── ContentView.swift        # Main UI view
├── Networking/
├── Model/
├── Application/
│   ├── ViewModels/
│   ├── Features/
│   ├── SharedViews/
├── Assets.xcassets/         # App icons and colors

Setup Instructions

Clone the repository.

Open the project in Xcode.

Build and run the project using an iOS simulator or device.

Package Manager (SPM)

— Networking extension is a private extention build by me to fast track Networking layers.

License

This project is licensed under the MIT License.

**Addresed All Required Features and added unit tests.**
