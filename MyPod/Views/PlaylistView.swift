// PlaylistView.swift
import SwiftUI

struct PlaylistView: View {
    @StateObject private var viewModel = PlaylistViewModel()
    @EnvironmentObject private var musicPlayer: MusicPlayer
    @State private var showingDocumentPicker = false

    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.songs) { song in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(song.title ?? song.url.lastPathComponent)
                                .font(.headline)
                            if let artist = song.artist {
                                Text(artist)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        Spacer()
                    }
                    .onTapGesture {
                        viewModel.currentIndex = viewModel.songs.firstIndex(of: song)
                        if let index = viewModel.currentIndex {
                            musicPlayer.play(url: viewModel.songs[index].url)
                        }
                    }
                }
                if viewModel.currentIndex != nil {
                    MiniPlayerView()
                        .frame(height: 60)
                        .background(Color(.systemBackground))
                        .overlay(Divider(), alignment: .top)
                }
            }
            .navigationTitle("Playlist")
            .toolbar {
                Button("Add Songs") {
                    showingDocumentPicker = true
                }
            }
            .sheet(isPresented: $showingDocumentPicker) {
                DocumentPickerView { urls in
                    viewModel.addSongs(urls: urls)
                }
            }
        }
    }
}
