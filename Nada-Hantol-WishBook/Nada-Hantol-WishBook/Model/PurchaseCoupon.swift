//
//  PurchaseCoupon.swift
//  Nada-Hantol-WishBook
//
//  Created by 김민준 on 6/14/24.
//

import Foundation
import SwiftData

@Model
final class PurchaseCoupon: Identifiable {
    
    let couponId: Int
    
    let purchaseDate: Date
    var usedDate: Date?
    
    var isUsed: Bool
    
    init(
        couponId: Int,
        purchaseDate: Date = .now,
        usedDate: Date? = nil,
        isUsed: Bool = false
    ) {
        self.couponId = couponId
        self.purchaseDate = purchaseDate
        self.usedDate = usedDate
        self.isUsed = isUsed
    }
}

// MARK: - Extension

extension PurchaseCoupon {
    
    /// 쿠폰의 ID를 가지고 쿠폰 제목을 조회합니다.
    var title: String {
        let coupon = saleCoupons.filter { return $0.id == self.couponId }.first
        return coupon?.title ?? "이 쿠폰은 잘못된 쿠폰이야"
    }
    
    /// 쿠폰의 ID를 가지고 쿠폰 가격을 조회합니다.
//    var price: String {
//        let coupon = saleCoupons.filter { $0.id == self.couponId }.first
//        return coupon?.price ?? "99999999"
//    }
    
    /// 쿠폰의 ID를 가지고 쿠폰 이모지를 조회합니다.
    var emoji: String {
        let coupon = saleCoupons.filter { $0.id == self.couponId }.first
        return coupon?.emoji ?? "❌"
    }
    
    /// 쿠폰의 ID를 가지고 쿠폰 타겟을 조회합니다.
    var target: PersonTarget {
        let coupon = saleCoupons.filter { $0.id == self.couponId }.first
        return coupon?.target ?? .all
    }
}

extension [PurchaseCoupon] {
    
    /// 현재까지 구매한 쿠폰의 총 금액을 반환합니다.
//    var totalPrice: Int {
//        let total = self.reduce(0) {
//            if let secondInt = Int($1.price) {
//                return $0 + secondInt
//            }
//            
//            return 0
//        }
//        return total
//    }
}
