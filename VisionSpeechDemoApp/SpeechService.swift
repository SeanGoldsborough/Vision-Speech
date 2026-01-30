//
//  SpeechService.swift
//  VisionSpeechDemoApp
//
//  Created by Sean Goldsborough on 1/29/26.
//

import SwiftUI
import Vision
import Speech
import AVFoundation
import Combine

final class SpeechService: NSObject {
    var onCommand: ((String) -> Void)?

    private let recognizer = SFSpeechRecognizer()
    private let engine = AVAudioEngine()
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var task: SFSpeechRecognitionTask?

    func start() {
        SFSpeechRecognizer.requestAuthorization { status in
            guard status == .authorized else { return }

            DispatchQueue.main.async {
                self.request = SFSpeechAudioBufferRecognitionRequest()
                let node = self.engine.inputNode
                let format = node.outputFormat(forBus: 0)

                node.installTap(onBus: 0, bufferSize: 1024, format: format) { buffer, _ in
                    self.request?.append(buffer)
                }

                self.engine.prepare()
                try? self.engine.start()

                self.task = self.recognizer?.recognitionTask(with: self.request!) { result, _ in
                    if let text = result?.bestTranscription.formattedString {
                        self.onCommand?(text)
                    }
                }
            }
        }
    }

    func stop() {
        engine.stop()
        engine.inputNode.removeTap(onBus: 0)
        request?.endAudio()
        task?.cancel()
    }
}
