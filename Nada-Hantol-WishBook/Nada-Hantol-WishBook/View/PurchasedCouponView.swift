//
//  PurchasedCouponView.swift
//  Nada-Hantol-WishBook
//
//  Created by 김민준 on 6/17/24.
//

import SwiftUI

// MARK: - PurchasedCouponView

struct PurchasedCouponView: View {
    
    @Environment(CouponUseCase.self) private var couponUseCase
    
    @State private var isCouponUseAlertPresented = false
    @State private var isCompleteAlertPresented = false
    
    @State private var selectedCoupon: PurchaseCoupon?
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
                .frame(height: 32)
            
            HStack {
                Text("구매한 쿠폰")
                    .systemFont(.bold, 24)
                    .foregroundStyle(.textBlack)
                    .padding(.horizontal, 24)
                
                Spacer()
            }
            
            Spacer()
                .frame(height: 28)
            
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(couponUseCase.purchaseCoupons) { coupon in
                        PurchaseCouponCell(
                            purchaseCoupon: coupon,
                            couponType: coupon.isUsed ? .used : .purchase
                        ) {
                            selectedCoupon = coupon
                            isCouponUseAlertPresented.toggle()
                        }
                        .padding(.horizontal, 24)
                    }
                }
            }
            .alert(
                "\(selectedCoupon?.title ?? "ERROR") 쿠폰을 사용하시겠습니까?",
                isPresented: $isCouponUseAlertPresented,
                actions: {
                    Button("그만두기", role: .none) {}
                    Button("사용하기", role: .none) {
                        couponUseCase.useCoupon(selectedCoupon)
                        isCompleteAlertPresented.toggle()
                    }
                },
                message: {
                    Text("사용이 완료된 쿠폰은 재사용할 수 없습니다.")
                }
            )
            .alert("쿠폰 사용이 완료되었습니다!", isPresented: $isCompleteAlertPresented) {
                Button("확인", role: .none) {}
            }
        }
    }
}

#Preview {
    PurchasedCouponView()
        .environment(
            CouponUseCase(
                storeService: .init(),
                dataService: .init(
                    modelContext: ModelContainerCoordinator.mockContainer.mainContext
                )
            )
        )
}
