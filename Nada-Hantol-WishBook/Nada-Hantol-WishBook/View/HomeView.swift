//
//  HomeView.swift
//  Nada-Hantol-WishBook
//
//  Created by 김민준 on 6/17/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(spacing: 0) {
            HomeTitleView()
            
            Rectangle()
                .frame(height: 12)
                .foregroundStyle(Color(red: 238/255, green: 238/255, blue: 238/255))
            
            HomeCouponListView()
        }
    }
}

#Preview {
    HomeView()
}
