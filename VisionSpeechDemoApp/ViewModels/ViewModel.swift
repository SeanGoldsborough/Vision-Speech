//
//  ViewModel.swift
//  VisionSpeechDemoApp
//
//  Created by Sean Goldsborough on 1/29/26.
//

// MARK: - Vision + Speech SwiftUI Sample App (MVVM)
// iOS 16+
// Features:
// - Camera capture (Vision OCR)
// - Speech-to-command ("scan", "read")
// - MVVM architecture

import SwiftUI
import Vision
import Speech
import AVFoundation
import Combine

final class VisionSpeechViewModel: ObservableObject {
   // var objectWillChange: ObservableObjectPublisher
    
    @Published var recognizedText: String = ""
    @Published var capturedImage: UIImage?

    private let speechService = SpeechService()
    private let visionService = VisionService()

    init() {
        speechService.onCommand = handleCommand
    }

    func startListening() {
        speechService.start()
    }

    func stopListening() {
        speechService.stop()
    }

    private func handleCommand(_ command: String) {
        let lower = command.lowercased()
        if lower.contains("scan") || lower.contains("read") {
            runVision()
        }
    }

    private func runVision() {
        guard let image = capturedImage else { return }
        visionService.recognizeText(from: image) { text in
            DispatchQueue.main.async {
                self.recognizedText = text
            }
        }
    }
}

/*
INFO.PLIST REQUIRED KEYS:
- NSCameraUsageDescription
- NSMicrophoneUsageDescription
- NSSpeechRecognitionUsageDescription
*/
