//
//  SaleCouponCell.swift
//  Nada-Hantol-WishBook
//
//  Created by 김민준 on 6/17/24.
//

import SwiftUI
import StoreKit

struct SaleCouponCell: View {
    
    let saleCouponProduct: Product
    let purchaseButtonTap: () -> Void
    
    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(saleCouponProduct.displayName)
                        .systemFont(.semiBold, 18)
                        .padding(.bottom, 4)
                    
                    Text("\(saleCouponProduct.displayPrice)")
                        .systemFont(.bold, 17)
                        .padding(.bottom, 8)
                        .foregroundColor(.point)
                    
                    HStack(spacing: 4) {
                        Text(saleCouponProduct.target.name)
                            .systemFont(.medium, 14)
                            .foregroundColor(.detailText)
                        
                        saleCouponProduct.target.image
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
                
                Text(saleCouponProduct.emoji)
                    .systemFont(.bold, 77)
                    .offset(y: 22)
            }
            .padding(24)
            .background(Color(.fieldBG))
            .cornerRadius(12)
        }
    }
}
