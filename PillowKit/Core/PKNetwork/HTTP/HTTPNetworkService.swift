import Foundation


private let logger = Logger()

public protocol HTTPNetworkService {
    func request<Request: HTTPRequest>(
        _ request: Request,
        queue: DispatchQueue,
        completion: @escaping (Result<Request.Response, Error>) -> Void
    )
}

public class DefaultHTTPNetworkService: HTTPNetworkService {
    public func request<Request: HTTPRequest>(
        _ request: Request,
        queue: DispatchQueue,
        completion: @escaping (Result<Request.Response, Error>) -> Void
    ) {
        guard let url = url(from: request) else {
            queue.async {
                logger.error("NetworkService: url error")
                completion(.failure(HTTPError.notFound))
            }
            return
        }
        
        let urlRequest = makeUrlRequest(
            url: url,
            request: request
        )
        
        let dataTaskHandler = dataTaskHandler(
            request: request,
            queue: .main,
            completion: completion
        )
        
        URLSession.shared
            .dataTask(
                with: urlRequest,
                completionHandler: dataTaskHandler
            )
            .resume()
    }
}

extension DefaultHTTPNetworkService {
    private func url<Request: HTTPRequest>(from request: Request) -> URL? {
        guard var urlComponent = URLComponents(string: request.url) else {
            return nil
        }
        
        let urlQueryItems: [URLQueryItem] = request.queryItems.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        urlComponent.queryItems?.append(contentsOf: urlQueryItems)
        urlComponent.queryItems = urlQueryItems
        
        return urlComponent.url
    }
    
    private func makeUrlRequest<Request: HTTPRequest>(
        url: URL,
        request: Request
    ) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        if request.body.isEmpty == false {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: request.body)
        }
        
        return urlRequest
    }
    
    private func dataTaskHandler<Request: HTTPRequest>(
        request: Request,
        queue: DispatchQueue,
        completion: @escaping (Result<Request.Response, Error>) -> Void
    ) ->(Data?, URLResponse?, Error?) -> Void {
        return { (data, response, error) -> Void in
            if let error = error {
                queue.async {
                    logger.error("NetworkService: requrest error - \(error.localizedDescription)")
                    completion(.failure(error))
                }
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                queue.async {
                    logger.error("NetworkService: code status not ok")
                    completion(.failure(HTTPError.badRequest))
                }
                return
            }
            
            guard let data = data else {
                queue.async {
                    logger.error("NetworkService: no data")
                    completion(.failure(HTTPError.badRequest))
                }
                return
            }
            
            queue.async {
                do {
                    try completion(.success(request.decode(data)))
                } catch let error as NSError {
                    logger.error("NetworkService: no parse entity")
                    completion(.failure(error))
                }
            }
        }
    }
}
