//
//  watchListModel.swift
//  USC Films
//
//  Created by 烁  陈 on 2021/4/22.
//

import Foundation


class watchListModel: ObservableObject {
    
    @Published var fullWatchList : [CardData] = []    
    @Published var currentDrag : CardData?
    @Published var isEmpty = true
    
    init(){
        self.checkStorage()
    }
    
    private func checkStorage(){
        let stored = UserDefaults.standard.array(forKey: "watchList")
        if(stored != nil){
            let tmpWatchList = stored as! [[String: Any]]
            self.isEmpty = tmpWatchList.count == 0
            for media in tmpWatchList {
                let title = media["title"] as! String
                let mediaID = media["id"] as! Int
                let pic = media["pic"] as! String
                let type = media["type"] as! String
                let tmpCard = CardData(title: title, mediaID: mediaID, pic: pic, type: type, date: "")
                self.fullWatchList.append(tmpCard)
            }
        }else{
            let tmpDic:[[String:Any]] = []
            UserDefaults.standard.setValue(tmpDic, forKey: "watchList")
        }
        //print(fullWatchList)
    }
    
    public func update(){
        var tmpStore : [[String:Any]] = []
        for card in self.fullWatchList {
            let tmpOneMediaInStore : [String:Any] = ["title":card.title, "id":card.mediaID, "pic":card.pic, "type":card.type]
            tmpStore.append(tmpOneMediaInStore)
        }
        UserDefaults.standard.setValue(tmpStore, forKey: "watchList")
    }
    
    public func reLoad(){
        self.isEmpty = false
        self.fullWatchList = []
        self.checkStorage()
    }
    
    public func deleteCard(delCard:CardData){
        for (index, card) in self.fullWatchList.enumerated(){
            if card.id == delCard.id{
                fullWatchList.remove(at: index)
            }
        }
        self.update()
        if(fullWatchList.count == 0){
            self.isEmpty = true
        }
    }
    
}
