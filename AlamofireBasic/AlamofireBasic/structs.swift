//
//  structs.swift
//  AlamofireBasic
//
//  Created by 1v1 on 2021/01/18.
//

struct DummyData:Codable {
    let data:[PersonInfo]
    let total:Int
    let page:Int
    let limit:Int
    let offset:Int
}

struct PersonInfo:Codable {
    let id:String
    let email:String
    let firstName:String
    let picture:String?
    let lastName:String
    let title:String
}
