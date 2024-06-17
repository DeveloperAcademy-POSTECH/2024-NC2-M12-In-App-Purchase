//
//  HomeCouponListView.swift
//  Nada-Hantol-WishBook
//
//  Created by 김민준 on 6/17/24.
//

import SwiftUI

struct HomeCouponListView: View {
    
    @State private var infoSheetPresented = false
    
    var body: some View {
        VStack {
            HStack {
                Text("소원 쿠폰 구매")
                    .systemFont(.bold, 24)
                    .foregroundStyle(.textBlack)
                
                Spacer()
                
                IconButton(
                    buttonType: .info,
                    tapAction: {
                        infoSheetPresented.toggle()
                    }
                )
            }
            .padding(.horizontal, 24)
            
            Spacer()
                .frame(height: 28)
            
            ActionButton(
                title: "구매한 쿠폰 확인하기",
                buttonType: .purchaseCoupon,
                tapAction: {
                    // TODO: 내 쿠폰 확인하기 화면 이동
                }
            )
            .padding(.horizontal, 24)
            
            Spacer()
                .frame(height: 24)
            
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(saleWishes) { wish in
                        WishCouponCell(saleWish: wish)
                            .padding(.horizontal, 24)
                    }
                }
            }
        }
        .sheet(isPresented: $infoSheetPresented) {
            CouponInfoSheetView()
                .presentationDetents([.height(240)])
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    HomeCouponListView()
}
