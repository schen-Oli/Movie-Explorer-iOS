//
//  searchMedia.swift
//  USC Films
//
//  Created by 烁  陈 on 2021/4/21.
//

import Foundation
import Alamofire
import SwiftyJSON

class resultMovie: Identifiable{
    let id = UUID()
    let pic : String
    let type : String
    let date : String
    let title : String
    let mediaID : Int
    let rate : String
    let poster: String
    init(title: String, type: String, mediaID: Int, pic:String, date: String, rate: String, poster: String){
        self.title = title
        self.type = type
        self.mediaID = mediaID
        self.pic = pic
        self.date = date
        self.rate = rate
        self.poster = poster
    }
}

class SearchMedia: ObservableObject{
    
    @Published var searchResults : [resultMovie] = []
    @Published var query = ""
    @Published var hasRes = true
    
    func find(){
        let url = urlPre + "searchMulti/" + query.replacingOccurrences(of: " ", with: "%20")
        AF.request(url).response{ res in
            let searchRes = try! JSON(data: res.data!)
            if(searchRes.count > 0){
                self.hasRes = true
                for oneRes in searchRes{
                    let tmpResMovie = resultMovie(
                        title: oneRes.1["title"].stringValue,
                        type: oneRes.1["type"].stringValue,
                        mediaID: oneRes.1["id"].intValue,
                        pic: oneRes.1["backdrop"].stringValue,
                        date: oneRes.1["date"].stringValue,
                        rate: oneRes.1["rate"].stringValue,
                        poster: oneRes.1["poster"].stringValue)
                    self.searchResults.append(tmpResMovie)
                }
            }else{
                self.hasRes = false
            }
        }
    }
    
}
