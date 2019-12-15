import Foundation

open class GenericDecoder<IN, OUT: Decodable> {
    public class func decode(json inObject: IN) -> OUT? {
        fatalError("Generic Error - Unexpected")
    }
}

class DefaultJSONDecoder<IN, OUT: Decodable>: GenericDecoder<IN, OUT> {
    public override class func decode(json inObject: IN) -> OUT? {
        return try? JSONDecoder().decode(OUT.self, from: JSONSerialization.data(withJSONObject: inObject, options: .prettyPrinted))
    }
}

enum TypeOfConversion {
    case DisplayDate
    case DisplayTime
    case Server
    case Sorting
}

func convertDate(date:String, type: TypeOfConversion) -> String {
    var time: String = ""
    let defaultDateFormat: String = "yyyy-MM-dd HH:mm:ss"
    let defaultFormatter = DateFormatter()
    defaultFormatter.dateFormat = defaultDateFormat
    let defaultFormattedDate = defaultFormatter.date(from: date)
  
    switch type {
    case .Sorting:
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "dd/MMM"
        time = formatter2.string(from: defaultFormattedDate!)
    case .DisplayTime:
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm aa"
        time =  dateFormatter.string(from: currentDate)
    case .Server:
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "dd-MMM, YYYY hh:mm aa"
        time = formatter2.string(from: defaultFormattedDate!)
    case .DisplayDate:
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "dd/MMM"
        time = formatter2.string(from: defaultFormattedDate!)
    }
    
    return time
}

class SafeDecoder {
    static func decodedValue<Value: Decodable, K: CodingKey>(container: KeyedDecodingContainer<K>,
                                                             forKey key: KeyedDecodingContainer<K>.Key) -> Value? {
        var decodedValue: Value?
        do {
            decodedValue = try container.decodeIfPresent(Value.self, forKey: key)
        } catch {
        }
        return decodedValue
    }
}
