//
//  Section.swift
//  RefactoringTVMOVIE
//
//  Created by Healthy on 6/30/24.
//

import Foundation

enum Section: Hashable {
    case double
    case banner
    case horizontal(String)
    case vertical(String)
}
