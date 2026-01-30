//
//  ContentView.swift
//  VisionSpeechDemoApp
//
//  Created by Sean Goldsborough on 1/29/26.
//

import SwiftUI
import Vision
import Speech
import AVFoundation

struct ContentView: View {
    @StateObject private var viewModel = VisionSpeechViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Text("Vision + Speech OCR")
                    .font(.largeTitle)
                    .bold()

                CameraView(image: $viewModel.capturedImage)
                    .frame(height: 300)
                    .cornerRadius(12)

                Text("Recognized Text")
                    .font(.headline)

                ScrollView {
                    Text(viewModel.recognizedText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                }
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)

                HStack {
                    Button("Start Voice Command") {
                        viewModel.startListening()
                    }
                    Button("Stop") {
                        viewModel.stopListening()
                    }
                }
            }
            .padding()
        }
    }
}


#Preview {
    ContentView()
}
