//
//  Result.swift
//  stc challenge
//
//  Created by Raya Khalid on 14/11/2021.
//

import Foundation

struct Results: Codable {
    
    var type: String?
    var url: String?
    var createdAt: String?
    var company: String
    var companyUrl: String?
    var location: String?
    var title: String
    var description: String?
    var howToApply: String?
    var companyLogo: String?
}
