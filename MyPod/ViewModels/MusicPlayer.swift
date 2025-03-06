// MusicPlayer.swift
import AVFoundation

class MusicPlayer: ObservableObject {
    @Published var isPlaying = false
    @Published var currentTime: TimeInterval = 0
    private var player: AVPlayer?
    private var timeObserver: Any?

    func play(url: URL) {
        player = AVPlayer(url: url)
        player?.play()
        isPlaying = true
        setupTimeObserver()
    }

    func pause() {
        player?.pause()
        isPlaying = false
    }

    private func setupTimeObserver() {
        let interval = CMTime(seconds: 1, preferredTimescale: 1)
        timeObserver = player?.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            self?.currentTime = time.seconds
        }
    }

    deinit {
        if let timeObserver = timeObserver {
            player?.removeTimeObserver(timeObserver)
        }
    }
}
