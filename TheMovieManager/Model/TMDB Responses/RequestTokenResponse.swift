//
//  RequestTokenResponse.swift
//  TheMovieManager
//
//  Created by Mehmet Sahin on 5/15/19.
//  Copyright © 2019 Mehmet. All rights reserved.
//
import Foundation

struct RequestTokenResponse: Codable {
    let success: Bool
    let expiresAt: String
    let requestToken: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}
