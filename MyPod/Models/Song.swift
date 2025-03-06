// Song.swift
import Foundation

struct Song: Identifiable, Equatable {
    let id = UUID()
    let url: URL
    var title: String?
    var artist: String?
}
