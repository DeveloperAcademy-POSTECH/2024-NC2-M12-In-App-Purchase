//
//  CouponInfoSheetView.swift
//  Nada-Hantol-WishBook
//
//  Created by 김민준 on 6/16/24.
//

import SwiftUI

struct CouponInfoSheetView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    private let subTexts = [
        "각 쿠폰은 1회 사용이 가능합니다.",
        "기한 내에 사용해야 합니다.",
        "쿠폰은 나다와 한톨에게만 사용이 가능합니다.",
        "구매한 쿠폰은 아카데미 수료 전까지 사용이 가능합니다.",
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
                .frame(height: 40)
            
            Text("쿠폰 구매 및 사용 안내사항")
                .systemFont(.bold, 20)
                .foregroundStyle(.textBlack)
                .padding(.horizontal, 22)
            
            Spacer()
                .frame(height: 16)
            
            VStack(alignment: .leading, spacing: 4) {
                ForEach(subTexts, id: \.self) { subText in
                    CouponInfoSubText(content: subText)
                }
            }
            .padding(.horizontal, 22)
            
            Spacer()
                .frame(height: 28)
            
            ActionButton(
                title: "확인",
                buttonType: .normal,
                tapAction: {
                    dismiss()
                }
            )
            .padding(.horizontal, 24)
            
            Spacer()
        }
    }
}

private struct CouponInfoSubText: View {
    
    let content: String
    
    var body: some View {
        Text("* \(content)")
            .systemFont(.regular, 12)
            .foregroundStyle(.detailText)
    }
}

#Preview {
    CouponInfoSheetView()
}
