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
    
    /// 새로운 거래가 발생하는지 확인하고 실행하는 리스너
    var transactionListener: Task<Void, Error>?
    
    init() {
        // 리스너 실행
        transactionListener = listenForTransaction()
        
        Task {
            // 초기화와 동시에 상품 진열
            await requestProduct()
            
            // 초기화와 동시에 사용자 자격 확인
            await updateCurrentEntitlements()
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
            let products = try await Product.products(for: productIDs)
            self.products = products.sorted { $0.id < $1.id }
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
    
    /// Transaction Listener
    func listenForTransaction() -> Task<Void, Error> {
        
        // 1. Listen 매커니즘은 실시간으로 작업을 수행해야 함.
        // 하지만 앱은 별개로 UI 액션과 같은 다른 작업을 수행해야 하기 때문에 Task를 분리하는 것.
        return Task(priority: .background) {
            
            // 2. 지속적으로 새로운 Transaction을 모니터링하고 새로운 Transaction이 나타내면 받아옴.
            for await verificationResult in Transaction.updates {
                
                // 3. Transaction 결과에 따른 핸들링.
                await self.handle(transactionVerfication: verificationResult)
            }
        }
    }
    
    /// Transaction 결과에 따른 처리
    @MainActor
    private func handle(transactionVerfication result: VerificationResult<Transaction>) async {
        switch result {
            
            // 거래 성공!
            // transaction은 product 객체를 가지고 있지 않기 때문에 요렇게 ID 값을 이용해 불러옴.
        case .verified(let transaction):
            guard let product = self.products.first(where: {
                $0.id == transaction.productID
            }) else { return }
            
            // 구매한 Product에 추가!
            self.purchasedProducts.append(product)
            
            // 거래 프로세스 종료
            await transaction.finish()
            
            // 거래 실패.
        default: return
        }
    }
    
    /// 현재 사용자의 자격 처리
    private func updateCurrentEntitlements() async {
        
        // currentEntitlements
        // 인터넷에 연결되어 있는 경우 최신 Transaction을 검색
        // 인터넷 연결이 없으면 로컬로 캐시된 데이터를 가져옴.
        // + 인터넷 연결이 복원되면 거래가 자동으로 기기에 동기화.
        for await result in Transaction.currentEntitlements {
            await self.handle(transactionVerfication: result)
        }
    }
}
