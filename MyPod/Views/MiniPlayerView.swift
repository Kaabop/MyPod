// MiniPlayerView.swift
import SwiftUI

struct MiniPlayerView: View {
    @EnvironmentObject private var musicPlayer: MusicPlayer
    @EnvironmentObject private var playlistViewModel: PlaylistViewModel

    var body: some View {
        if let index = playlistViewModel.currentIndex {
            let song = playlistViewModel.songs[index]
            HStack {
                VStack(alignment: .leading) {
                    Text(song.title ?? song.url.lastPathComponent)
                        .font(.subheadline)
                    if let artist = song.artist {
                        Text(artist)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                Spacer()
                Button(action: {
                    if musicPlayer.isPlaying {
                        musicPlayer.pause()
                    } else {
                        musicPlayer.play(url: song.url)
                    }
                }) {
                    Image(systemName: musicPlayer.isPlaying ? "pause.fill" : "play.fill")
                        .font(.title2)
                }
            }
            .padding(.horizontal)
        } else {
            EmptyView()
        }
    }
}
