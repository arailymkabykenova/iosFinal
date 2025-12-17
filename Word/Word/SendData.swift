//
//  SendData.swift
//  New Word
//
//  Created by Арайлым Кабыкенова on 17.12.2025.
//
import Foundation
struct SendData:Codable{
    let level:String
    let category:String
    let theme:String
}
struct WordDraft {
    var level: String?
    var category: String?
    var theme: String?
}
struct RecievedData:Codable{
    let data:WordData
}
struct WordData:Codable{
    let text:String
    let meaning:String
    let examples:[String]
}
