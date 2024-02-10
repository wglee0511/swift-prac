import Foundation


let GOLD_PRICE_TOKEN = ""
let GOLD_PRICE_BASE_URL = "https://www.goldapi.io/api/XAU/USD"
let GOLD_PRICE_TOKEN_KET = "x-access-token"

enum SymbolType : String {
    case XAU = "XAU"
    case XAG = "XAG"
    case XPT = "XPT"
    case XPD = "XPD"
}

struct GoldPriceDataType : Codable {
    var timestamp : Int
    var metal : SymbolType.RawValue
    var currency : String
    var prev_close_price  : Float
}

func getPriceData () async throws -> GoldPriceDataType {
    var request = URLRequest(url: URL(string: GOLD_PRICE_BASE_URL)!)
    
    request.httpMethod = "GET"
    request.addValue(GOLD_PRICE_TOKEN, forHTTPHeaderField: GOLD_PRICE_TOKEN_KET)
    
    var session = URLSession.shared
    
    let (data, _) = try await session.data(for: request)
    
    let decoder = JSONDecoder()
    let result = try decoder.decode(GoldPriceDataType.self, from: data)
    
    return result
}

Task {
    do {
        let response = try await getPriceData()
    } catch {
        print("Error fetching data: \(error)")
    }
}

