//
//  Videos.swift
//  BandeAnnonce
//
//  Created by  on 09/03/2020.
//  Copyright © 2020 Anthony chaussin. All rights reserved.
//

import Foundation

struct Videos: Codable {
    let results: [Result]?
}

struct Result: Codable {
    let id, iso639_1, iso3166_1, key: String?
    let name, site: String?
    let size: Int?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case id
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case key, name, site, size, type
    }
}
