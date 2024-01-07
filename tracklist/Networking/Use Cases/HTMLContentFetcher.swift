import Foundation

class DefaultHTMLContentFetcher: HTMLContentFetcher {
    func fetchHTMLContent(urlString: String, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let htmlContent = String(data: data, encoding: .utf8)
            completion(htmlContent)
        }
        task.resume()
    }
}

