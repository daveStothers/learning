//
//  ApiRequests.swift
//  techTest
//
//

import Foundation

class ApiRequests {

    var session = URLSession.shared

    //API request call without a body
    public func makeApiRequest(endpoint: String, callback:  @escaping (_ data: Data) -> Void) -> String {
        return makeApiRequest(endpoint: endpoint, body: nil, callback:  callback)
    }

    //Perform an actual api request
    public func makeApiRequest(endpoint: String, body: [String : String]?, callback:  @escaping (_ data: Data) -> Void) -> String {
        let url = NSURL(string: "http://stotherd.com/techTest-phpfiles/api/" + endpoint)
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        if (body != nil) {
            let postString = getPostString(params: body!)
            request.httpBody = postString.data(using: .utf8)
        }

        let task = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            guard error == nil else {
                return
            }
            guard let data = data else { return }
            do{
                DispatchQueue.main.async {
                    callback(data)
                }
            }
        }
        task.resume()
        return "Loading"
    }

    //Create POST data
    func getPostString(params:[String:Any]) -> String
    {
        var data = [String]()
        for(key, value) in params
        {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }

}
