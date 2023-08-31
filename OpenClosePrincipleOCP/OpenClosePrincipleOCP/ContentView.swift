//
//  ContentView.swift
//  OpenClosePrincipleOCP
//
//  Created by naeem alabboodi on 8/31/23.
//
/*
 2. Open/Closed Principle (OCP):

 The OCP suggests that a class should be open for extension but closed for modification. In SwiftUI, you can achieve this by using protocols and extensions to add new behavior to existing views without modifying their original code.
 
 In this example, we have a ButtonView that takes a ButtonViewDelegate. The ContentView extends the delegate and implements buttonTapped() without modifying the original ButtonView. It keeps the ButtonView closed for modification and open for extension.
 */


import SwiftUI
protocol ButtonViewDelegate {
    func buttonToapped()
}

struct ButtonView: View  {
    var delegate: ButtonViewDelegate?
    var body: some View {
        Button("Tap Me") {
            delegate?.buttonToapped()
        }
    }
}
struct ContentView: View , ButtonViewDelegate {
    func buttonToapped() {
        // Handle button tap in ContentView
        print("button Tapped function")
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            ButtonView(delegate: self)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
