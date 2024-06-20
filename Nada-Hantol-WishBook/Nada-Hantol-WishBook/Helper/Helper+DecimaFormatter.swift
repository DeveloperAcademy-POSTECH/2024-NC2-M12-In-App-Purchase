//
//  Helper+DecimaFormatter.swift
//  Nada-Hantol-WishBook
//
//  Created by 김민준 on 6/19/24.
//

import Foundation

extension Decimal {
    
    /// Decimal 타입을 DisplayPrice 형식으로 포맷팅 후 반환합니다.
    var toDisplayPrice: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = .current
        
        if let formattedNumber = numberFormatter.string(from: self as NSDecimalNumber) {
            return formattedNumber
        } else {
            return "0"
        }
    }
}
