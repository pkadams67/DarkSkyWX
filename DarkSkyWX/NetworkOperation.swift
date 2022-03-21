import Foundation

class NetworkOperation {

	// MARK: Lifecycle

	init(url: URL) {
		queryURL = url
	}

	// MARK: Internal

	typealias JSONDictionaryCompletion = ([String: AnyObject]?) -> Void

	lazy var config = URLSessionConfiguration.default
	lazy var session = URLSession(configuration: self.config)
	let queryURL: URL

	func downloadJSONFromURL(_ completion: @escaping JSONDictionaryCompletion) {
		let request = URLRequest(url: queryURL)
		let dataTask = session.dataTask(with: request, completionHandler: { data, response, _ in
			if let httpResponse = response as? HTTPURLResponse {
				switch httpResponse.statusCode {
					case 200:
						let jsonDictionary = (try? JSONSerialization.jsonObject(with: data!, options: [])) as? [String: AnyObject]
						completion(jsonDictionary)
					default:
						print("GET request not successful. HTTP status code: \(httpResponse.statusCode)")
				}
			} else {
				print("Error: Not a valid HTTP response")
			}
		})
		dataTask.resume()
	}
}
