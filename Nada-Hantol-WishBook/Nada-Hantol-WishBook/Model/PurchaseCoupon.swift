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
    let transactionId: UInt64
    
    let purchaseDate: Date
    var usedDate: Date?
    
    var isUsed: Bool
    var isRefundPending: Bool
    
    init(
        couponId: Int,
        transactionId: UInt64,
        purchaseDate: Date = .now,
        usedDate: Date? = nil,
        isUsed: Bool = false,
        isRefundPending: Bool = false
    ) {
        self.couponId = couponId
        self.transactionId = transactionId
        self.purchaseDate = purchaseDate
        self.usedDate = usedDate
        self.isUsed = isUsed
        self.isRefundPending = isRefundPending
    }
}

// MARK: - Extension

extension PurchaseCoupon {
    
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
