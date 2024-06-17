//
//  PurchaseWish.swift
//  Nada-Hantol-WishBook
//
//  Created by 김민준 on 6/14/24.
//

import Foundation

struct PurchaseWish: Identifiable {
    let id: UUID = .init()
    let wish: SaleWish
    let purchaseDate: Date = Date.now
    let usedDate: Date?
    let isUsed: Bool = false
    
//    static let dateFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yy.MM.dd"
//        return formatter
//    }()
}
