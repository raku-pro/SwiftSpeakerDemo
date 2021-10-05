//
//  SpeakerView.swift
//  SwiftSpeakerDemo
//
//  Created by raku-pro on 2021/10/05.
//

import SwiftUI
import AVFoundation


/// SpeakerView
/// 指定されたVoiceに対して設定項目を設定したり、発声させるページ
struct SpeakerView: View {
    
    @State var configuration: SwiftSpeakerConfiguration
    @State var text: String
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("text")
            TextEditor(text: $text)
                .padding(6)
                .border(Color.secondary, width: 2)
                .padding()

            SpeechConfigurationView(configuration: $configuration)
                .padding()
                .border(Color.secondary, width: 2)
                .padding()
            
            Button {
                try? SwiftSpeaker.shared.speak(configration: self.configuration, text: text)
            } label: {
                Image(systemName: "play")
                    .resizable()
                    .frame(width: 32, height: 32)
            }
            
            Button("Close") {
                presentationMode.wrappedValue.dismiss()
            }

        }
    }
}

struct SpeakerView_Previews: PreviewProvider {
    static var previews: some View {
        SpeakerView(configuration: SwiftSpeakerConfiguration(voiceIdentifier: "Kyoko"), text: "sample")
    }
}
