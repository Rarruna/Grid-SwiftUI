import Foundation

class NetworkManager {
    static let sharedInstanse = NetworkManager()
    private let defaultURL = URL(string: "https://it-link.ru/test/images.txt")

    func fetchImages() async -> [URL] {
        guard let defaultURL else { return [] }
        do {
            let (data, _) = try await URLSession.shared.data(from: defaultURL)
            let images = NSString(data: data, encoding: NSUTF8StringEncoding)?
                .components(separatedBy: "\n")
                .compactMap { URL(string: $0) }
            
            return images ?? []
        } catch {
            return []
        }
    }
}
