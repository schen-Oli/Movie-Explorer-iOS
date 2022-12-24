//
//  Carousel.swift
//  Movie-Explorer-iOS
//
//  Created by Oli Chen on 12/24/22.
//

import SwiftUI
import Kingfisher
import Combine

struct Carousel: View {
    var medias : [MediaPre]
    
    init(medias:[MediaPre]){
        self.medias = medias
    }
    
    var body: some View {
        
        GeometryReader{ geo in
            carouselView{
                ForEach(medias){ media in
                    
                    let tmpCard = CardData(title: media.title, mediaID: media.mediaID, pic: media.pic, type: media.type, date: "0000")
                    NavigationLink(
                        destination: LazyView(MediaDetail(card:tmpCard))){
                          
                    oneCarousel(media: media)
                        .frame(width: geo.size.width, height: geo.size.height)
                        .clipped()
                        }
                }
            }
            
        }.frame(width: 350, height:300, alignment: .center)
        .clipped()
        
        
    }
}

struct carouselView<Content: View>: View{
    private let numOfPic:Int = 5
    private var content: Content
    
    @State private var currIndex:Int = 0
    
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View{
        
        GeometryReader { geometry in
            HStack(spacing:0){
                self.content
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
            .offset(x: CGFloat(self.currIndex) * -geometry.size.width, y:0)
            .animation(.spring())
            .onReceive(self.timer){ _ in
                self.currIndex = (self.currIndex + 1) % 5
            }
        }
        
    }
}

struct oneCarousel: View {
    
    private var media:MediaPre
    
    init(media:MediaPre){
        self.media = media
    }
    
    var body: some View {
        
        GeometryReader{ geom in
            ZStack(alignment: .center){
                HStack{
                    GeometryReader{ geo in
                        KFImage(URL(string: media.pic)!)
                            .resizable()
                            .blur(radius: 30)
                            .frame(width: geo.size.width, height: geo.size.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                }.frame(width: geom.size.width, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .clipped()
                
                KFImage(URL(string: media.pic)!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
            }.frame(width: geom.size.width, height:300, alignment: .center)
            .clipped()
        }
        
    }
    
    
    
}

struct Carousel_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
