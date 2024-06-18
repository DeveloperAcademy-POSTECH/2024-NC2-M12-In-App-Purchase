//
//  SaleCoupon.swift
//  Nada-Hantol-WishBook
//
//  Created by 김민준 on 6/14/24.
//

import Foundation

struct SaleCoupon: Identifiable {
    let id: Int
    let title: String
    let price: Decimal
    let displayPrice: String
    let target: PersonTarget
    let emoji: String
}
