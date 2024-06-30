//
//  TVRequest.swift
//  RefactoringTVMOVIE
//
//  Created by Healthy on 6/30/24.
//

import Foundation

struct TVRequest: Decodable {
    var page: Int?
    var language: LanguageType
    var query: String?
    
    init(page: Int? = nil, language: LanguageType = LanguageType.korean, query: String? = nil) {
        self.page = page
        self.language = language
        self.query = query
    }
}
 
enum LanguageType: String, Decodable {
    case korean = "ko"
    case english = "en"
}
