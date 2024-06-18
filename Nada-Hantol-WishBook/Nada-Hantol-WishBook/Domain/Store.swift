//
//  Store.swift
//  Nada-Hantol-WishBook
//
//  Created by 김민준 on 6/18/24.
//

import Foundation
import StoreKit

final class Store: ObservableObject {
    
    /// Product ID
    ///
    /// 상품 ID를 들고 있음.
    /// 얘는 원래는 앱스토어에 실제 등록한 productID를 가정한 배열임.
    /// 최적의 상황은 요런 productID를 백엔드 서버에서 들고 있다가 프론트에 JSON 형태로 던져주는게 베스트임.
    private var productIDs = ["coupon0", "coupon1", "coupon2"]
    
    /// 진열된 상품 목록
    @Published private(set) var products = [Product]()
    
    /// 구매한 상품 목록
    @Published var purchasedProducts = [Product]()
    
    init() {
        Task {
            // 초기화와 동시에 상품 진열
            await requestProduct()
        }
    }
    
    /// 현재까지 구매한 전체 금액 반환
    var totalPrice: Decimal {
        var price: Decimal = 0
        purchasedProducts.forEach {
            price += $0.price
        }
        
        return price
    }
    
    /// 진열할 상품 불러오기
    @MainActor
    func requestProduct() async {
        do {
            // Product의 ID를 가지고 [Product] 반환
            products = try await Product.products(for: productIDs)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /// 상품 구매하기
    @MainActor
    func purchase(_ product: Product) async throws -> Transaction? {
        
        // 상품 구매 요청
        // 반환값으로 Product.PurchaseResult 타입 반환
        let result = try await product.purchase()
        
        // 구매 결과에 따라 분기 처리
        switch result {
            
            // 1. 성공 했을 때
        case .success(let verificationResult):
            switch verificationResult {
                
                // 1-1. StorKit 검증까지 성공
            case .verified(let transaction):
                
                // 구매한 Product에 추가
                purchasedProducts.append(product)
                
                // 거래 종료
                await transaction.finish()
                
                // 거래 내용 반환
                return transaction
                
                // 1-2. StoreKit 검증 실패
            case .unverified(_, _):
                return nil
            }
            
            // 2. 실패, 취소 됐을 때(cancel, pending)
        default: return nil
        }
    }
}
