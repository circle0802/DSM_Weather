import Moya
import Foundation

enum WeatherAPI {
    case weather
}

extension WeatherAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://dataservice.accuweather.com")!
    }
  
    var path: String {
        return "/currentconditions/v1/1315057"
    }
    
    var method: Moya.Method {
        switch self {
        case .weather :
            return .get
        }
    }
    
    var task: Moya.Task {
        let parameters: [String: Any] = [
            "apikey": "8mDRGErHmt7QycIkrV5Rb46FnuNEwQP3",
            "language": "ko-kr"
        ]
        return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}



