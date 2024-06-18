//
//  RefundCouponView.swift
//  Nada-Hantol-WishBook
//
//  Created by 김민준 on 6/17/24.
//

import SwiftUI

struct RefundCouponView: View {
    
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
            .padding(.horizontal, 26)
            
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(couponUseCase.purchaseCoupons) { coupon in
                        PurchaseCouponCell(
                            purchaseCoupon: coupon,
                            couponType: .refund
                        ) {
                            // TODO: 환불 로직
                        }
                        .padding(.horizontal, 22)
                    }
                }
            }
        }
    }
}

#Preview {
    RefundCouponView()
        .environment(
            CouponUseCase(
                storeService: .init(),
                dataService: .init(
                    modelContext: ModelContainerCoordinator.mockContainer.mainContext
                )
            )
        )
}
