//
//  TVRequest.swift
//  RefactoringTVMOVIE
//
//  Created by Healthy on 6/30/24.
//

import Foundation

struct TVRequest: Decodable {
    var page: Int?
    var query: String?
    
    init(page: Int? = nil, query: String? = nil) {
        self.page = page
        self.query = query
    }
}
