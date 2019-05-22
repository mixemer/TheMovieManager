//
//  MarkWatchlist.swift
//  TheMovieManager
//
//  Created by Mehmet Sahin on 5/15/19.
//  Copyright © 2019 Mehmet. All rights reserved.
//

import Foundation

struct MarkWatchlist: Codable {
    let mediaType: String
    let mediaId: Int
    let watchlist: Bool
    
    enum CodingKeys: String, CodingKey {
        case mediaType = "media_type"
        case mediaId = "media_id"
        case watchlist
    }
}
