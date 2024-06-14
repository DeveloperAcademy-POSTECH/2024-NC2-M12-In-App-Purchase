//
//  SaleWish.swift
//  Nada-Hantol-WishBook
//
//  Created by 김민준 on 6/14/24.
//

import Foundation

struct SaleWish: Identifiable {
    let id: UUID = .init()
    let title: String
    let price: Int
    let target: PersonTarget
    let emoji: String
}
