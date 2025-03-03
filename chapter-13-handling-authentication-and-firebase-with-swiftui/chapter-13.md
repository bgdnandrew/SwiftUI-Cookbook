Chapter 13, *Handling Authentication and Firebase with SwiftUI*, explains how to implement authentication in your app and store app data in a cloud database

- good to know (regarding implementing Sign In with Apple in a SwiftUI app):
- the framework will only pass the user's credentials the first time they log in, so we need to store them locally as well
- we can save them in an appropriate manner by using UserDefaults, but only for this demo's purposes (i.e.: by using the SwiftUI wrapper - @AppStorage("name"))
- UserDefaults is good enough for learnig purposes, but it is not secure, thus not suitable for production
- Production level code will use Keychain

