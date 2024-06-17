//
//  RefundView.swift
//  Nada-Hantol-WishBook
//
//  Created by 김민준 on 6/17/24.
//

import SwiftUI

struct RefundView: View {
    var body: some View {
        
        VStack(alignment: .leading){
            Spacer()
                .frame(height: 28)
            Text("쿠폰 환불")
                .systemFont(.bold, 24)
            
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(saleCoupons) { wish in
                        WishCouponCell(saleWish: wish, couponType: .refund)
                    }
                }
            }
        }
        .padding(.horizontal, 22)
    }
}

#Preview {
    RefundView()
}
