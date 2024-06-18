//
//  SaleCouponCell.swift
//  Nada-Hantol-WishBook
//
//  Created by 김민준 on 6/17/24.
//

import SwiftUI

struct SaleCouponCell: View {
    
    let saleCoupon: SaleCoupon
    let purchaseButtonTap: () -> Void
    
    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(saleCoupon.title)
                        .systemFont(.semiBold, 18)
                        .padding(.bottom, 4)
                    
                    Text("$\(saleCoupon.price)")
                        .systemFont(.bold, 17)
                        .padding(.bottom, 8)
                        .foregroundColor(.point)
                    
                    HStack(spacing: 4) {
                        Text(saleCoupon.target.name)
                            .systemFont(.medium, 14)
                            .foregroundColor(.detailText)
                        
                        saleCoupon.target.image
                    }
                    .padding(.bottom, 15)
                    
                    Button {
                        purchaseButtonTap()
                    } label: {
                        Text("구매하기")
                            .systemFont(.bold, 14)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color(.pointSecondary))
                            .cornerRadius(8)
                    }
                    .foregroundColor(.point)
                }
                
                Spacer()
                
                Text(saleCoupon.emoji)
                    .systemFont(.bold, 77)
                    .offset(y: 22)
            }
            .padding(24)
            .background(Color(.fieldBG))
            .cornerRadius(12)
        }
    }
}
