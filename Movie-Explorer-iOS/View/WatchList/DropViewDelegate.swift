//
//  DropViewDelegate.swift
//  Movie-Explorer-iOS
//
//  Created by Oli Chen on 12/24/22.
//

import Foundation

import SwiftUI

struct DropViewDelegate: DropDelegate {
    
    var card: CardData
    var watchList: watchListModel
   
    
    func performDrop(info: DropInfo) -> Bool {
       
        return true
    }
    
    func dropEntered(info: DropInfo) {
        
        
        let fromIndex = watchList.fullWatchList.firstIndex { (card) -> Bool in
            return card.id == watchList.currentDrag?.id
        } ?? 0
        
        let toIndex = watchList.fullWatchList.firstIndex { (card) -> Bool in
            return card.id == self.card.id
        } ?? 0
        
        if fromIndex != toIndex{
            withAnimation(.default){
            let fromCard = watchList.fullWatchList[fromIndex]
            watchList.fullWatchList[fromIndex] = watchList.fullWatchList[toIndex]
            watchList.fullWatchList[toIndex] = fromCard
            }
            watchList.update()
        }
        
    }
}
