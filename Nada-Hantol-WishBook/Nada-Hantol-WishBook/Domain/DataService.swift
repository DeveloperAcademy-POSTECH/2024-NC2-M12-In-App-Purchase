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
    
    /// 쿠폰을 생성합니다.
    func createCoupon() {
//        let newCoupon = PurchaseCoupon(couponId: <#T##UUID#>)
//        modelContext.insert(newCoupon)
    }
    
    /// 쿠폰 상태를 변경합니다.
    func updateCouponState() {
        
    }
    
    /// 쿠폰을 삭제합니다.
    func deleteCoupon() {
        
    }
}
