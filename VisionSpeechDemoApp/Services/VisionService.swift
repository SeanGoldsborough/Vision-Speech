
//
//  VisionManager.swift
//  VisionSpeechDemoApp
//
//  Created by Sean Goldsborough on 1/29/26.
//

import SwiftUI
import Vision
import Speech
import AVFoundation
import Combine

final class VisionService {
    func recognizeText(from image: UIImage, completion: @escaping (String) -> Void) {
        guard let cgImage = image.cgImage else { return }

        let request = VNRecognizeTextRequest { request, _ in
            let text = (request.results as? [VNRecognizedTextObservation])?
                .compactMap { $0.topCandidates(1).first?.string }
                .joined(separator: "\n") ?? ""
            completion(text)
        }
        request.recognitionLevel = .accurate

        let handler = VNImageRequestHandler(cgImage: cgImage)
        try? handler.perform([request])
    }
}


