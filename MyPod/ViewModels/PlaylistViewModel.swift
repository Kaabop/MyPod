// PlaylistViewModel.swift
import AVFoundation

class PlaylistViewModel: ObservableObject {
    @Published var songs: [Song] = []
    @Published var currentIndex: Int?

    func addSongs(urls: [URL]) {
        for url in urls {
            let song = Song(url: url)
            songs.append(song)
            extractMetadata(for: song)
        }
    }

    private func extractMetadata(for song: Song) {
        let asset = AVAsset(url: song.url)
        asset.loadValuesAsynchronously(forKeys: ["commonMetadata"]) {
            var title: String?
            var artist: String?
            for item in asset.commonMetadata {
                if item.commonKey?.rawValue == "title" {
                    title = item.value as? String
                } else if item.commonKey?.rawValue == "artist" {
                    artist = item.value as? String
                }
            }
            DispatchQueue.main.async {
                if let index = self.songs.firstIndex(where: { $0.id == song.id }) {
                    self.songs[index].title = title
                    self.songs[index].artist = artist
                }
            }
        }
    }
}
