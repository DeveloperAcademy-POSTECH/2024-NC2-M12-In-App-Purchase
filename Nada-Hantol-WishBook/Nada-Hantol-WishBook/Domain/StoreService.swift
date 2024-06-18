//
//  StoreService.swift
//  Nada-Hantol-WishBook
//
//  Created by 김민준 on 6/17/24.
//

import Foundation
import StoreKit

struct StoreService {
    
    private var productIDs = ["coupon0", "coupon1", "coupon2"]
    
    @MainActor
    func requestProducts() async -> [SaleCoupon] {
        do {
            let saleProducts = try await Product.products(for: productIDs)
            return saleProducts.map {
                if let lastChar = $0.id.last,
                   let id = Int(String(lastChar)) {
                    return SaleCoupon(
                        id: id,
                        title: $0.displayName,
                        price: $0.displayPrice,
                        target: saleCoupons[id].target,
                        emoji: saleCoupons[id].emoji
                    )
                }
                
                return SaleCoupon(
                    id: 0,
                    title: "",
                    price: "",
                    target: .all,
                    emoji: ""
                )
            }
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
