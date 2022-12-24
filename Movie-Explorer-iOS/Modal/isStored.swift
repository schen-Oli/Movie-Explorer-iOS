//
//  isStored.swift
//  USC Films
//
//  Created by 烁  陈 on 2021/4/19.
//

import Foundation
import SwiftUI

class isStored : ObservableObject {
   
    @Published var mediaStored:Bool = false

    private var card : CardData
    private var fullList : [[String: Any]] = []
    private var index = -1
    
    init(card:CardData){
        self.card = card
        self.storageCheck()
    }
      
    public func storageCheck(){
        let tmpList = UserDefaults.standard.array(forKey: "watchList")
        if(tmpList != nil){
            self.fullList = tmpList as! [[String: Any]]
            self.mediaStored = checkIfInList()
        }else{
            let tmpAdd : [CardData] = []
            UserDefaults.standard.setValue(tmpAdd, forKey: "watchList")
            self.mediaStored = false
        }
    }
    
    private func checkIfInList()->Bool{
        for i in 0..<self.fullList.count {
            let card = fullList[i]
            if card["id"] as! Int == self.card.mediaID {
                self.index = i
                return true
            }
        }
        return false
    }
   
    public func deleteDic(){
        fullList.remove(at: self.index)
        UserDefaults.standard.setValue(fullList, forKey: "watchList")
        self.mediaStored = false
    }
    
    public func addDic(){
        let tmpDic = ["type":card.type, "id":card.mediaID, "pic":card.pic, "title":card.title] as [String : Any]
        fullList.append(tmpDic)
        UserDefaults.standard.setValue(fullList, forKey: "watchList")
        self.mediaStored = true
        self.index = self.fullList.count - 1
    }
    
}
