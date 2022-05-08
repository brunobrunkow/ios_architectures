import ComposableArchitecture
import SwiftUI

@main
struct CoreDataSwiftUIApp: App {

    var body: some Scene {
        WindowGroup {
            MainView(
                Store(
                    initialState: MainState(),
                    reducer: mainReducer,
                    environment: .live
                )
            )
        }
    }
}
