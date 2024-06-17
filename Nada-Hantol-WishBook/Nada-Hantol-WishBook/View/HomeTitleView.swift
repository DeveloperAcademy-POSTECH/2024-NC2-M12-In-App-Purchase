//
//  HomeTitleView.swift
//  Nada-Hantol-WishBook
//
//  Created by 김민준 on 6/17/24.
//

import SwiftUI

struct HomeTitleView: View {
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text("나다와 한톨의 소원북")
                    .systemFont(.bold, 24)
                    
                Spacer()
                IconButton(
                    buttonType: .info,
                    tapAction: {
                        print("프로필 버튼 탭!")
                    }
                )
            }
            .padding(.bottom, 11)
            .padding(.top, 4)
            
            Text("소정의 비용으로 나다와 한톨이 소원을 들어드립니다!")
                .systemFont(.medium, 14)
                .foregroundStyle(Color(.detailText))
                .padding(.bottom, 10)
        }
        .padding(22)
    }
}

#Preview {
    HomeTitleView()
}
