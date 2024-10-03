import SwiftUI

@main
struct GridImagesApp: App {
    
    private var appManager: ApplicationManager {
        .sharedInstanse
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: appManager.viewModel)
        }
    }
}
