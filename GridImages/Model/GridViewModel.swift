import Foundation

fileprivate let imagesLinksKey = "imagesLinksKey"

class GridViewModel: ObservableObject {
    private let networkManager: NetworkManager
    private let userDefaults: UserDefaults
    
    @Published var images = [URL]()

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        self.userDefaults = .standard
    }
    
    func fetchImages() {
        networkManager.fetchImages { [weak self] in
            self?.images = $0
        }
    }
}
