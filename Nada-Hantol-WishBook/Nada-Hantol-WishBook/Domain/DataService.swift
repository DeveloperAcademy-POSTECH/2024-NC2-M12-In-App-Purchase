//
//  DataService.swift
//  Nada-Hantol-WishBook
//
//  Created by 김민준 on 6/17/24.
//

import Foundation
import SwiftData

struct DataService {
    
    /// ModelContext
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
}

// MARK: - 실제 사용 케이스

extension DataService {
    
    /// 쿠폰 리스트를 반환합니다.
    func fetchCoupons() -> [PurchaseCoupon] {
        do {
            let fetchDescriptor = FetchDescriptor<PurchaseCoupon>(sortBy: [.init(\.purchaseDate)])
            let coupons = try modelContext.fetch(fetchDescriptor)
            return coupons.reversed()
        } catch {
            print("PurchaseCoupon 데이터 반환 실패")
            return []
        }
    }
    
    /// 쿠폰을 생성합니다.
    func createCoupon(id: Int, transactionId: UInt64, purchaseDate: Date) {
        let newCoupon = PurchaseCoupon(
            couponId: id,
            transactionId: transactionId,
            purchaseDate: purchaseDate
        )
        modelContext.insert(newCoupon)
    }
    
    /// 쿠폰 상태를 변경합니다.
    func updateCouponState(_ coupon: PurchaseCoupon) {
        coupon.isUsed = true
        coupon.usedDate = .now
    }
    
    /// 쿠폰을 환불 대기 상태로 전환합니다.
    func pendingRefund(_ transactionId: UInt64) {
        guard let coupon = fetchCoupons().filter({ $0.transactionId == transactionId }).first
        else { return }
        coupon.isRefundPending = true
    }
}
