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
    
    @MainActor
    func purchase(id: Int) async throws -> PurchaseCoupon? {
        
        guard let product = try await Product.products(for: ["coupon\(id)"]).first else {
            print("상품을 받아올 수 없습니다!")
            return nil
        }
        
        let result = try await product.purchase()
        switch result {
        case .success(.verified(let transaction)):
            await transaction.finish()
            return PurchaseCoupon(couponId: id)
        
        default: return nil
        }
    }
    
//    func listenForTransactions() -> Task < Void, Error > {
//     return Task.detached {
//       for await result in Transaction.updates {
//         switch result {
//           case let.verified(transaction):
//             guard let product = self.products.first(where: {
//               $0.id == transaction.productID
//             }) else {
//               continue
//             }
//             self.purchasedNonConsumables.append(product)
//             await transaction.finish()
//           default:
//             continue
//         }
//       }
//     }
//   }
}
