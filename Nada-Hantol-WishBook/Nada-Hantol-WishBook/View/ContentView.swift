//
//  ContentView.swift
//  Nada-Hantol-WishBook
//
//  Created by 김민준 on 6/14/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("나다와 한톨")
            .systemFont(.bold, 20)
            .foregroundStyle(.point)
        
        ActionButton(
            title: "구매한 쿠폰 확인하기",
            buttonType: .purchaseCoupon,
            tapAction: {
                // TODO: 쿠폰 구매 화면 present
            }
        )
        .padding(.horizontal, 24)
    }
}

#Preview {
    ContentView()
}
