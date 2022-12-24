//
//  carouselModal.swift
//  USC Films
//
//  Created by 烁  陈 on 2021/4/18.
//

import Foundation
import Alamofire
import SwiftyJSON

class MediaPre: Identifiable{
    let id = UUID()
    let title : String
    let mediaID : Int
    let pic : String
    let type : String
    init(title:String, mediaID:Int, pic:String, type:String){
        self.mediaID = mediaID
        self.title = title
        self.pic = pic
        self.type = type
    }
}

class carouselModel : ObservableObject {
   
    @Published var MovieInfo = [MediaPre]()
    @Published var TvInfo = [MediaPre]()
    
    @Published var isCarouselData = false;
    
    init(){
        self.getMovieCarousel()
    }
    
    func getMovieCarousel() {
        AF.request(urlPre + "playing/movie").response { response in
            let movies = try! JSON(data: response.data!)
            for movie in movies{
                let title = movie.1["title"].object as! String
                let mediaID = movie.1["id"].object as! Int
                let type = movie.1["type"].object as! String
                let pic = movie.1["backdrop"].object as! String
                let oneMovie = MediaPre(title: title, mediaID: mediaID, pic: pic, type: type)
                self.MovieInfo.append(oneMovie)
            }
            self.getTvCarousel()
        }
        
    }
    
    func getTvCarousel(){
        AF.request(urlPre + "playing/tv").response { response in
            let tvs = try! JSON(data: response.data!)
            for tv in tvs{
                let title = tv.1["title"].object as! String
                let mediaID = tv.1["id"].object as! Int
                let type = tv.1["type"].object as! String
                let pic = tv.1["backdrop"].object as! String
                let oneTv = MediaPre(title: title, mediaID: mediaID, pic: pic, type: type)
                self.TvInfo.append(oneTv)
            }
            self.isCarouselData = true
        }
       
    }
    
}
