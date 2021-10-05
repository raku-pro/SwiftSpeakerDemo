//
//  SwiftSpeaker.swift
//  SwiftSpeakerDemo
//
//  Created by raku-pro on 2021/10/05.
//

import Foundation
import AVFoundation

enum SwiftSpeakerError: Error {
    case faildLoadVoiceError
}


/// AVSpeechUtteranceに対する設定値
/// 各項目値はAVSpeechUtteranceを参照。
struct SwiftSpeakerConfiguration {
    
    /// AVSpeechSynthesisVoiceのidentifier
    let voiceIdentifier: String
    var rate: Float = AVSpeechUtteranceDefaultSpeechRate
    var volume: Float = 1.0
    var pitchMultiplier: Float = 1.0
    var prefersAssistiveTechnologySettings: Bool = false
    
    
    /// 発生文字列textに対応するutteranceを生成する
    /// - Parameter text: 発生させる文字列
    /// - Returns:
    func utterance(text: String) -> AVSpeechUtterance? {
        let utterance =  AVSpeechUtterance(string: text)
        guard let voice = self.voice ?? AVSpeechSynthesisVoice(language: "en-US") else {
            return nil
        }
        
        utterance.voice = voice
        utterance.rate = self.rate
        utterance.volume = self.volume
        utterance.pitchMultiplier = self.pitchMultiplier
        utterance.prefersAssistiveTechnologySettings = self.prefersAssistiveTechnologySettings
        
        return utterance
    }
    
    var voice: AVSpeechSynthesisVoice? {
        AVSpeechSynthesisVoice(identifier: voiceIdentifier)
    }
}


/// SwiftSpeaker
/// USAGE
/// case 1:
///
/// ```swift
/// SwiftSpeaker.shared.speak("hello")
/// ```
///
/// case 2:
///
/// ```swift
/// let configuration = SwiftSpeakerConfiguration(voiceIdentifier: "...")
/// configuration.rate = 1.0
/// SwiftSpeaker.shared.speak(configuration: configuration, text: "hello")
/// ```
///
class SwiftSpeaker {
    static let shared = SwiftSpeaker()
    let speaker = AVSpeechSynthesizer()
    
    private init() {
    }

    func speak(configration: SwiftSpeakerConfiguration? = nil, text: String) throws {
        
        var utterance: AVSpeechUtterance! = configration?.utterance(text: text)
        if utterance == nil {
            utterance =  AVSpeechUtterance(string: text)
            if let voice = AVSpeechSynthesisVoice(language: "en-US") {
                utterance.voice = voice
            } else {
                throw SwiftSpeakerError.faildLoadVoiceError
            }
        }

        if let configration = configration {
            utterance.rate = configration.rate
            utterance.volume = configration.volume
            utterance.pitchMultiplier = configration.pitchMultiplier
            utterance.prefersAssistiveTechnologySettings = configration.prefersAssistiveTechnologySettings
        }
        
        speaker.speak(utterance)
    }
}
