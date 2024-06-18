//
//  WishCouponCell.swift
//  Nada-Hantol-WishBook
//
//  Created by YejiKim on 6/14/24.
//

import SwiftUI
import StoreKit

struct PurchaseCouponCell: View {
    
    enum CouponType {
        case purchase
        case refund
        case used
    }
    
    let purchaseCoupon: Product
    let couponType: CouponType
    let buttonTap: () -> Void
    
    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(purchaseCoupon.displayName)
                        .systemFont(.semiBold, 18)
                        .padding(.bottom, 4)
                    
                    Text("\(purchaseCoupon.displayPrice)")
                        .systemFont(.bold, 17)
                        .padding(.bottom, 8)
                        .foregroundColor(.point)
                    
                    HStack(spacing: 4) {
                        Text(purchaseCoupon.target.name)
                            .systemFont(.medium, 14)
                            .foregroundColor(.detailText)
                        
                        purchaseCoupon.target.image
                    }
                    .padding(.bottom, 15)
                    
                    CouponButtonType()
                }
                
                Spacer()
                
                Text(purchaseCoupon.emoji)
                    .systemFont(.bold, 77)
                    .offset(y: 22)
            }
            .padding(24)
            .background(Color(.fieldBG))
            .cornerRadius(12)
            .opacity(couponType == .used ? 0.2 : 1)
            
            if couponType == .used {
                HStack {
                    Spacer()
                    
                    Image(.stamp)
                        .resizable()
                        .frame(width: 100, height: 100)
                }
                .padding(.horizontal, 48)
            }
        }
    }
    
    @ViewBuilder
    private func CouponButtonType () -> some View {
        HStack(spacing: 8) {
            switch couponType {
            case .purchase:
                Button {
                    buttonTap()
                } label: {
                    Text("사용하기")
                        .systemFont(.bold, 14)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color(.pointSecondary))
                        .cornerRadius(8)
                }
                .foregroundColor(.point)
                
                Text("구매일 \(purchaseCoupon)")
                    .systemFont(.semiBold, 12)
                    .foregroundStyle(.detailText)
                
            case .refund:
                Button {
                    buttonTap()
                } label: {
                    Text("환불하기")
                        .systemFont(.bold, 14)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color(.warningBG))
                        .cornerRadius(8)
                }
                .foregroundColor(.warningText)
                
                Text("구매일 TEST")
                    .systemFont(.semiBold, 12)
                    .foregroundStyle(.detailText)
                
            case .used:
                Text("구매일 TEST")
                    .systemFont(.semiBold, 12)
                    .foregroundStyle(.detailText)
                
                Rectangle()
                    .foregroundStyle(.detailText)
                    .frame(width: 2, height: 8)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                
                Text("사용일 TEST")
                    .systemFont(.semiBold, 12)
                    .foregroundStyle(.detailText)
            }
        }
        .frame(height: 32)
    }
}
