//
//  WishCouponCell.swift
//  Nada-Hantol-WishBook
//
//  Created by YejiKim on 6/14/24.
//

import SwiftUI

struct WishCouponCell: View {
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text("도서관에서 얼음 떠다주기")
                    .systemFont(.semiBold, 18)
                    .padding(.bottom, 4)
                Text("₩150,000")
                    .systemFont(.bold, 17)
                    .padding(.bottom, 8)
                    .foregroundColor(.point)
                Text("Nada")
                    .systemFont(.medium, 14)
                    .padding(.bottom, 15)
                Button {
                    
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
            Text("🧊")
                .systemFont(.bold, 77)
                .offset(y: 22)
        }
        .padding(24)
        .background(Color(.fieldBG))
        .cornerRadius(12)
        
    }
}

#Preview {
    WishCouponCell()
}
