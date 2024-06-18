//
//  Store.swift
//  Nada-Hantol-WishBook
//
//  Created by 김민준 on 6/18/24.
//

import Foundation
import StoreKit

final class Store: ObservableObject {
    
    private var productIDs = ["coupon0", "coupon1", "coupon2"]
    
    @Published private(set) var products = [Product]()
    @Published var purchasedCoupons = [Product]()
    
    init() {
        Task {
            await requestProduct()
        }
    }
    
    @MainActor
    func requestProduct() async {
        do {
            products = try await Product.products(for: productIDs)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func purchase(_ product: Product) async throws -> Transaction? {
        let result = try await product.purchase()
        
        switch result {
        case .success(.verified(let transaction)):
            purchasedCoupons.append(product)
            await transaction.finish()
            return transaction
            
        default: return nil
        }
    }
}
