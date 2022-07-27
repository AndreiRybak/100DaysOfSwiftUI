//
//  ContentView.swift
//  Instafilter
//
//  Created by Andrei Rybak on 27.07.22.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {

    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 100.0
    @State private var filterScale = 5.0
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    @State private var showingFilterSheet = false
    
    @State private var hasIntencity = false
    @State private var hasRadius = false
    @State private var hasScale = false

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    showingImagePicker = true
                }
                
                if hasIntencity {
                    HStack {
                        Text("Intensity")
                        Slider(value: $filterIntensity, in: 0...1)
                            .onChange(of: filterIntensity) { _ in aplyProcessing() }
                    }
                    .padding(.vertical)
                }
                
                if hasRadius {
                    HStack {
                        Text("Radius")
                        Slider(value: $filterRadius, in: 0...200)
                            .onChange(of: filterRadius) { _ in aplyProcessing() }
                    }
                    .padding(.vertical)
                }
                
                if hasScale {
                    HStack {
                        Text("Scale")
                        Slider(value: $filterScale, in: 0...10)
                            .onChange(of: filterScale) { _ in aplyProcessing() }
                    }
                    .padding(.vertical)
                }
                
                HStack {
                    Button("Change filter") {
                        showingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save a picture", action: save )
                        .disabled(image == nil)
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .onChange(of: inputImage) { _ in loadImage() }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .confirmationDialog("Select a filter", isPresented: $showingFilterSheet) {
                Group {
                    Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                    Button("Edges") { setFilter(CIFilter.edges()) }
                    Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                    Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                    Button("Sepia Tone") { setFilter(CIFilter.sepiaTone ()) }
                    Button("Vignette") { setFilter(CIFilter.vignette()) }
                }
                Group {
                    Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                    Button("Bolen Blur") { setFilter(CIFilter.bokehBlur()) }
                    Button("Noise Reduction") { setFilter(CIFilter.comicEffect()) }
                    Button("xRay") { setFilter(CIFilter.xRay()) }
                    Button("Cancel", role: .cancel) { }
                }
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }

        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        aplyProcessing()
    }

    func save() {
        guard let processedImage = processedImage else {
            return
        }
        let imageSaver = ImageSaver()

        imageSaver.successHandler = {
            print("Success")
        }
        
        imageSaver.errorHandler = {
            print("Oops! \($0.localizedDescription)")
        }

        imageSaver.writeToPhotoAlbum(image: processedImage)
    }
    
    func aplyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            hasIntencity = true
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        } else {
            hasIntencity = false
        }
        
        if inputKeys.contains(kCIInputRadiusKey) {
            hasRadius = true
            currentFilter.setValue(filterRadius, forKey: kCIInputRadiusKey)
        } else {
            hasRadius = false
        }
        
        if inputKeys.contains(kCIInputScaleKey) {
            hasScale = true
            currentFilter.setValue(filterScale, forKey: kCIInputScaleKey)
        } else {
            hasScale = false
        }

        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImage)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
