//
//  SynonymData.swift
//  New Word
//
//  Created by Арайлым Кабыкенова on 17.12.2025.
//

struct SynonymData:Codable{
    let word:String
    let userAnswer:String
}
struct AnswerCheckData:Codable{
    let data:CheckedData
}
struct CheckedData:Codable{
    let correct:Bool
    let userAnswer:String
    let word:String
}

