//
//  PurchaseWishCouponCell.swift
//  Nada-Hantol-WishBook
//
//  Created by YejiKim on 6/15/24.
//

import SwiftUI

struct PurchaseWishCouponCell: View {
    var purchaseWish: PurchaseWish
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(purchaseWish.wish.title)
                    .systemFont(.semiBold, 18)
                    .padding(.bottom, 4)
                Text("₩\(purchaseWish.wish.price)")
                    .systemFont(.bold, 17)
                    .padding(.bottom, 8)
                    .foregroundColor(.point)
                HStack{
                    Text(purchaseWish.wish.target.name)
                        .systemFont(.medium, 14)
                        .foregroundColor(.detailText)
                    purchaseWish.wish.target.image
                }
                    .padding(.bottom, 15)
                HStack{
                    Button {
                        
                    } label: {
                        Text("사용하기")
                            .systemFont(.bold, 14)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color(.pointSecondary))
                            .cornerRadius(8)
                    }
                    .foregroundColor(.point)
                    .padding(.trailing, 8)
                    Text("구매일: 24.06.15")
                        .systemFont(.semiBold, 12)
                        .foregroundStyle(Color(.detailText))
                }
            }
            Spacer()
            Text(purchaseWish.wish.emoji)
                .systemFont(.bold, 77)
                .offset(y: 22)
        }
        .padding(24)
        .background(Color(.fieldBG))
        .cornerRadius(12)
    }
}

#Preview {
    PurchaseWishCouponCell(purchaseWish: PurchaseWish(wish: SaleWish(title: "도서관에서 얼음 떠오기", price: 3300, target: PersonTarget.all, emoji: "🧊"), usedDate: Date()))
//    WishCouponCell(saleWish: SaleWish(title: "Test title", price: 150000, target: PersonTarget.nada, emoji: "🧊"))
}
