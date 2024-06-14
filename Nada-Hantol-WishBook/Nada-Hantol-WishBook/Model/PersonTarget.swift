//
//  Target.swift
//  Nada-Hantol-WishBook
//
//  Created by 김민준 on 6/14/24.
//

import SwiftUI

enum PersonTarget {
    case nada
    case hantol
    case all
    
    var name: String {
        switch self {
        case .nada: return "나다"
        case .hantol: return "한톨"
        case .all: return "나다 or 한톨"
        }
    }
    
    var image: Image {
        switch self {
        case .nada: return Image(.nada)
        case .hantol: return Image(.hantol)
        case .all: return Image(.nadaOrHantol)
        }
    }
}
