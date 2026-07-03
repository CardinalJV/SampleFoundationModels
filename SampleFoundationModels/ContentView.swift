//
//  ContentView.swift
//  SampleFoundationModels
//
//  Created by Viranaiken Jessy on 04/12/25.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    
    @Environment(SmartController.self) private var smartController
    @State var filters: [String] = []
    @State private var isPresented: Bool = false
    @State private var selectedPhotos: [PhotosPickerItem] = []
    @State private var images: [Image] = []
    
    func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
        return imageSelection.loadTransferable(type: Image.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image?):
                    // Handle the success case with the image.
                    self.images.append(image)
                case .success(nil):
                    // Handle the success case with an empty value.
                    print("Error loading image")
                case .failure(let error):
                    // Handle the failure case with the provided error.
                    print("Error loading image: \(error.localizedDescription)")
                }
            }
        }
    }
    
   func convertPickerItems() {
        for item in selectedPhotos {
            self.loadTransferable(from: item)
        }
       print(self.images)
    }
    
    var body: some View {
        VStack {
            Text("Hello, World!")
            List{
                Button("Peanuts"){
                    self.filters.append("peanut")
                }
                .buttonStyle(.plain)
                Button("Tree nuts") {
                    self.filters.append("tree nut")
                }
                .buttonStyle(.plain)
                Button("Cow’s milk") {
                    self.filters.append("cow’s milk")
                }
                .buttonStyle(.plain)
                Button("Egg") {
                    self.filters.append("egg")
                }
                .buttonStyle(.plain)
                Button("Seafood") {
                    self.filters.append("seafood")
                }
                .buttonStyle(.plain)
            }
            PhotosPicker(selection: self.$selectedPhotos, matching: .images) {
                Text("Select photos")
            }
        }
        
    }
}
