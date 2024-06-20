//
//  ModelContainerCoordinator.swift
//  Nada-Hantol-WishBook
//
//  Created by 김민준 on 6/17/24.
//

import Foundation
import SwiftData

struct ModelContainerCoordinator {
    
    static var mainContainer: ModelContainer {
        let schema = Schema([PurchaseCoupon.self])
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do { return try ModelContainer(for: schema, configurations: [configuration]) }
        catch { fatalError("ModelContainer 생성 실패: \(error.localizedDescription)") }
    }
    
    static var mockContainer: ModelContainer {
        let schema = Schema([PurchaseCoupon.self])
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        
        do { return try ModelContainer(for: schema, configurations: [configuration]) }
        catch { fatalError("ModelContainer 생성 실패: \(error.localizedDescription)") }
    }
}
