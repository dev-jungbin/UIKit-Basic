//
//  WebToonData.swift
//  NaverWebtoonExample
//
//  Created by 1v1 on 2021/01/17.
//

struct WebToonData {
    var title_image:String!
    var title:String!
    var rating:Float!
    var author:String!
    
    init(_ title:String, _ title_image:String, _ rating:Float, _ author:String){
        self.title = title
        self.title_image = title_image
        self.rating = rating
        self.author = author
    }
}
