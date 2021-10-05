//
//  ContentView.swift
//  Shared
//
//  Created by raku-pro on 2021/10/05.
//

import SwiftUI
import AVFoundation

extension AVSpeechSynthesisVoice: Identifiable {
    public var id: String {
        return self.identifier
    }
}


/// アプリの実行環境の音声一覧を表示する
struct ContentView: View {
    static let voices = AVSpeechSynthesisVoice.speechVoices()
    
    @State var isPresentSheet = false
    @State var selectedVoice: AVSpeechSynthesisVoice? = nil
    
    var body: some View {
        List {
            ForEach(ContentView.voices, id: \.identifier) { voice in
                HStack {
                    Text(voice.name)
                    Text(voice.language)
                    Text(voice.identifier)
                }.onTapGesture {
                    selectedVoice = voice
                }
            }
        }.sheet(item: $selectedVoice) {
            // dismiss
        } content: { item in
            SpeakerView(configuration: SwiftSpeakerConfiguration(voiceIdentifier: item.identifier), text: "Hello")
                .frame(width: 360, height: 480)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
