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

// MARK: - 확장

extension PurchaseCoupon {
    
    /// 쿠폰의 ID를 가지고 쿠폰 제목을 조회합니다.
    var title: String {
        let coupon = saleCoupons.filter {
            if $0.id == self.couponId {
                print("saleCoupons ID: \($0.id)")
                print("self.couponID: \(self.couponId)")
            }
            return $0.id == self.couponId
        }.first
        return coupon?.title ?? "이 쿠폰은 잘못된 쿠폰이야"
    }
    
    /// 쿠폰의 ID를 가지고 쿠폰 제목을 조회합니다.
    var price: Int {
        let coupon = saleCoupons.filter { $0.id == self.couponId }.first
        return coupon?.price ?? 0
    }
    
    /// 쿠폰의 ID를 가지고 쿠폰 제목을 조회합니다.
    var emoji: String {
        let coupon = saleCoupons.filter { $0.id == self.couponId }.first
        return coupon?.emoji ?? "❌"
    }
    
    /// 쿠폰의 ID를 가지고 쿠폰 제목을 조회합니다.
    var target: PersonTarget {
        let coupon = saleCoupons.filter { $0.id == self.couponId }.first
        return coupon?.target ?? .all
    }
}
