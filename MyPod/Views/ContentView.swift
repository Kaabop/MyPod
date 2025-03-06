// ContentView.swift
import SwiftUI
import AVFAudio

struct ContentView: View {
    @StateObject private var musicPlayer = MusicPlayer()

    init() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set audio session: \(error)")
        }
    }

    var body: some View {
        PlaylistView()
            .environmentObject(musicPlayer)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(MusicPlayer())
    }
}
