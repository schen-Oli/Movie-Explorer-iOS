//
//  Review.swift
//  Movie-Explorer-iOS
//
//  Created by Oli Chen on 12/24/22.
//

import SwiftUI

struct MediaReview: View {
    var reviews: [Review]
    var title: String
    init(reviews: [Review], title:String){
        self.reviews = reviews
        self.title = title
    }
    
    var body: some View {
        VStack{
            ForEach(reviews){ review in
                NavigationLink(destination: ReviewDetail(review:review, title:title)){
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

struct Review_Previews: PreviewProvider {
    static var previews: some View {
        singleReview(review: Review(
                        author: "This is a review",
                        content:"this is review content",
                        date: "Written by the author on Mar 18, 2021",
                        rate: "4.5/5.0")
        )
        MediaReview(reviews: [Review(
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
