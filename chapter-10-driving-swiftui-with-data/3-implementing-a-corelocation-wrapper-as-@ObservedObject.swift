# - @State is used when the state variable has value-type semantics; this is because any mutation of the property creates a new copy of the variable (Swift tends to encourage and prioritize value-type semantics, but reference semantics can never be ignored)

# - but what about a property with reference semantics?
# ! in this case, any mutation of the variable is applied to the variable itself, and SwiftUI cannot detect the variation by itself

# !!!
# - we must use a different property wrapper, @ObservedObject, and the observed object must conform to the ObservableObject protocol
# - furthermore, the properties (of this object that will be observed in the view) must be decorated with @Published property wrapper

# Basically, we are using a class as a state variable, and decide which properties will trigger a re-rendering of the view




# In this recipe, we are simply wrapping CLLoctionManager in an ObservableObject and publishing 2 properties: authorization status, current location.

import CoreLocation

class LocationManager: NSObject, ObservableObject {
    private let LocationManager = CLLocationManager()
    @Published var status: CLAuthorizationStatus?
    @Published var current: CLLocation?

    # init; we're configuring CLLocationManger to react when teh location changes by 10 meters 

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.distanceFilter = 10
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

# We are setting LocationManager as a delegate to CLLocationManager and using this extension to confirm it to the appropriate protocol
# - setting a delegate means that the LocationManager class (our custom class) is acting as a delegate for CLLocationManager
# - this extension makes LocationManager conform to the CLLocationManagerDelegate protocol, meaning that LocationManager will handle location updates and authorization changes from CLLocationManager

/* 

How Does Delegation Work?

- CLLocationManager Needs a Delegate
- CLLocationManager is responsible for providing location updates.
- However, it does not know where to send the updates unless you assign a delegate.

- locationManager.delegate = self (from LocationManager) tells CLLocationManager that whenever a location update happens, it should notify this instance of LocationManager



Why Use Delegates Instead of Closures?

- Apple’s delegate pattern allows for continuous event-driven updates.
- Using delegates reduces memory leaks compared to closures when dealing with system frameworks.
*/

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        status = manager.authorizationStatus
    }

    func locationManager{
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
        } { guard let location = locations.last else { return }
            current = location
        }
}


# Extension used to format the status in a descriptive way
extension Optional where Wrapped == CLAuthorizationStatus {
    var description: String {
        guard let self else {
            return "unknown"
         }

        switch self {
        case .notDetermined:
            return "notDetermined"
        case .authorizedWhenInUse:
            return "authorizedWhenInUse"
        case .authorizedAlways:
            return ".authorizedAlways"
        case .restricted:
            return "restricted"
        case .denied:
            return "denied"
        @unknown default:
            return "unknown"
        }
    }
}

# Similar formatting extension for CLLocation
extension Optional where Wrapped == CLLocation {
    var latitudeDescrption: String {
        guard let latitude = self?.coordinate.latitude else { return '-' }

        return String(format: "%.3f", latitude)
    }

    var longitudeDescrption: String {
        guard let longitude = self?.coordinate.longitude else { return '-' }
                                 
        return String(format: "%.3f", longitude)
    }
}





struct ContentView: View {
    @ObservedObject private var locationManager: LocationManager

    var body: some View {
        VStack {
            Text("Status: \(locationManager.status.description)")

            HStack {
                Text("Latitude: \(locationManager.current.latitudeDescription)")
                Text("Longitude: \(locationManager.current.longitudeDescription)")
            }
        } 
    }

#Preview { 
    ContentView(locationManager: LocationManager()) 
}

}


# Finally, we inject an instance of LocationManager into the ConetntView, from the App's entry Point (app structure)

struct SwiftUICoreLocationApp: App {
    var body: some Scene {
        WindowGroup {
            Content(locationmanager: LocationManager())
        }
    }
}
