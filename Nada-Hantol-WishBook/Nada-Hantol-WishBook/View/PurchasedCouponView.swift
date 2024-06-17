//
//  PurchasedCouponView.swift
//  Nada-Hantol-WishBook
//
//  Created by 김민준 on 6/17/24.
//

import SwiftUI

// MARK: - PurchasedCouponView

struct PurchasedCouponView: View {
    
    @State private var isCouponUseAlertPresented = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
                .frame(height: 32)
            
            Text("구매한 쿠폰")
                .systemFont(.bold, 24)
                .foregroundStyle(.textBlack)
                .padding(.horizontal, 24)
            
            Spacer()
                .frame(height: 28)
            
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(saleWishes) { wish in
                        WishCouponCell(
                            saleWish: wish,
                            couponType: .purchase
                        )
                        .padding(.horizontal, 24)
                        .onTapGesture {
                            isCouponUseAlertPresented.toggle()
                        }
                    }
                }
            }
        }
        .alert(
            "쿠폰을 사용하시겠습니까?",
            isPresented: $isCouponUseAlertPresented,
            actions: {
                Button("그만두기", role: .none) {}
                Button("사용하기", role: .none) {
                    // TODO: 선택된 쿠폰 사용 완료 상태로 전환
                }
            },
            message: {
                Text("사용이 완료된 쿠폰은 재사용할 수 없습니다.")
            }
        )
    }
}

#Preview {
    PurchasedCouponView()
}
