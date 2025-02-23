//
//  LoginModel.swift
//  School
//
//  Created by Mahmoud on 06/12/2024.
//


struct LoginData: Codable {
    let id: Int
    let name, phone, email: String
    let emailVerifiedAt: String?
    let role, accessToken: String
}
struct LoginModel: Codable {
    var status: Bool?
    var message: String?
    var data: LoginData?
}
