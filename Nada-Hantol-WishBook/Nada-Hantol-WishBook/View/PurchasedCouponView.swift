//
//  PurchasedCouponView.swift
//  Nada-Hantol-WishBook
//
//  Created by 김민준 on 6/17/24.
//

import SwiftUI
import StoreKit

// MARK: - PurchasedCouponView

struct PurchasedCouponView: View {
    
    @Environment(CouponUseCase.self) private var couponUseCase
    
    @State private var isCouponAvailableToggle = false
    @State private var isCouponUseAlertPresented = false
    @State private var isCompleteAlertPresented = false
    
    @State private var selectedCoupon: PurchaseCoupon?
    
    private var coupons: [PurchaseCoupon] {
        if isCouponAvailableToggle {
            return couponUseCase.purchaseCoupons.filter { !$0.isUsed }
        } else {
            return couponUseCase.purchaseCoupons
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
                .frame(height: 48)
            
            Text("구매한 쿠폰")
                .systemFont(.bold, 24)
                .foregroundStyle(.textBlack)
                .padding(.horizontal, 26)
            
            Spacer()
                .frame(height: 8)
            
            HStack(spacing: 0) {
                Text("지금까지 총 ")
                    .systemFont(.bold, 14)
                    .foregroundStyle(.detailText)
                
                Text("₩\(couponUseCase.totalPrice())원")
                    .systemFont(.bold, 14)
                    .foregroundStyle(.point)
                
                Text("만큼 쿠폰을 구매했어요")
                    .systemFont(.bold, 14)
                    .foregroundStyle(.detailText)
            }
            .padding(.horizontal, 26)
            
            Spacer()
                .frame(height: 32)
            
            HStack {
                Text("전체 \(coupons.count)")
                    .systemFont(.semiBold, 14)
                    .foregroundStyle(.detailText)
                
                Spacer()
                
                Text("사용 가능한 쿠폰")
                    .systemFont(.semiBold, 14)
                    .foregroundStyle(.detailText)
                
                Toggle(isOn: $isCouponAvailableToggle) {}
                    .tint(.point)
                    .fixedSize()
                    .onChange(of: isCouponAvailableToggle) { _, newValue in
                        
                    }
            }
            .padding(.horizontal, 26)
            
            Spacer()
                .frame(height: 16)
            
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(coupons) { coupon in
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
                "\(couponUseCase.toSaleCoupon(selectedCoupon ?? .init(couponId: 0, transactionId: 0)).title) 쿠폰을 사용하시겠습니까?",
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
