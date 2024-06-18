//
//  StoreService.swift
//  Nada-Hantol-WishBook
//
//  Created by 김민준 on 6/17/24.
//

import Foundation
import StoreKit

struct StoreService {
    
    enum IAPError: Error {
        case cannotFoundProduct
        case unverified
    }
    
    private var productIDs = ["coupon0", "coupon1", "coupon2"]
    
    @MainActor
    func requestProducts() async -> [SaleCoupon] {
        do {
            let saleProducts = try await Product.products(for: productIDs)
            let coupons = saleProducts.map {
                if let lastChar = $0.id.last,
                   let id = Int(String(lastChar)) {
                    return SaleCoupon(
                        id: id,
                        title: $0.displayName,
                        price: $0.price,
                        displayPrice: $0.displayPrice,
                        target: saleCoupons[id].target,
                        emoji: saleCoupons[id].emoji
                    )
                }
                
                return SaleCoupon(
                    id: 0,
                    title: "",
                    price: 0,
                    displayPrice: "0",
                    target: .all,
                    emoji: ""
                )
            }
            
            return coupons.sorted { $0.id < $1.id }
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    @MainActor
    func purchase(id: Int) async throws -> Result<Date, IAPError> {
        
        guard let product = try await Product.products(for: ["coupon\(id)"]).first else {
            return .failure(.cannotFoundProduct)
        }
        
        let result = try await product.purchase()
        switch result {
        case .success(.verified(let transaction)):
            await transaction.finish()
            return .success(transaction.purchaseDate)
            
        default: return .failure(.unverified)
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
