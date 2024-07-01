//
//  ReviewRequest.swift
//  RefactoringTVMOVIE
//
//  Created by Healthy on 6/30/24.
//

import Foundation

struct ReviewRequest: Decodable {
    var id: Int
    
    init(id: Int) {
        self.id = id
    }
}
