//
//  MediaDetail.swift
//  Movie-Explorer-iOS
//
//  Created by Oli Chen on 12/24/22.
//

import SwiftUI

struct MediaDetail: View {
    private var card : CardData
    @ObservedObject var stored : isStored
    @ObservedObject var toast = Toast()
    @ObservedObject var details : movieDetailModel
    
    init(card:CardData){
        self.card = card
        self.stored = isStored(card:card)
        self.details = movieDetailModel(type:card.type, id:card.mediaID)
    }
    
    var body: some View {
        
        if(details.isDetailData){
        
        ScrollView{
            if(details.video.hasVideo){
                HStack{ YTPlayerContainer(key:details.video.url) }.frame(height:200).padding()
            }
            HStack {
                Text(details.mediaDetails.title).font(.title).bold()
                Spacer()
            }.padding(.horizontal)
            .padding(.top, -5)
            
            HStack {
                Text(details.mediaDetails.dateAndGenre)
                    .font(.body)
                Spacer()
            }.padding(.horizontal)
            .padding(.top, 5)
            
            HStack{
                Image(systemName: "star.fill")
                    .foregroundColor(.red)
                    .font(.body)
                Text(details.mediaDetails.rate)
                    .font(.body)
                Spacer()
            }.padding(.horizontal)
            .padding(.top, 5)
            
            mediaOverview(overview: details.mediaDetails.overview)
                .padding()
                .padding(.top, -5)
            
            if details.hasCast {
                HStack(){
                    Text("Cast & Crew")
                        .font(.title)
                        .bold()
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.bottom, 5)
                .padding(.top, -5)
                castAndCrew(castList: details.castList)
            }
            
            if(details.hasReview){
                HStack(){
                    Text("Reviews")
                        .font(.title)
                        .bold()
                    Spacer()
                }.padding(.horizontal)
                .padding(.top, -5)
                mediaReview(reviews:details.reviewList, title:details.mediaDetails.title)
            }
            
            if(details.hasRec){
                HStack(){
                    if(self.card.type == "movie"){
                        Text("Recommended Movies")
                            .font(.title)
                            .bold()
                            .padding()
                    }else{
                        Text("Recommended TV Shows")
                            .font(.title)
                            .bold()
                            .padding()
                    }
                    Spacer()
                }
                recommend(recs: details.recCardList)
                    .padding(.horizontal)
                    .padding(.top, -15)
                    .padding(.bottom)
            }
        }.toolbar{
            ToolbarItemGroup(placement: .navigationBarTrailing){
                
                if(stored.mediaStored){
                    Button(action:{
                        stored.deleteDic()
                        toast.showToast = true
                        toast.text = card.title + " was removed from Watchlist"
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                              withAnimation {
                                toast.showToast = false
                              }
                            }
                    }){
                        Image(systemName: "bookmark.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20, alignment: .center)
                            .foregroundColor(.blue)
                        Text("")
                    }.padding(.horizontal, -3)
                }else{
                    Button(action:{
                        stored.addDic()
                        toast.showToast = true
                        toast.text = card.title + " was added to Watchlist"
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                              withAnimation {
                                toast.showToast = false
                              }
                            }
                    }){
                        Image(systemName: "bookmark")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20, alignment: .center)
                            .foregroundColor(.black)
                        Text("")
                    }.padding(.horizontal, -3)
                }
                
                HStack {
                    Button(action:{
                        guard let url = URL(string: "https://www.facebook.com/sharer/sharer.php?u=https%3A%2F%2Fwww.themoviedb.org%2F" + card.type + "%2F" + String(card.mediaID)) else { return }
                        UIApplication.shared.open(url)
                    }){
                        Image("facebook")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20, alignment: .center)
                    }
                    .frame(width: 20, height: 20, alignment: Ï)
                    Text("")
                }.padding(.horizontal, -3)
                
                HStack {
                    Button(action:{
                        guard let url = URL(string: "https://twitter.com/intent/tweet?text=Check%20out%20this%20this%20link:%0Ahttps%3A%2F%2Fwww.themoviedb.org%2F" + card.type + "%2F" + String(card.mediaID) + "%20%23CSCI571USCFilms") else { return }
                        UIApplication.shared.open(url)
                    }){
                        Image("twitter")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Text("")
                }.padding(.horizontal, -3)
                
                
            }
        }
        .onAppear{
            stored.storageCheck()
        }
        .toastFunc(toast: self.toast)
    }else{
    ProgressView("Fetching Data...")
    }
    }
}

struct MediaDetail_Previews: PreviewProvider {
    static var previews: some View {
        MediaDetail(card: CardData(
                        title: "This is a test",
                        mediaID: 412656,
                        pic: "https://image.tmdb.org/t/p/w500/6kbAMLteGO8yyewYau6bJ683sw7.jpg",
                        type: "movie",
                        date: "2021"))
    }
}
