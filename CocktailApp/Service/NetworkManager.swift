import Foundation

//class NetworkdManager {
//
//    static let shared = NetworkdManager()
//
//    private init() {}
//
//    func fetchData(cocktailName request: String, completed: @escaping (Result<Cocktail, GFError>) -> Void) {
//
//
//        guard let cocktail = request.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
//
//                let url = URL(string: "https://api.api-ninjas.com/v1/cocktail?name=\(cocktail.lowercased())"
//              )
//
//        else {
//            completed(.failure(GFError.invalidURL))
//            return
//        }
//
//        var urlRequest = URLRequest(url: url)
//        urlRequest.setValue(
//            "GnHE8tlwugEwcUP75rr4AQ==3eJLRuGwlxJgOo6k",
//            forHTTPHeaderField: "X-Api-Key"
//        )
//
//        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
//
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//            }
//
//            guard let response = response  as? HTTPURLResponse,
//                  response.statusCode == 200 else {
//                  completed(.failure(.invalidResponse))
//                return
//            }
//            guard let data = data else {
//                completed(.failure(.invalidData))
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                let quote = try decoder.decode(Cocktail.self, from: data)
//                completed(.success(quote))
//            } catch {
//                completed(.failure(GFError.invalidData))
//            }
//        }
//        task.resume()
//    }
//
    final class NetworkManager {

        static let shared   = NetworkManager()

        private init() {}

        func retrieveData(from url: URL) async throws -> Cocktail {
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.addValue("GnHE8tlwugEwcUP75rr4AQ==3eJLRuGwlxJgOo6k", forHTTPHeaderField: "X-Api-Key")
            let (data, _) = try await session.data(for: request)
            let decoder = JSONDecoder()
            print(String(data: data, encoding: .utf8) ?? "No data")
            return try decoder.decode(Cocktail.self, from: data)
        }
    }

