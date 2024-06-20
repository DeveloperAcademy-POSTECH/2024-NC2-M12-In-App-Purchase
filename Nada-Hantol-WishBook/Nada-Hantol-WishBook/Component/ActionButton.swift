//
//  ActionButton.swift
//  Nada-Hantol-WishBook
//
//  Created by 김민준 on 6/16/24.
//

import SwiftUI

struct ActionButton: View {
    
    enum ButtonType {
        case normal
        case purchaseCoupon
    }
    
    let title: String
    let buttonType: ButtonType
    let tapAction: () -> Void
    
    var body: some View {
        Button {
            tapAction()
        } label: {
            HStack {
                if buttonType == .purchaseCoupon {
                    Image(systemName: "ticket.fill")
                }
                
                Text(title)
                    .systemFont(.bold, 15)
            }
            .foregroundStyle(.textWhite)
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .background(.point)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

#Preview {
    ActionButton(
        title: "구매한 쿠폰 확인하기",
        buttonType: .purchaseCoupon,
        tapAction: {
            print("쿠폰 구매하기!")
        }
    )
}
