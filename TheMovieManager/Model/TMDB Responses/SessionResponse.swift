//
//  SessionResponse.swift
//  TheMovieManager
//
//  Created by Mehmet Sahin on 5/15/19.
//  Copyright © 2019 Mehmet. All rights reserved.
//

import Foundation

struct SessionResponse: Codable {
    let success: Bool
    let sessionId: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case sessionId = "session_id"
    }
}
