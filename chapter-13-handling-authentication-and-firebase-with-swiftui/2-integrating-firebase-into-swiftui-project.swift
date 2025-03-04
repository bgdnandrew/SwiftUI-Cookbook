// RemoteConfigApp.swift (XCode usually names the main file of an app  as ProjectNameApp.swift, and I refer to it as the app's entry point; ContentView.swift is the app's root view)

// Firebase Remote Config is a cloud-based service that allows you to dynamically update and customize your app’s behavior and appearance without requiring an app update.

// Modify App Settings Without an Update
// Change UI elements (e.g., button colors, layout changes)
// Enable or disable features dynamically

// A/B Testing (Experimenting with Variants)
//  Test different UI designs, pricing models, or ad placements
//  Roll out features to a small percentage of users before a full release

// Personalization
// Show different content based on user preferences, location, or device type
// Adjust difficulty levels in games dynamically

// Gradual Feature Rollouts (Feature Flags)
// Roll out a new feature to only 10% of users, then expand if successful
// Instantly disable a buggy feature

// Regional Customization
//  Show different promotions based on user country or language

import SwiftUI
import Firebase
import FirebaseRemoteConfigSwift






@main
struct RemoteConfigApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}





class RemoteConfiguration {
    private var remoteConfig = Firebase.RemoteConfig.remoteConfig()
    @RemoteConfigProperty(key: "screenType", fallback: nil) var screenType: String?
    
    init() {
        // Enable developer mode    
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
    }
    
    private func activate() {
        remoteConfig.activate { changed, error in
            guard error == nil else {
                print("Error activating Remote Config: \(error!.localizedDescription)")
                return
            }
            print("Default values were \(changed ? "" : "NOT ")updated from Remote Config")
        }
    }
    
    func fetchFromServer() async {
        guard let status = try? await remoteConfig.fetch(), status == .success else {
            print("Couldn't fetch Remote Config")
            return
        }
        print("Remote Config successfully fetched")
        activate()
    }
    
    func registerForRealtimeUpdates() {
        print("Registering for Remote Config realtime updates")
        remoteConfig.addOnConfigUpdateListener { [self] update, error in
            guard let update, error == nil else {
                print("Error listening for Remote Config realtime updates: \(error!.localizedDescription)")
                return
            }
            print("Updated keys in realtime: \(update.updatedKeys)")
            activate()
         }
    }
    
    var image: (name: String, color: Color) {
        if screenType == "screenA" {
            (name: "a.square", color: .green)
        } else if screenType == "screenB" {
            (name: "b.square", color: .blue)
        } else {
            (name: "questionmark.square", color: .red)
        }
    }
}





struct ContentView: View {    
    private var config = RemoteConfiguration()




    var body: some View {
        VStack {
            if config.screenType != nil {
                Image(systemName: config.image.name)
                    .foregroundStyle(config.image.color)
                    .font(.system(size: 250))
            } else {
                ProgressView()
                    .controlSize(.large)
            }
        }
        .task {
            await config.fetchFromServer()
            config.registerForRealtimeUpdates()
        }
    }
}
