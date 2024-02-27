//
//  ContentView.swift
//  WebSocet
//
//  Created by naeem alabboodi on 2/15/24.
//



import SwiftUI
import Combine

struct ContentView: View {
    @StateObject var webSocketManager = WebSocketManager()
    @State private var messageToSend: String = ""
    @State private var receivedMessage: String = ""
    
    var body: some View {
        VStack {
            Text("Received message: \(receivedMessage)")
                .padding()
            
            TextField("Enter message", text: $messageToSend)
                .padding()
            
            Button("Send") {
                webSocketManager.sendMessage(messageToSend)
                messageToSend = ""
            }
            .padding()
        }
        .onReceive(webSocketManager.$receivedMessage, perform: { message in
            receivedMessage = message
        })
    }
}

class WebSocketManager: ObservableObject {
    private var webSocketTask: URLSessionWebSocketTask!
    @Published var receivedMessage: String = ""
    
    init() {
        connect()
        receiveMessages()
    }
    
    private func connect() {
        guard   let url = URL(string: "wss://echo.websocket.org") else {return}
        webSocketTask = URLSession.shared.webSocketTask(with: url)
        webSocketTask.resume()
    }
    
    func sendMessage(_ message: String) {
        let message = URLSessionWebSocketTask.Message.string(message)
    
        webSocketTask.send(message) { error in
            if let error = error {
                print("Error sending message: \(error)")
            }
        }
    }
    
    private func receiveMessages() {
        
        webSocketTask.receive { [weak self] result in
            switch result {
            case .success(let message):
                switch message {
                case .string(let text):
                    DispatchQueue.main.async {
                        self?.receivedMessage = text
                    }
                case .data(let data):
                    print("Received binary message: \(data)")
                @unknown default:
                    print("Received unknown message type")
                }
            case .failure(let error):
                print("Error receiving message: \(error)")
            }
            self?.receiveMessages() // Recursive call to keep listening for messages
        }
    }
}





#Preview {
    ContentView()
}
