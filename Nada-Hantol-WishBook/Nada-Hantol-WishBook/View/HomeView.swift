//
//  HomeView.swift
//  Nada-Hantol-WishBook
//
//  Created by 김민준 on 6/17/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            HomeTitleView()
            HomeCouponListView()
        }
    }
}

#Preview {
    HomeView()
}
