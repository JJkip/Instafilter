//
//  ContentView.swift
//  Instafilter
//
//  Created by Joseph Langat on 02/08/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var blurAmount = 0.0 {
        didSet {
            print("New value is \(blurAmount)")
        }
    }
    @State private var showingConfirmation = false
    @State private var backgroundColor = Color.white
    
    var body: some View {
        VStack {
            Text("Blurred Text")
                .blur(radius: blurAmount)
            
            Slider(value: $blurAmount, in: 0...20)
                
            Button("Random Blur"){
                blurAmount = Double.random(in: 0...20)
            }
            
            Text("Click to show confirmation dialog")
                .frame(width:300, height: 300)
                .background(backgroundColor)
                .onTapGesture {
                    showingConfirmation = true
                }
                .confirmationDialog("Change background", isPresented: $showingConfirmation) {
                    Button("Red") { backgroundColor = .red}
                    Button("Green") { backgroundColor = .green}
                    Button("Blue") { backgroundColor = .blue}
                    Button("Cancel", role: .cancel) { }
                } message: {
                     Text("Select a new color")
                }
        }
        .onChange(of: blurAmount) { newValue in
            print("New value is \(newValue)")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
