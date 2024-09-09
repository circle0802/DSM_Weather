import Foundation

// MARK: - WeatherElement
struct WeatherElement: Codable {
    let localObservationDateTime: String
    let epochTime: Int64  
    let weatherText: String
    let weatherIcon: Int32
    let hasPrecipitation: Bool
    let precipitationType: String?
    let isDayTime: Bool
    let temperature: Temperature
    let mobileLink, link: String

    enum CodingKeys: String, CodingKey {
        case localObservationDateTime = "LocalObservationDateTime"
        case epochTime = "EpochTime"
        case weatherText = "WeatherText"
        case weatherIcon = "WeatherIcon"
        case hasPrecipitation = "HasPrecipitation"
        case precipitationType = "PrecipitationType"
        case isDayTime = "IsDayTime"
        case temperature = "Temperature"
        case mobileLink = "MobileLink"
        case link = "Link"
    }
}


// MARK: - Temperature
struct Temperature: Codable {
    let metric, imperial: Imperial

    enum CodingKeys: String, CodingKey {
        case metric = "Metric"
        case imperial = "Imperial"
    }
}

// MARK: - Imperial
struct Imperial: Codable {
    let value: Double
    let unit: String
    let unitType: Int32

    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
        case unitType = "UnitType"
    }
}

typealias Weather = [WeatherElement]

