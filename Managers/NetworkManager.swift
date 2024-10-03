import Foundation
import Alamofire

class NetworkManager {
    static let sharedInstanse = NetworkManager()
    private let defaultURL = URL(string: "https://it-link.ru/test/images.txt")

    func fetchImages(_ completion: @escaping ([URL]) -> ()) {
        guard let defaultURL else {
            completion([])
            return
        }
        
        AF.request(defaultURL, method: .get).responseString {
            response in
            switch response.result {
            case .success(let data):
                let images = data.components(separatedBy: "\n")
                    .compactMap { URL(string: $0) }
                    .filter { UIApplication.shared.canOpenURL($0) }
                completion(images)
            case .failure(let error):
                print(error.localizedDescription)
                completion([])
            }
        }
        
    }
}
