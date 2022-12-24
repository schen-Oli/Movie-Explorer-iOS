//
//  YoutubePlayer.swift
//  USC Films
//
//  Created by 烁  陈 on 2021/4/20.
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

