//
//  ProductionCompany.swift
//  BandeAnnonce
//
//  Created by  on 09/03/2020.
//  Copyright © 2020 Anthony chaussin. All rights reserved.
//

import Foundation

struct ProductionCompany: Codable {
    let id: Int?
    let logoPath: String?
    let name, originCountry: String?

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}
