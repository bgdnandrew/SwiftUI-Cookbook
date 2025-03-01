@State: 
- used to change state variable that belong to the same view
- these variables should not be visible outside theview and should be marked as private

@ObservedObject:
- used to change state variables for multiple, but connected views
- example: parent-child relationships
- these properties must have referece semantics (passing through address, as opposed to the default Swift behavior of passing through value), and the type must conform to the ObservableObject protocol

@StateObject:
- used to encapsulate the mutable state of a view in an external class
- it behaves like an ObservableObject, BUT its life cycle isn't tied to the life cycle of teh view that created it
- if the view is destroyed and then recreated because of a re-rendering, StateObject stays allocated
- a @StateObject is only initialized once per view lifecycle and persists across view re-creations.
- when a view is destroyed and recreated, SwiftUI does not destroy the @StateObject instance, as long as the view hierarchy still refers to it
- however, if the entire view hierarchy holding the @StateObject is destroyed, the @StateObject instance is also deallocated

@EnvironmentObject:
- when the variables are shared between multiple and unrelated views and defined somewhere else in the app
- for example, one can set the color and font themes as common objects that will be used everywhere in the app





- some of these property wrappers use **Combine** under the hood, to implement their fucntionalities
- for more complex interactions, Combine can be used directly by exploting its capabilities
