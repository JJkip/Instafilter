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
    var body: some View {
        VStack {
            Text("Blurred Text")
                .blur(radius: blurAmount)
            
            Slider(value: $blurAmount, in: 0...20)
                
            Button("Random Blur"){
                blurAmount = Double.random(in: 0...20)
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
