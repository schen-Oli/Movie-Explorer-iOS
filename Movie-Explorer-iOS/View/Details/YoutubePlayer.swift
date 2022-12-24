//
//  YoutubePlayer.swift
//  Movie-Explorer-iOS
//
//  Created by Oli Chen on 12/24/22.
//

import SwiftUI
import youtube_ios_player_helper

struct YTPlayerContainer: UIViewRepresentable {
    
    var key : String
    
    func makeUIView(context: Context) -> YTPlayerView {
        let playerView = YTPlayerView()
        playerView.load(withVideoId: key, playerVars: ["playsinline": "1"])
        
        return playerView
    }
    
    func updateUIView(_ uiView: YTPlayerView, context: Context) {
    }
}
