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
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var filterIntensity = 0.5
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var showingFilterSheet = false
    
    let context = CIContext()
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill()
                    
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    // select an image
                    showingImagePicker = true
                }
                
                HStack {
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity) { _ in applyProcessing()}
                }
                .padding(.vertical)
                
                HStack {
                    Button("Change Filter") {
                        showingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save", action: save)
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .onChange(of: inputImage) { _ in loadimage()}
            .sheet(isPresented: $showingImagePicker){
                ImagePicker(image: $inputImage)
            }
            .confirmationDialog("Select a filter", isPresented: $showingFilterSheet) {
                Button("Cystallize"){ setFilter(CIFilter.crystallize())}
                Button("Edges"){ setFilter(CIFilter.edges())}
                Button("Gaussian Blur"){ setFilter(CIFilter.gaussianBlur())}
                Button("Pixallate"){ setFilter(CIFilter.pixellate())}
                Button("Sepia Tone"){ setFilter(CIFilter.sepiaTone())}
                Button("Unsharp Mask"){ setFilter(CIFilter.unsharpMask())}
                Button("Vignette"){ setFilter(CIFilter.vignette())}
                Button("Bloom"){ setFilter(CIFilter.bloom())}
                Button("Dither"){ setFilter(CIFilter.dither())}
//                Button("Vibrance"){ setFilter(CIFilter.vibrance())}
                Button("Cancel", role: .cancel) { }
            }
        }
    }
    
    func loadimage() {
        guard let inputImage = inputImage else { return }
//        image = Image(uiImage: inputImage)
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadimage()
    }
    func save(){
        
    }
    /*
     VStack {
     image?
     .resizable()
     .scaledToFit()
     Button("Select Image"){
     showingImagePicker = true
     }
     Button("Save Image"){
     guard let inputImage = inputImage else { return }
     
     let imageSaver = ImageSaver()
     imageSaver.writeToPhotoAlbum(image: inputImage)
     }
     }
     .sheet(isPresented: $showingImagePicker){
     ImagePicker(image: $inputImage)
     }
     .onChange(of: inputImage) { _ in loadSelectedImage() }
     */
    
    /*
     VStack {
     image?
     .resizable()
     .scaledToFit()
     }
     .onAppear(perform: loadImage)
     */
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
    
    /*
     func loadSelectedImage() {
     guard let inputImage = inputImage else { return }
     image = Image(uiImage: inputImage)
     
     //        UIImageWriteToSavedPhotosAlbum(inputImage, nil, nil, nil)
     }
     */
    /*
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
     */
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
