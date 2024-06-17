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
    
    let couponId: UUID
    
    let purchaseDate: Date
    var usedDate: Date?
    
    var isUsed: Bool
    
    init(
        couponId: UUID,
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
