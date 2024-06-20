//
//  Nada_Hantol_WishBookApp.swift
//  Nada-Hantol-WishBook
//
//  Created by 김민준 on 6/14/24.
//

import SwiftUI
import SwiftData

@main
struct Nada_Hantol_WishBookApp: App {
    
    private let modelContainer = ModelContainerCoordinator.mainContainer
    
    var body: some Scene {
        WindowGroup {
            HomeView(
                couponUseCase: CouponUseCase(
                    storeService: StoreService(),
                    dataService: DataService(modelContext: modelContainer.mainContext)
                )
            )
        }
        .modelContainer(modelContainer)
    }
}
