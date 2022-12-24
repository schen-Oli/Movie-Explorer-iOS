//
//  mediaDetail.swift
//  USC Films
//
//  Created by 烁  陈 on 2021/4/20.
//

import Foundation
import Alamofire
import SwiftyJSON

let urlPre = "https://olishw9.azurewebsites.net/"

class YoutubeVideo {
    let url:String
    let hasVideo:Bool
    init(url:String = "", hasVideo:Bool = false){
        self.url = url
        self.hasVideo = hasVideo
    }
}

class mediaInfo {
    let title:String
    let dateAndGenre:String
    let rate:String
    let overview:String
    init(title:String = "", dateAndGenre:String = "", rate:String = "", overview:String = ""){
        self.title = title
        self.dateAndGenre = dateAndGenre
        self.rate = rate
        self.overview = overview
    }
}

class castInfo: Identifiable{
    let id = UUID()
    let name: String
    let pic: String
    init(name:String, pic:String){
        self.name = name
        self.pic = pic
    }
}

class Review: Identifiable{
    let id = UUID()
    let author : String
    let content: String
    let date: String
    let rate: String
    init(author:String, content:String, date:String, rate:String){
        self.author = author
        self.content = content
        self.date = date
        self.rate = rate
    }
}

class recCard: Identifiable{
    let id = UUID()
    let pic : String
    let mediaID : Int
    let type : String
    let title: String
    init(type:String, mediaID:Int, pic:String, title:String){
        self.type = type
        self.mediaID = mediaID
        self.pic = pic
        self.title = title
    }
}


class movieDetailModel : ObservableObject{
    
    @Published var isDetailData = false;
    
    public var video:YoutubeVideo = YoutubeVideo()
    public var mediaDetails:mediaInfo = mediaInfo()
    public var castList = [castInfo]()
    public var hasCast = false
    public var reviewList = [Review]()
    public var hasReview = false
    public var recCardList = [recCard]()
    public var hasRec = false
    
    init(type:String, id:Int){
        self.getVideo(type:type, id:id)
    }
    
    func getVideo(type:String, id:Int){
        AF.request(urlPre + "getVideo/" + type + "/" + String(id)).response { response in
            let videoData = try! JSON(data: response.data!)
            self.video = YoutubeVideo(
                url:videoData["key"].stringValue,
                hasVideo:videoData["hasVideo"].boolValue)
            self.getDetails(type:type, id:id)
        }
    }
    
    func getDetails(type:String, id:Int){
        AF.request(urlPre + "getDetail/" + type + "/" + String(id)).responseData { response in
            let videoDetail = try! JSON(data: response.data!)
            self.mediaDetails = mediaInfo(
                title:videoDetail["title"].stringValue,
                dateAndGenre:videoDetail["genres"].stringValue,
                rate:videoDetail["rate"].stringValue,
                overview:videoDetail["overview"].stringValue)
            self.getCast(type:type, id:id)
        }
    }
    
    func getCast(type:String, id:Int){
        AF.request(urlPre + "getCast/" + type + "/" + String(id)).response { response in
            let casts = try! JSON(data: response.data!)
            if(casts.count > 0){
                self.hasCast = true
                for cast in casts{
                    self.castList.append(castInfo(
                                            name:cast.1["name"].stringValue,
                                            pic:cast.1["profile"].stringValue))
                }
            }
            self.getReview(type:type, id:id)
        }
    }
    
    func getReview(type:String, id:Int){
        AF.request(urlPre + "getReview/" + type + "/" + String(id)).response { response in
            let reviews = try! JSON(data: response.data!)
            if(reviews.count > 0){
                self.hasReview = true
                for review in reviews{
                    let oneReview = Review(
                        author:review.1["author"].stringValue,
                        content:review.1["content"].stringValue,
                        date:review.1["date"].stringValue,
                        rate:review.1["rate"].stringValue)
                    self.reviewList.append(oneReview)
                    
                }
            }
            self.getRec(type: type, id: id)
        }
    }
    
    func getRec(type:String, id:Int){
        AF.request(urlPre + "getRec/" + type + "/" + String(id)).response { response in
            let recommend = try! JSON(data: response.data!)
            if(recommend.count > 0){
                self.hasRec = true
                for rec in recommend{
                    let oneRec = recCard(
                        type:rec.1["type"].stringValue,
                        mediaID: rec.1["id"].intValue,
                        pic:rec.1["poster"].stringValue,
                        title: rec.1["title"].stringValue)
                    self.recCardList.append(oneRec)
                }
            }
            self.isDetailData = true
        }
    }
    
    
    
    
}
