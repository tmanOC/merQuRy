# merQuRy
iOS demo Contacts QR app using Onion/MVVM inspired architecture, storyboards and basic autolayout. Only core libraries are used in this project, although it is structured in such a way as to easily be able to swap in your favourite Database or Networking library by implementing the correct protocols.

## What this app does
The main screen is a table of contacts. Each contact has a name, surname and mobile number.
There's a + button in the top right to add contacts.
Clicking on a contact takes you to a qr code that contains the contact information.

## The QR Code
Each string of a Contact's data is base64encoded and join with a comma separator. That's how the data sent to the service that sends back the qr code image. This is so that the qr code can handle many different characters in the contact information.

## The outer layer of the onion
- `FileDatabase` class: Contacts are stored as dictionaries in an array in a file using `NSKeyedArchiver`.
- `SimpleNetwork` class: The network call to get a qr code image is handled with `URLSession`.
- The UI is UIKit: `UIViewController`,`UITableViewController` and storyboards
- Unit Tests with `XCTest`

## The Views in MVVM
In this app the views are made of everything UIKit. So the Storyboards, View Controllers and Table View Cells are the view code. These handle any layout,view and routing related code. The view controllers also build/instantiate ViewModels, this may be improved by adding some kind of Dependency Injection. Any interactions with data is passed to ViewModels.

## The ViewModels
Each View/ViewController in the app has its own ViewModel. The ViewModels are the second layer of the onion. Whenever the view needs actual work done such as saving or retrieving data, the ViewModel will do it by connecting the View to the other services.

## The Model
The database classes and the inner 2 layers of the onion are
- `ContactRepository` uses the `CreateAndRead` interface implemented by `FileDatabase` to read and write contact data. (The `NetworkGet` interface can also be considered as part of this layer)
- `ContactModel` a plain old swift `struct` representing contact data

## Further ideas/improvements
- Add a ViewController that scans the qr codes for contact sharing
- Adding a better form of dependency injection. Passing dependencies from/through ViewControllers can get a bit tedious.

## This code is free to use
I've wanted to write an example app with onion/mvvm ideas for a while and here it is.
