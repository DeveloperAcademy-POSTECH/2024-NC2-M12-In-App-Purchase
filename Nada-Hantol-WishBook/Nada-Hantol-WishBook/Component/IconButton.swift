//
//  IconButton.swift
//  Nada-Hantol-WishBook
//
//  Created by 김민준 on 6/16/24.
//

import SwiftUI

struct IconButton: View {
    
    enum ButtonType {
        case info
        case profile
    }
    
    let buttonType: ButtonType
    let tapAction: () -> Void
    
    var body: some View {
        Button {
            tapAction()
        } label: {
            Image(
                systemName: buttonType == .info
                ? "info" : "person.fill"
            )
            .foregroundStyle(.point)
            .frame(width: 32, height: 32)
            .background(.pointSecondary)
            .clipShape(Circle())
        }
    }
}

#Preview {
    IconButton(
        buttonType: .info,
        tapAction: {
            print("아이콘 버튼 탭!")
        }
    )
}
