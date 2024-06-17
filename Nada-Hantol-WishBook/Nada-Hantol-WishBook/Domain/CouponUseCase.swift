//
//  CouponUseCase.swift
//  Nada-Hantol-WishBook
//
//  Created by 김민준 on 6/17/24.
//

import Foundation

final class CouponUseCase {
    
    let storeService: StoreService
    let dataService: DataService
    
    init(storeService: StoreService = .init(), dataService: DataService = .init()) {
        self.storeService = storeService
        self.dataService = dataService
    }
}

extension CouponUseCase {
    
    /// 쿠폰을 구매합니다.
    func purchaseCoupon() {
        
        // 1. 인앱 구매 창이 떠야함
        
        // 2. 구매 완료에 대한 결과 반환
        
        // 3. 구매한 쿠폰 데이터 생성
        dataService.createCoupon()
        
        // 4. 구매한 쿠폰 구매 완료 alert 출력
    }
    
    /// 쿠폰을 사용합니다.
    func useCoupon() {
        
        // 1. 현재 쿠폰의 상태값을 purchase -> used
        dataService.updateCouponState()
        
        // 2. 현재 쿠폰의 사용일자를 업데이트 -> 현재 시간으로
    }
    
    /// 쿠폰을 환불합니다.
    func refundCoupon() {
        
        // 1. 인앱 환불 창이 떠야함
        
        // 2. 환불 결과 반환
        
        // 3. 환불한 쿠폰 삭제
        dataService.deleteCoupon()
        
        // 4. 환불 완료 alert 출력
    }
}