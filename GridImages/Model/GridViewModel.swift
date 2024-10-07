import Foundation

fileprivate let imagesLinksKey = "imagesLinksKey"

class GridViewModel: ObservableObject {
    private let networkManager: NetworkManager
    private let userDefaults: UserDefaults
    
    @Published var imageLinks = [URL]()

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        self.userDefaults = .standard
    }
    
    func fetchImages() async {
        imageLinks = await networkManager.fetchImages()
    }
}
