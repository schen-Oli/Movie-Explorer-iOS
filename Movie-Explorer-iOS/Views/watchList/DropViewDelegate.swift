//
//  DropViewDelegate.swift
//  USC Films
//
//  Created by 烁  陈 on 2021/4/22.
//

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
