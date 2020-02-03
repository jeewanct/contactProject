## 1. Contact App Assignment (Go -Jek)
GO-JEK Assignment by [Siti Khadijah](mailto://siti.khadijah@go-jek.com).

## 2. Requirements
- iOS 11.0+
- [Xcode 11.3.1](https://download.developer.apple.com/Developer_Tools/Xcode_11.3/Xcode_11.3.xip) 
- [Swift Package Manager](https://swift.org/package-manager/)


## 3. Getting Start
- Open `ContactProject.xcodeproj` in Xcode 11.3.1
- Build the project

## 4. Problem Statements
[Problem Statements](./GO-JEKiOSProblemStatement.pdf)

## 5. Swift
This project is build using Swift 5.

## 6. 3rd Party
- [MBProgressHUD](https://github.com/jdg/MBProgressHUD)
​This project using MBProgressHUD 3rd party dependency. Because less 3rd party means higher selection chances. I added this 3rd party just to demonstrate the use of the dependency manager (Swift package manager).
-[IQKeyboardManager](https://github.com/hackiftekhar/IQKeyboardManager)
For handling Keyboard 
-[SDWebImage](https://github.com/SDWebImage/SDWebImage)
For downloading and caching image from server


## 7. Table View and Collection View
Custom created generic solution of table view and collection view delegates and datasource . Simply you have to create models of Generic section and Generic rows and have to pass to GenericTable and GenericCollection. 


## 8. Unit and UI Test case
 - Total number of test cases - **`27`**
 - Unit test cases - **`14`**
 - UI test cases - **`13`**
 - Code coverage - **`82%`**


## 9. Architecture
In this project, I'm using MVVM architecture. For binding purposes, I'm using the  completions to bind objects from ViewModels.



