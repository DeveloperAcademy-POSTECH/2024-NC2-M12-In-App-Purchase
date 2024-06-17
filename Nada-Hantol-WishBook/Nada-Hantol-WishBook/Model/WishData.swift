//
//  WishData.swift
//  Nada-Hantol-WishBook
//
//  Created by YejiKim on 6/15/24.
//

import Foundation

let saleWishes: [SaleWish] = [
    SaleWish(title: "도서관에서 얼음 떠오기", price: 3300, target: PersonTarget.nada, emoji: "🧊"),
    SaleWish(title: "목적지까지 데려다주기", price: 5500, target: PersonTarget.hantol, emoji: "🏠"),
    SaleWish(title: "편의점 음식 대신 사다주기", price: 12000, target: PersonTarget.all, emoji: "🥐"),
    SaleWish(title: "진심 어린 칭찬 듣기", price: 100, target: PersonTarget.all, emoji: "🔮"),
]

let purchaseWishes: [PurchaseWish] = [
    PurchaseWish(wish: SaleWish(title: "도서관에서 얼음 떠오기", price: 3300, target: PersonTarget.all, emoji: "🧊"), usedDate: Date())
]
