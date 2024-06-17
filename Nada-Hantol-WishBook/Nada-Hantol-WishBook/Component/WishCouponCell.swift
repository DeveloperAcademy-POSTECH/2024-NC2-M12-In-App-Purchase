//
//  WishCouponCell.swift
//  Nada-Hantol-WishBook
//
//  Created by YejiKim on 6/14/24.
//

import SwiftUI

struct WishCouponCell: View {
    let saleWish: SaleWish
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(saleWish.title)
                    .systemFont(.semiBold, 18)
                    .padding(.bottom, 4)
                Text("₩\(saleWish.price)")
                    .systemFont(.bold, 17)
                    .padding(.bottom, 8)
                    .foregroundColor(.point)
                HStack{
                    Text(saleWish.target.name)
                        .systemFont(.medium, 14)
                        .foregroundColor(.detailText)
                    saleWish.target.image
                }
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
            Spacer()
            Text(saleWish.emoji)
                .systemFont(.bold, 77)
                .offset(y: 22)
        }
        .padding(24)
        .background(Color(.fieldBG))
        .cornerRadius(12)
    }
}

#Preview {
    WishCouponCell(saleWish: SaleWish(title: "Test title", price: 150000, target: PersonTarget.nada, emoji: "🧊"))
}
