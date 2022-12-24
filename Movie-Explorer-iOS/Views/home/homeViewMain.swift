//
//  homeViewMain.swift
//  USC Films
//
//  Created by 烁  陈 on 2021/4/17.
//

import SwiftUI


struct homeViewMain: View {
    
    var movieCarouselData = [MediaPre]()
    var tvCarouselData = [MediaPre]()
    
    var movieTopRated = [CardData]()
    var moviePopular = [CardData]()
    var tvTopRated = [CardData]()
    var tvPopular = [CardData]()
    
    @State private var isMovie : Bool = true
    
    @ObservedObject var toast : Toast
    @ObservedObject var medias : carouselModel
    @ObservedObject var cards : homeCardModel
    
    init(){
        self.medias = carouselModel()
        self.cards = homeCardModel()
        self.toast = Toast()
    }
    
    var body: some View {
        
        if(medias.isCarouselData && cards.isHomeCardData){
        NavigationView{
            ScrollView{
                // Carousel
                HStack{
                    Text(self.isMovie ? "Now Playing" : "Trending")
                        .padding(.leading)
                        .font(Font.system(size: 20, weight: .semibold))
                    Spacer()
                }
                
                VStack{
                    let media = isMovie ? medias.MovieInfo : medias.TvInfo
                    carousel(medias: media)
                }
                
                VStack(alignment: .leading){
                    Text("Top Rated")
                        .padding(.top, 5)
                        .padding(.bottom, -5)
                        
                        .font(Font.system(size: 20, weight: .semibold))
                    
                    let mediaTR = isMovie ? cards.movieTopRated : cards.tvTopRated
                    cardList(cards:mediaTR, toast: self.toast)
                        .padding(.leading, 5)
                    
                    Text("Popular")
                        .padding(.top, 5)
                        .padding(.bottom, -5)
                        
                        .font(Font.system(size: 20, weight: .semibold))
                    
                    let mediaPop = isMovie ? cards.moviePopular : cards.tvPopular
                    cardList(cards:mediaPop, toast: self.toast)
                       
                    
                }.padding(.horizontal)
                
                VStack{
                    Link("Powered by TMDB", destination: URL(string: "https://www.themoviedb.org")!)
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                    Text("Developed by Shuo Chen")
                        .foregroundColor(.gray)
                        .font(.footnote)
                }
                .padding(.bottom)
                
                .navigationTitle("USC Films")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .toolbar{
                    Button(self.isMovie ? "TV shows" : "Movies"){
                        self.isMovie = !self.isMovie
                    }
                }
            }
        }
        
        .navigationViewStyle(StackNavigationViewStyle())
        .toastFunc(toast: self.toast)
        
        }else{
            ProgressView("Fetching Data...")
        }
    }
}

struct homeViewMain_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
    
}
