//
//  CouponData.swift
//  Nada-Hantol-WishBook
//
//  Created by YejiKim on 6/15/24.
//

import Foundation

let saleCoupons: [SaleCoupon] = [
    SaleCoupon(
        id: 0,
        title: "도서관에서 얼음 떠오기",
        price: "",
        target: PersonTarget.nada,
        emoji: "🧊"
    ),
    
    SaleCoupon(
        id: 1,
        title: "목적지까지 데려다주기",
        price: "",
        target: PersonTarget.hantol,
        emoji: "🏠"
    ),
    
    SaleCoupon(
        id: 2,
        title: "편의점 음식 대신 사다주기",
        price: "",
        target: PersonTarget.all,
        emoji: "🥐"
    ),
    
    SaleCoupon(
        id: 3,
        title: "진심 어린 칭찬 듣기",
        price: "",
        target: PersonTarget.all,
        emoji: "🔮"
    ),
]
