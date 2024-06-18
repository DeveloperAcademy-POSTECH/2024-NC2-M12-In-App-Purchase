//
//  HomeView.swift
//  Nada-Hantol-WishBook
//
//  Created by 김민준 on 6/17/24.
//

import SwiftUI
import SwiftData

// MARK: - HomeView

struct HomeView: View {
    
    @State private(set) var couponUseCase: CouponUseCase
    
    @State private var store: Store = .init()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HomeTitleView()
                
                Rectangle()
                    .frame(height: 8)
                    .foregroundStyle(.defaultBG)
                
                ScrollView {
                    HomeCouponListView()
                }
            }
        }
        .environment(couponUseCase)
        .environmentObject(store)
    }
}

// MARK: - HomeTitleView

private struct HomeTitleView: View {
    
    @State private var isRefundViewPresented = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("나다와 한톨의 소원북")
                    .systemFont(.bold, 24)
                
                Spacer()
                IconButton(
                    buttonType: .profile,
                    tapAction: {
                        isRefundViewPresented.toggle()
                    }
                )
            }
            .padding(.top, 4)
            .padding(.bottom, 12)
            
            Text("소정의 비용으로 나다와 한톨이 소원을 들어드립니다!")
                .systemFont(.bold, 14)
                .foregroundStyle(Color(.detailText))
                .padding(.bottom, 10)
        }
        .padding(22)
        .navigationDestination(isPresented: $isRefundViewPresented) {
            RefundCouponView()
                .navigationTitle("내 정보")
                .navigationBarTitleDisplayMode(.large)
        }
    }
}

// MARK: - HomeCouponListView

struct HomeCouponListView: View {
    
    @EnvironmentObject private var store: Store
    
    @State private var isInfoSheetPresented = false
    @State private var isPurchasedCouponViewPresented = false
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 32)
            
            HStack {
                Text("소원 쿠폰 구매")
                    .systemFont(.bold, 24)
                    .foregroundStyle(.textBlack)
                
                Spacer()
                
                IconButton(
                    buttonType: .info,
                    tapAction: {
                        isInfoSheetPresented.toggle()
                    }
                )
            }
            .padding(.horizontal, 24)
            
            Spacer()
                .frame(height: 28)
            
            ActionButton(
                title: "구매한 쿠폰 확인하기",
                buttonType: .purchaseCoupon,
                tapAction: {
                    isPurchasedCouponViewPresented.toggle()
                }
            )
            .padding(.horizontal, 24)
            
            Spacer()
                .frame(height: 24)
            
            VStack(spacing: 16) {
                ForEach(store.products) { product in
                    SaleCouponCell(saleCouponProduct: product) {
                        Task {
                            try await store.purchase(product)
                        }
                        // couponUseCase.purchaseCoupon(id: coupon.id)
                    }
                    .padding(.horizontal, 24)
                }
            }
        }
        .sheet(isPresented: $isInfoSheetPresented) {
            CouponInfoSheetView()
                .presentationDetents([.height(240)])
                .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $isPurchasedCouponViewPresented) {
            PurchasedCouponView()
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    HomeView(
        couponUseCase: CouponUseCase(
            storeService: StoreService(),
            dataService: DataService(modelContext: ModelContainerCoordinator.mockContainer.mainContext)
        )
    )
}
