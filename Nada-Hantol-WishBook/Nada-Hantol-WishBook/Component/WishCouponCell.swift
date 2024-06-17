//
//  WishCouponCell.swift
//  Nada-Hantol-WishBook
//
//  Created by YejiKim on 6/14/24.
//

import SwiftUI

struct WishCouponCell: View {
    let saleWish: SaleWish
    
    enum CouponType {
        case sale
        case purchase
        case refund
        case used
    }
    
    let couponType: CouponType
    
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
                
                CouponButtonType()
                
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
    
    @ViewBuilder
    private func CouponButtonType () -> some View {
        HStack {
            switch couponType {
            case .sale:
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
            case .purchase:
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
                Text("구매일: 24.06.13")
                    .systemFont(.semiBold, 12)
                    .foregroundStyle(.detailText)
            case .refund:
                Button {
                    
                } label: {
                    Text("환불하기")
                        .systemFont(.bold, 14)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color(.warningBG))
                        .cornerRadius(8)
                }
                .foregroundColor(.warningText)
                Text("구매일: 24.06.13")
                    .systemFont(.semiBold, 12)
                    .foregroundStyle(.detailText)
            case .used:
                Text("구매일: 24.06.13")
                    .systemFont(.semiBold, 12)
                    .foregroundStyle(.detailText)
                Text("|")
                    .systemFont(.semiBold, 12)
                    .foregroundStyle(.detailText)
                Text("사용일: 24.06.17")
                    .systemFont(.semiBold, 12)
                    .foregroundStyle(.detailText)
            }
            
        }
    }
}

#Preview {
    VStack{
        WishCouponCell(
            saleWish: SaleWish(
                title: "Test title",
                price: 150000,
                target: PersonTarget.nada,
                emoji: "🧊"
            ), couponType: .sale
        )
        WishCouponCell(
            saleWish: SaleWish(
                title: "Test title",
                price: 150000,
                target: PersonTarget.nada,
                emoji: "🧊"
            ), couponType: .purchase
        )
        WishCouponCell(
            saleWish: SaleWish(
                title: "Test title",
                price: 150000,
                target: PersonTarget.nada,
                emoji: "🧊"
            ), couponType: .refund
        )
        WishCouponCell(
            saleWish: SaleWish(
                title: "Test title",
                price: 150000,
                target: PersonTarget.nada,
                emoji: "🧊"
            ), couponType: .used
        )
    }
}
