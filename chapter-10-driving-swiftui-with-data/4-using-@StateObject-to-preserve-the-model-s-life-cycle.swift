# Creating an @ObservedObject in a View, ties the lifecylce of the object to the lifecyle of the view

# ObservedObject + View = stateless way of implementing features
# StateObject + View = statefull, StateObject doesn't get destroyed when a view rerenders

# Views are quite tricky, in the sense that they can get re-rendered (destroyed and rendered again) so fast, while still appearing on screen as nothing has changed. But something did change. If the view got destroyed, its associated ObservedObject got destroyed as well, losing its state

# Counter App for demoing @Stateobject





# ViewModel
class Counter: ObservableObject {
    @Published var value: Int = 0

    func inc() {
        value += 1
    }

    func dec() {
        value -= 1
    }
}





# View
struct CounterView: View {
    @ObservedObject var counter = Counter() // stateless
    // @StateObject var counter = Counter() // statefull; the value of the counter will be preserved whe the view that owns the Counter object is destroyed and created again

    var body: some View {
        VStack(spacing: 12) {
            Text("\(counter.value)")
            HStack(spacing: 12) {
                Button {
                    counter.dec()
                } label: {
                    Text("-")
                        .padding()
                        .foregroundStyle(.white)
                        .background(.red)
                }

                Button {
                    counter.inc()
                } label: {
                    Text("+")
                    .padding()
                    .foregroundStyle(.white)
                    .background(.green)
                }
            }
        }
    }
}





# ContentView
struct ContentView: View {
    @State var refreshedAt: Date = Date()

    var body: some View {
        VStack(spacing: 12) {
            Text("Refresh at ") + 
            Text(refreshedAt.formatted(date: .ommitted, time . standard

            CounterView()

            Button {
                refreshedAt = Date()
            } label: {
                Text("Refresh")
                    .padding()
                    .foregroundStyle(.white)
                    .background(.blue)
            }
        }
    } 
}
