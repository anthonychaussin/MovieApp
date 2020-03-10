//
//  ProductionCountry.swift
//  BandeAnnonce
//
//  Created by  on 09/03/2020.
//  Copyright © 2020 Anthony chaussin. All rights reserved.
//

import Foundation

struct ProductionCountry: Codable {
    let iso3166_1, name: String?

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}
