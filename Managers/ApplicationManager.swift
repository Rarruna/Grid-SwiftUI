import Foundation

private func makeSharedInstanse() -> ApplicationManager {
    let networkManager = NetworkManager.sharedInstanse
    let viewModel = GridViewModel(networkManager: networkManager)
    
    return ApplicationManager(networkManager: networkManager,
                              viewModel: viewModel)
}

class ApplicationManager {
    let networkManager: NetworkManager
    let viewModel: GridViewModel
    
    init(networkManager: NetworkManager,
         viewModel: GridViewModel) {
        self.networkManager = networkManager
        self.viewModel = viewModel
    }
    
    static let sharedInstanse = makeSharedInstanse()
}
