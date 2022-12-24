//
//  mediaReview.swift
//  USC Films
//
//  Created by 烁  陈 on 2021/4/21.
//

import SwiftUI

struct mediaReview: View {
    
    var reviews: [Review]
    var title: String
    init(reviews: [Review], title:String){
        self.reviews = reviews
        self.title = title
    }
    
    var body: some View {
        VStack{
            ForEach(reviews){ review in
                NavigationLink(destination: reviewDetail(review:review, title:title)){
                    singleReview(review: review)
                } .buttonStyle(PlainButtonStyle()) 
                
            }
        }
    }
}

struct singleReview: View{
    
    var review : Review
    
    init(review : Review){
        self.review = review
    }
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(review.author)
                    .padding(.horizontal, 10)
                    .padding(.top, 10)
                    .font(.headline)
                Text("Written by " + review.date)
                    .padding(.horizontal, 10)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                HStack{
                    Image(systemName: "star.fill")
                        .foregroundColor(.red)
                    Text(review.rate)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                Text(review.content)
                    .font(.body)
                    .padding(.horizontal, 10)
                    .padding(.bottom, 10)
                    .lineLimit(3)
            }
            Spacer()
        }
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray, lineWidth: 1)
        )
        .padding(.horizontal)
    }
}

struct mediaReview_Previews: PreviewProvider {
    static var previews: some View {
        singleReview(review: Review(
                        author: "This is a review",
                        content:"this is review content",
                        date: "Written by the author on Mar 18, 2021",
                        rate: "4.5/5.0")
        )
        mediaReview(reviews: [Review(
                                author: "This is a review",
                                content:"this is review content",
                                date: "Written by the author on Mar 18, 2021",
                                rate: "4.5/5.0"),
                              Review(
                                author: "This is a review",
                                content:"this is review content",
                                date: "Written by the author on Mar 18, 2021",
                                rate: "4.5/5.0"),
                              Review(
                                author: "This is a review",
                                content:"this is review content",
                                date: "Written by the author on Mar 18, 2021",
                                rate: "4.5/5.0"),
                              Review(
                                author: "This is a review",
                                content:"this is review content",
                                date: "Written by the author on Mar 18, 2021",
                                rate: "4.5/5.0")], title: "omg this is a sample ")
    }
}
