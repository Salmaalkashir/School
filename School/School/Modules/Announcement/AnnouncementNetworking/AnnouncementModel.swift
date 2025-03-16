//
//  AnnouncementModel.swift
//  School
//
//  Created by Mahmoud on 08/03/2025.
//

import Foundation

struct AnnouncementData: Codable {
    let id: Int
    let name, phone, email: String
    let emailVerifiedAt: String?
    let role, accessToken: String
}
struct AnnouncementModel: Codable {
    var status: Bool?
    var message: String?
    var data: LoginData?
}
