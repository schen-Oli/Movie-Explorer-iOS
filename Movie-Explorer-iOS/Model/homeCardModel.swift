//
//  homeCardModel.swift
//  USC Films
//
//  Created by 烁  陈 on 2021/4/19.
//

import Foundation
import Alamofire
import SwiftyJSON

class CardData: Identifiable{
    
    let id = UUID()
    let title : String
    let mediaID : Int
    let pic : String
    let type : String
    let date : String
    
    init(title:String, mediaID:Int, pic:String, type:String, date:String){
        self.mediaID = mediaID
        self.title = title
        self.pic = pic
        self.type = type
        self.date = date
    }
    
}

class homeCardModel : ObservableObject {
    
    @Published var movieTopRated = [CardData]()
    @Published var moviePopular = [CardData]()
    @Published var tvTopRated = [CardData]()
    @Published var tvPopular = [CardData]()
    
    @Published var isHomeCardData = false;
    
    
    init(){
        self.getMovieTopRated()
    }
    
    func getMovieTopRated(){
        AF.request(urlPre + "media/movie/top_rated").response { response in
            let movies = try! JSON(data: response.data!)
            for movie in movies{
                let title = movie.1["title"].object as! String
                let mediaID = movie.1["id"].object as! Int
                let type = movie.1["type"].object as! String
                let pic = movie.1["poster"].object as! String
                let date = movie.1["date"].object as! String
                let oneMovie = CardData(title: title, mediaID: mediaID, pic: pic, type: type, date: date)
                self.movieTopRated.append(oneMovie)
            }
            self.getMoviePopular()
        }
      
    }
    
    func getMoviePopular(){
        AF.request(urlPre + "media/movie/popular").response { response in
            let movies = try! JSON(data: response.data!)
            for movie in movies{
                let title = movie.1["title"].object as! String
                let mediaID = movie.1["id"].object as! Int
                let type = movie.1["type"].object as! String
                let pic = movie.1["poster"].object as! String
                let date = movie.1["date"].object as! String
                let oneMovie = CardData(title: title, mediaID: mediaID, pic: pic, type: type, date: date)
                self.moviePopular.append(oneMovie)
            }
            self.getTvTopRated()
        }
    }
    
    func getTvTopRated(){
        AF.request(urlPre + "media/tv/top_rated").response { response in
            let tvs = try! JSON(data: response.data!)
            for tv in tvs{
                let title = tv.1["title"].object as! String
                let mediaID = tv.1["id"].object as! Int
                let type = tv.1["type"].object as! String
                let pic = tv.1["poster"].object as! String
                let date = tv.1["date"].object as! String
                let oneTv = CardData(title: title, mediaID: mediaID, pic: pic, type: type, date: date)
                self.tvTopRated.append(oneTv)
            }
            self.getTvPopular()
        }
        
    }
    
    func getTvPopular(){
        AF.request(urlPre + "media/tv/popular").response { response in
            let tvs = try! JSON(data: response.data!)
            for tv in tvs{
                let title = tv.1["title"].object as! String
                let mediaID = tv.1["id"].object as! Int
                let type = tv.1["type"].object as! String
                let pic = tv.1["poster"].object as! String
                let date = tv.1["date"].object as! String
                let oneTv = CardData(title: title, mediaID: mediaID, pic: pic, type: type, date: date)
                self.tvPopular.append(oneTv)
            }
            self.isHomeCardData = true
        }
        
    }
    
   
    
    
}
