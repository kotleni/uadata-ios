import Foundation

class UaDataAPI {
    static private func getData(file: String, callback: @escaping (Int) -> ()) {
        let url = URL(string: "https://uadata.net/ukraine-russia-war-2022/\(file).json")!
        let session = URLSession.shared
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    let _data = json["data"] as? [[String: Any]]
                    let _value = _data![0]["val"]! as? Int
                    
                    callback(_value!)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })

        task.resume()
    }
    
    static func getPeoples(callback: @escaping (Int) -> ()) {
        getData(file: "people") { count in callback(count) }
    }
    
    static func getBBM(callback: @escaping (Int) -> ()) {
        getData(file: "bbm") { count in callback(count) }
    }
    
    static func getPlanes(callback: @escaping (Int) -> ()) {
        getData(file: "planes") { count in callback(count) }
    }
    
    static func getTanks(callback: @escaping (Int) -> ()) {
        getData(file: "tanks") { count in callback(count) }
    }
    
    static func getArtilery(callback: @escaping (Int) -> ()) {
        getData(file: "artilery") { count in callback(count) }
    }
    
    static func getRSZV(callback: @escaping (Int) -> ()) {
        getData(file: "rszv") { count in callback(count) }
    }
    
    static func getPPO(callback: @escaping (Int) -> ()) {
        getData(file: "ppo") { count in callback(count) }
    }
    
    static func getHelicopters(callback: @escaping (Int) -> ()) {
        getData(file: "helicopters") { count in callback(count) }
    }
    
    static func getAuto(callback: @escaping (Int) -> ()) {
        getData(file: "auto") { count in callback(count) }
    }
    
    static func getShips(callback: @escaping (Int) -> ()) {
        getData(file: "ships") { count in callback(count) }
    }
    
    static func getPMM(callback: @escaping (Int) -> ()) {
        getData(file: "pmm") { count in callback(count) }
    }
    
    static func getBPLA(callback: @escaping (Int) -> ()) {
        getData(file: "bpla") { count in callback(count) }
    }
}
