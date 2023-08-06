//
//  ContentView.swift
//  Instafilter
//
//  Created by Joseph Langat on 02/08/2023.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var blurAmount = 0.0 {
        didSet {
            print("New value is \(blurAmount)")
        }
    }
    @State private var showingConfirmation = false
    @State private var backgroundColor = Color.white
    @State private var image: Image?
    
    var body: some View {
        VStack {
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onAppear(perform: loadImage)
        /*
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
        */
    }
    func loadImage() {
        guard let inputImage = UIImage(named: "Movies") else { return }
           let beginImage = CIImage(image: inputImage)
//            image = Image("Movies")
        let context = CIContext()
//        let currentFilter = CIFilter.sepiaTone()
//        let currentFilter = CIFilter.pixellate()
//        let currentFilter = CIFilter.crystallize()
//        let currentFilter = CIFilter.sepiaTone()
        let currentFilter = CIFilter.twirlDistortion()
        currentFilter.inputImage = beginImage
//        currentFilter.intensity = 1
//        currentFilter.scale = 100
//        currentFilter.radius = 200
//        currentFilter.radius = 1000
//        currentFilter.center = CGPoint(x: inputImage.size.width / 2, y: inputImage.size.height / 2)
        
        let amount = 1.0

        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(amount, forKey: kCIInputIntensityKey) }
        
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey) }
        
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey) }
        
        // get a CIImage from our filter or exit if that fails
        guard let outputImage = currentFilter.outputImage else { return }

        // attempt to get a CGImage from our CIImage
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            // convert that to a UIImage
            let uiImage = UIImage(cgImage: cgimg)

            // and convert that to a SwiftUI image
            image = Image(uiImage: uiImage)
        }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
