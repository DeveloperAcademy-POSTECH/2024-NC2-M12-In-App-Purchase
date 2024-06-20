//
//  CouponUseCase.swift
//  Nada-Hantol-WishBook
//
//  Created by 김민준 on 6/17/24.
//

import Foundation

@Observable
final class CouponUseCase {
    
    private let storeService: StoreService
    private let dataService: DataService
    
    private(set) var saleCoupons: [SaleCoupon]
    private(set) var purchaseCoupons: [PurchaseCoupon]
    
    init(storeService: StoreService, dataService: DataService) {
        self.storeService = storeService
        self.dataService = dataService
        self.saleCoupons = []
        self.purchaseCoupons = dataService.fetchCoupons()
    }
}

extension CouponUseCase {
    
    /// PurchaseCoupon을 SaleCoupon으로 반환합니다.
    func toSaleCoupon(_ purchaseCoupon: PurchaseCoupon) -> SaleCoupon {
        guard let coupon = saleCoupons.filter({ $0.id == purchaseCoupon.couponId }).first
        else {
            return SaleCoupon(
                id: 0,
                title: "ERROR",
                price: 0,
                displayPrice: "",
                target: .all,
                emoji: ""
            )
        }
        return coupon
    }
    
    /// 총 가격을 반환합니다.
    func totalPrice() -> String {
        var price: Decimal = 0
        for coupon in self.purchaseCoupons {
            price += toSaleCoupon(coupon).price
        }
        
        return price.toDisplayPrice
    }
    
    func fetchSaleCoupons() {
        Task {
            saleCoupons = await storeService.requestProducts()
        }
    }
    
    /// 쿠폰을 구매합니다.
    func purchaseCoupon(couponId: Int) {
        
        // 1. 인앱 구매 창이 떠야함
        Task {
            do {
                // 인앱 결제 창 실행 및 결과 대기
                let result = try await storeService.purchase(id: couponId)
                
                switch result {
                    
                    // 인앱 구매 성공 시
                case .success(let iapResult):
                    dataService.createCoupon(
                        id: couponId,
                        transactionId: iapResult.transactionId,
                        purchaseDate: iapResult.purchaseDate
                    )
                    purchaseCoupons = dataService.fetchCoupons()
                    
                    print("구매한 아이디: \(iapResult.transactionId)")
                    
                    // 인앱 구매 실패 시
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    /// 쿠폰을 사용합니다.
    func useCoupon(_ coupon: PurchaseCoupon?) {
        
        // 1. 현재 쿠폰의 상태값을 purchase -> used
        guard let coupon = coupon else {
            print("선택된 쿠폰이 없습니다.")
            return
        }
        
        dataService.updateCouponState(coupon)
        
        // 2. 현재 쿠폰의 사용일자를 업데이트 -> 현재 시간으로
        
        purchaseCoupons = dataService.fetchCoupons()
    }
    
    /// 쿠폰을 환불합니다.
    func refundCoupon(transactionId: UInt64) {
        
        // 1. 환불할 쿠폰 상태 변경
        dataService.pendingRefund(transactionId)
        
        // 2. 환불 완료 alert 출력
        purchaseCoupons = dataService.fetchCoupons()
    }
    
    /// 환불 가능한 쿠폰 리스트를 반환합니다.
    var refundCoupons: [PurchaseCoupon] {
        return purchaseCoupons.filter { !$0.isUsed }
    }
}
