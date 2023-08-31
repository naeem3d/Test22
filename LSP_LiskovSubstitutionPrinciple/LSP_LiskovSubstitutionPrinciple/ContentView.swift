//
//  ContentView.swift
//  LSP_LiskovSubstitutionPrinciple
//
//  Created by naeem alabboodi on 8/31/23.
//

import SwiftUI

/*
 3. Liskov Substitution Principle (LSP):

 The LSP states that objects of a superclass should be replaceable with objects of its subclasses without affecting the correctness of the program. In SwiftUI, this means that subclassed views should be interchangeable with their parent views.


 In this example, we have a Shape class and a Circle2 subclass. The ShapeView can accept any Shape, including its subclasses like Circle2, without affecting the behavior. The CircleView is substitutable for the ShapeView.
 */
protocol Drawable {
    func draw() -> AnyView
}



struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading){
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            HStack {
                VStack(spacing: 0) {
                    ShapeView(shape: Circle2())
                    Text("ShapeView(shape: Circle2())")
                       
              
                }
                VStack(spacing: 0) {
                    ShapeView(shape: Circle3())
                    Text("ShapeView(shape: Circle3())")
                 
                }
                VStack(spacing: 0) {
                    ShapeView(shape: Circle4())
                    Text("ShapeView(shape: Circle4())")
                }
                VStack(spacing: 0) {
                    ShapeView(shape: Circle5())
                    Text("ShapeView(shape: Circle5())")
                }
              
            }
            .font(.system(size: 10))
         
         
        }
        .padding()
    }
}

#Preview {
    ContentView()
}


class shape: Drawable {
    func draw() -> AnyView {
        return AnyView(Text("Text View"))
    }
}

class Circle2: shape {
    override func draw() -> AnyView {
        let radius : CGFloat = 30
        let center = CGPoint(x: radius, y: radius)
        let circle = Path{ path in
            path.addArc(center: center, radius: radius, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: true)
        }
       
        return AnyView(circle.stroke(/*@START_MENU_TOKEN@*/Color.blue/*@END_MENU_TOKEN@*/, lineWidth: 2))
    }
}
class Circle3: Circle5 {
    override func draw() -> AnyView {
        let radius : CGFloat = 30
        let center = CGPoint(x: radius, y: radius)
        let circle = Path{ path in
            path.addArc(center: center, radius: radius, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: true)
        }
       
        return AnyView(circle.stroke(Color.red, lineWidth: 3))
    }
    
}
class Circle4: shape {
    override func draw() -> AnyView {
        let radius : CGFloat = 30
        let center = CGPoint(x: radius, y: radius)
        let circle = Path{ path in
            path.addArc(center: center, radius: radius, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: true)
        }
       
        return AnyView(circle.stroke(Color.purple, lineWidth: 5))
    }
}

class Circle5: Drawable {
    func draw() -> AnyView {
        let radius : CGFloat = 30
        let center = CGPoint(x: radius, y: radius)
        let circle = Path{ path in
            path.addArc(center: center, radius: radius, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: true)
        }
       
        return AnyView(circle.stroke(Color.green, lineWidth: 5))
    }
    
    
}


struct ShapeView: View {
    let shape: Drawable
    var body: some View {
        VStack {
            shape.draw()
        }
        .frame(width: 50,height: 100)
    }
}
