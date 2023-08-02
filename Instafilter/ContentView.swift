//
//  ContentView.swift
//  Instafilter
//
//  Created by Joseph Langat on 02/08/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var blurAmount = 0.0
    var body: some View {
        VStack {
            Text("Blurred Text")
                .blur(radius: blurAmount)
            
            Slider(value: $blurAmount, in: 0...20)
            
            Button("Random Blur"){
                blurAmount = Double.random(in: 0...20)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
