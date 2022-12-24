//
//  reviewDetail.swift
//  USC Films
//
//  Created by 烁  陈 on 2021/4/21.
//

import SwiftUI

struct reviewDetail: View {
    
    var review: Review
    var title: String
    init(review: Review, title:String){
        self.review = review
        self.title = title
    }
    
    var body: some View {
        ScrollView {
            VStack{
                HStack {
                    Text(title)
                        .font(.title)
                        .bold()
                    Spacer()
                }
                
                HStack {
                    Text("By " + review.date)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.vertical, 1)
                    Spacer()
                }
                
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.red)
                        .font(.body)
                    Text(review.rate)
                        .font(.body)
                        .fontWeight(.light)
                    Spacer()
                }
                
                Divider()
                
                HStack{
                    Text(review.content)
                            .font(.body)
                            .fontWeight(.light)
                            .padding(.bottom)
                            .minimumScaleFactor(0.5)
                    Spacer()
                }
                
            }.padding()
        }
    }
}

struct reviewDetail_Previews: PreviewProvider {
    static var previews: some View {
        reviewDetail(review: Review(
                        author: "A review by Oli",
                        content:"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                        date: "Written by SC on Mar 18, 2021",
                        rate: "4.5/5.0"), title: "OMG OMG OMG")
    }
}
