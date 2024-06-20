//
//  RefundCouponView.swift
//  Nada-Hantol-WishBook
//
//  Created by 김민준 on 6/17/24.
//

import SwiftUI
import StoreKit

struct RefundCouponView: View {
    
    @Environment(CouponUseCase.self) private var couponUseCase
    @Environment(\.dismiss) private var dismiss
    
    @State var selectedTransactionID: UInt64?
    @State private var isRefundSheetPresented = false
    
    var body: some View {
        
        VStack(alignment: .leading){
            Spacer()
                .frame(height: 28)
            
            HStack {
                Text("쿠폰 환불")
                    .systemFont(.bold, 24)
                    .foregroundStyle(.textBlack)
                
                Spacer()
            }
            .padding(.horizontal, 26)
            
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(couponUseCase.refundCoupons) { coupon in
                        PurchaseCouponCell(
                            purchaseCoupon: coupon,
                            couponType: coupon.isRefundPending ? .pendingRefund : .refund
                        ) {
                            selectedTransactionID = coupon.transactionId
                            print("쿠폰이름: \(coupon.emoji)")
                            print("환불할 아이디: \(selectedTransactionID!)")
                            isRefundSheetPresented.toggle()
                        }
                        .padding(.horizontal, 22)
                    }
                }
            }
        }
        .refundRequestSheet(
            for: selectedTransactionID ?? 0,
            isPresented: $isRefundSheetPresented
        ) { result in
            handleRefund(result: result)
        }
    }
    
    func handleRefund(
        result: Result<
        StoreKit.Transaction.RefundRequestStatus,
        StoreKit.Transaction.RefundRequestError
        >
    ) {
        couponUseCase.refundCoupon(transactionId: selectedTransactionID ?? 0)
    }
}

#Preview {
    RefundCouponView()
        .environment(
            CouponUseCase(
                storeService: .init(),
                dataService: .init(
                    modelContext: ModelContainerCoordinator.mockContainer.mainContext
                )
            )
        )
}
