//
//  StoreService.swift
//  Nada-Hantol-WishBook
//
//  Created by 김민준 on 6/17/24.
//

import Foundation
import StoreKit

final class StoreService {
    
    /// 인앱 구매 성공 시 반환하는 구조체
    struct IAPResult {
        let transactionId: UInt64
        let purchaseDate: Date
    }
    
    /// 인앱 구매 과정에서 발생할 수 있는 Error 열거형
    enum IAPError: Error {
        case cannotFoundProduct
        case unverified
    }
    
    /// Product ID
    ///
    /// 상품 ID를 들고 있음.
    /// 얘는 원래는 앱스토어에 실제 등록한 productID를 가정한 배열임.
    /// 최적의 상황은 요런 productID를 백엔드 서버에서 들고 있다가 프론트에 JSON 형태로 던져주는게 베스트임.
    private var productIDs = ["coupon0", "coupon1", "coupon2"]
    
    /// 새로운 거래가 발생하는지 확인하고 실행하는 리스너
    var transactionListener: Task<Void, Error>?
    
    init() {
        // 리스너 실행
        // transactionListener = listenForTransaction()
        
        Task {
            
            // 초기화와 동시에 사용자 자격 확인
            await fetchCurrentEntitlements()
        }
    }
    
    /// 진열할 상품 불러오기
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
    
    /// 상품 구매하기
    @MainActor
    func purchase(id: Int) async throws -> Result<IAPResult, IAPError> {
        guard let product = try await Product.products(for: ["coupon\(id)"]).first else {
            return .failure(.cannotFoundProduct)
        }
        
        // 상품 구매 요청
        // 반환값으로 Product.PurchaseResult 타입 반환
        let result = try await product.purchase()
        
        // 구매 결과에 따라 분기 처리
        switch result {
        case .success(.verified(let transaction)):
            await transaction.finish()
            return .success(
                IAPResult(
                    transactionId: transaction.id,
                    purchaseDate: transaction.purchaseDate
                )
            )
            
        default: return .failure(.unverified)
        }
    }
    
    /// Transaction Listener
    private func listenForTransaction() -> Task<Void, Error> {
        
        // 1. Listen 매커니즘은 실시간으로 작업을 수행해야 함.
        // 하지만 앱은 별개로 UI 액션과 같은 다른 작업을 수행해야 하기 때문에 Task를 분리하는 것.
        return Task(priority: .background) {
            
            // 2. 지속적으로 새로운 Transaction을 모니터링하고 새로운 Transaction이 나타내면 받아옴.
            for await verificationResult in Transaction.updates {
                
                // 3. Transaction 결과에 따른 핸들링.
                await self.handle(transactionVerification: verificationResult)
            }
        }
    }
    
    /// Transaction 결과에 따른 처리
    @MainActor
    @discardableResult
    private func handle(transactionVerification result: VerificationResult<Transaction>) async -> Transaction? {
        switch result {
            
            // 거래 성공!
            // transaction은 product 객체를 가지고 있지 않기 때문에 요렇게 ID 값을 이용해 불러옴.
        case .verified(let transaction):
            
            // 거래 프로세스 종료
            await transaction.finish()
            return transaction
            
            // 거래 실패.
        default: return nil
        }
    }
    
    /// 현재 사용자의 자격 처리
    func fetchCurrentEntitlements() async -> [Transaction] {
        
        var transactions: [Transaction] = []
        
        // currentEntitlements
        // 인터넷에 연결되어 있는 경우 최신 Transaction을 검색
        // 인터넷 연결이 없으면 로컬로 캐시된 데이터를 가져옴.
        // + 인터넷 연결이 복원되면 거래가 자동으로 기기에 동기화.
        for await result in Transaction.currentEntitlements {
            guard let transaction = await self.handle(transactionVerification: result) else {
                return []
            }
            
            transactions.append(transaction)
        }
        
        return transactions
    }
}
