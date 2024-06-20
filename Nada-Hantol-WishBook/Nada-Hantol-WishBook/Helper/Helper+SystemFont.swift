//
//  Helper+SystemFont.swift
//  Nada-Hantol-WishBook
//
//  Created by 김민준 on 6/14/24.
//

import SwiftUI

struct SystemFontViewModifier: ViewModifier {
    
    enum FontWeight {
        case regular
        case medium
        case semiBold
        case bold
        
        var systemFontWeight: Font.Weight {
            switch self {
            case .regular: return .regular
            case .medium: return .medium
            case .semiBold: return .semibold
            case .bold: return .bold
            }
        }
    }
    
    let fontSize: CGFloat
    let fontWeight: FontWeight
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: fontSize, weight: fontWeight.systemFontWeight))
    }
}

extension View {
    
    /// 시스템 폰트를 반환합니다.
    func systemFont(_ weight: SystemFontViewModifier.FontWeight, _ size: CGFloat) -> some View {
        modifier(SystemFontViewModifier(fontSize: size, fontWeight: weight))
    }
}
