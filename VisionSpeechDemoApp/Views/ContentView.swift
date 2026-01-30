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

// MARK: - VIEW
struct ContentView: View {
    @StateObject private var viewModel = VisionSpeechViewModel()
    @State private var showPicker = false

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                header


                ScrollView {
                    VStack(spacing: 20) {
                        cameraCard
                        textCard
                        controls
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showPicker) {
                CameraView(image: $viewModel.capturedImage)
            }
        }
    }


    // MARK: - UI Sections


    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Vision + Speech OCR")
                .font(.system(size: 28, weight: .bold))
            Text("Hands‑free camera text recognition")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.systemBackground))
    }


    private var cameraCard: some View {
        VStack(spacing: 12) {
            ZStack {
                if let image = viewModel.capturedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                } else {
                    VStack(spacing: 8) {
                        Image(systemName: "camera.viewfinder")
                            .font(.system(size: 40))
                            .foregroundColor(.secondary)
                        Text("Capture an image")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .frame(height: 220)
            .clipped()
            .cornerRadius(14)


            Button {
                showPicker = true
            } label: {
                Label("Open Camera", systemImage: "camera")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
        }
        .cardStyle()
    }


    private var textCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Recognized Text")
                .font(.headline)


        }
    }
    private var controls: some View {
        HStack(spacing: 12) {
            Button {
                viewModel.startListening()
            } label: {
                Label("Voice Command", systemImage: "mic.fill")
            }
            .buttonStyle(.bordered)


            Button {
                viewModel.stopListening()
            } label: {
                Label("Stop", systemImage: "stop.fill")
            }
            .buttonStyle(.bordered)
        }
    }
}

#Preview {
    ContentView()
}


