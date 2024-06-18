//
//  Store+Extension.swift
//  Nada-Hantol-WishBook
//
//  Created by 김민준 on 6/18/24.
//

import Foundation
import StoreKit

extension Product {
    
    var intId: Int {
        if let lastChar = self.id.last,
           let id = Int(String(lastChar)) {
            return id
        }
        
        return 0
    }
    
    /// 상품의 PersonTarget을 반환합니다.
    var target: PersonTarget {
        if let coupon = saleCoupons.filter({ $0.id == intId }).first {
            return coupon.target
        }
        
        return .all
    }
    
    /// 상품의 Emoji를 반환합니다.
    var emoji: String {
        if let coupon = saleCoupons.filter({ $0.id == intId }).first {
            return coupon.emoji
        }
        
        return "⚠️"
    }
}
