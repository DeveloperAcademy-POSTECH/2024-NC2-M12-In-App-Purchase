//
//  RefundView.swift
//  Nada-Hantol-WishBook
//
//  Created by 김민준 on 6/17/24.
//

import SwiftUI

struct RefundView: View {
    
    @Environment(CouponUseCase.self) private var couponUseCase
    
    var body: some View {
        
        VStack(alignment: .leading){
            Spacer()
                .frame(height: 28)
            
            HStack {
                Text("쿠폰 환불")
                    .systemFont(.bold, 24)
                    .foregroundStyle(.textBlack)
                
                Spacer()
            }
            
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(couponUseCase.purchaseCoupons) { coupon in
                        PurchaseCouponCell(
                            purchaseCoupon: coupon,
                            couponType: .refund
                        )
                    }
                }
            }
        }
        .padding(.horizontal, 22)
    }
}

#Preview {
    RefundView()
        .environment(
            CouponUseCase(
                storeService: .init(),
                dataService: .init(
                    modelContext: ModelContainerCoordinator.mockContainer.mainContext
                )
            )
        )
}
