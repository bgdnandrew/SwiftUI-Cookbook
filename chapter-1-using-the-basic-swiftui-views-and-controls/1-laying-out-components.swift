var body: some View {
    VStack {
        Text("VStack Item 1")
        Text("VStack Item 2")
        Spacer()
        Divider()
            .background(.black)
        Text("VStack Item 3")

        HStack {
            Text("HStack Item 1")
            Divider()
                .background(.black)
            Text("HStack Item 2")
            Divider()
                .background(.black)
            Spacer()
            Text("HStack Item 3")
        }
        .background(Color.red)

        ZStack {
            Text("ZStack Item 1")
                .padding()
                .background(.green)
                .opacity(0.8)

            Text("ZStack Item 2")
                .padding()
                .background(.green)
                .opacity(x: 89, y: -400)
        }
    }
    .background(.blue)
}




/*
SwiftUI container views like VStack determine how to display content by using the following steps:

1. Figure out its internal spacing and subtract that from teh size proposed by the parent view
2. Divide the reminaing space into equal parts
3. Process the size of its least flexible view
4. Divide the remaining unclaimed pace by the unallocated spce and repeat Step 2
5. The stack then aigns its content and chooses its own size to exactly enclose its children


You can also use the .frame modifier to adjsut the width and heiht of a component

Delete Spacer() and Divider() from the HStack and then apply this modifier to the HStack:

.frame(
    maxWidth: .infinity,
    maxHeight: .infinity
    alignment: .topLeading
)

*/
