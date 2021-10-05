//
//  SpeechConfigurationView.swift
//  SwiftSpeakerDemo
//
//  Created by raku-pro on 2021/10/05.
//

import SwiftUI
import AVFoundation

struct SpeechConfigurationView: View {
    @Binding var configuration: SwiftSpeakerConfiguration
    
    var body: some View {
        VStack {
            // NOTE: SliderはiOS環境では、Labelが表示されないバグがある。
            Slider(value: $configuration.pitchMultiplier, in: 0.5...2.0, step: 0.1) {
                Text(String(format: "pitch %.1f", configuration.pitchMultiplier))
            }
            Slider(value: $configuration.volume, in: 0.0...1.0, step: 0.1) {
                Text(String(format: "volume %.1f", configuration.volume))
            }
            Slider(value: $configuration.rate, in: AVSpeechUtteranceMinimumSpeechRate...AVSpeechUtteranceMaximumSpeechRate, step: 0.1) {
                Text(String(format: "rate %.1f", configuration.rate))
            }
            HStack {
                Toggle(isOn: $configuration.prefersAssistiveTechnologySettings) {
                    Text("assitive")
                }
                Spacer()
            }
        }
    }
}

struct SpeechConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        SpeechConfigurationView(configuration: Binding.constant(SwiftSpeakerConfiguration(voiceIdentifier: AVSpeechSynthesisVoice(language: "en-US")!.identifier)))
    }
}
