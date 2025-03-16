//
//  UserInputType.swift
//  Portfolio
//
//  Created by 홍정민 on 3/16/25.
//

import Foundation

enum UserInputType {
    case email
    case id
    case pwd
    case phone
    
    var title: String {
        switch self {
        case .email:
            return "이메일을 입력해주세요"
        case .id:
            return "아이디를 입력해주세요"
        case .pwd:
            return "패스워드를 입력해주세요"
        case .phone:
            return "휴대폰 번호를 입력해주세요"
        }
    }
    
    var placeholder: String {
        switch self {
        case .email:
            return "이메일"
        case .id:
            return "아이디(영문 7자리 이상)"
        case .pwd:
            return "패스워드(특수문자, 대소문자 포함 11자리 이상)"
        case .phone:
            return "휴대폰 번호"
        }
    }
    
    var invalidInput: String {
        switch self {
        case .email:
            return "이메일 형식이 맞지 않습니다"
        case .id:
            return "아이디는 영문 7자리 이상이어야 합니다"
        case .pwd:
            return "패스워드는 특수문자, 대소문자를 포함한 11자리 이상이어야 합니다"
        case .phone:
            return "휴대폰 번호가 올바르지 않습니다"
        }
    }
}
