//
//  ContentView.swift
//  Nada-Hantol-WishBook
//
//  Created by 김민준 on 6/14/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var infoSheetPresented = false
    
    var body: some View {
        VStack {
            Text("나다와 한톨")
                .systemFont(.bold, 20)
                .foregroundStyle(.point)
            
            IconButton(
                buttonType: .info,
                tapAction: {
                    infoSheetPresented.toggle()
                }
            )
            
            ActionButton(
                title: "구매한 쿠폰 확인하기",
                buttonType: .purchaseCoupon,
                tapAction: {
                    // TODO: 쿠폰 구매 화면 present
                }
            )
            .padding(.horizontal, 24)
        }
        .sheet(isPresented: $infoSheetPresented) {
            CouponInfoSheetView()
                .presentationDetents([.height(240)])
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    ContentView()
}
