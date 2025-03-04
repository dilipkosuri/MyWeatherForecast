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
    //formatter2.dateFormat = "dd-MMM, YYYY hh:mm aa"
    formatter2.dateFormat = "dd-MMM"
    time = formatter2.string(from: defaultFormattedDate!)
  case .DisplayDate:
    let formatter2 = DateFormatter()
    formatter2.dateFormat = "dd/MMM"
    time = formatter2.string(from: defaultFormattedDate!)
  }
  
  return time
}


func getFahrenheit(valueInKelvin: Double?) -> Double {
  if let kelvin = valueInKelvin {
    return ((kelvin - 273.15) * 1.8) + 32
  } else {
    return 0
  }
}

func getCelsius(valueInKelvin: Double?) -> Double {
  if let kelvin = valueInKelvin {
    return kelvin - 273.15
  } else {
    return 0
  }
}

func getTemperatureConverted(temperature: Double) -> Double {
  if Constants.defaultTemperatureMetric != Constants.defaultTemperatureMetric {
    if Constants.defaultTemperatureMetric == "celcius" {
      return getCelsius(valueInKelvin: temperature).rounded(toPlaces: 2)
    } else if Constants.defaultTemperatureMetric == "fahrenheit" {
      return getFahrenheit(valueInKelvin: temperature).rounded(toPlaces: 2)
    }
  }
  return temperature.rounded(toPlaces: 2)
}

func timeOfDataCalculation(dateInMillis: Double = 0) -> String {
  //let date = Date(timeIntervalSince1970: dateInMillis)
  
  //let defaultFormattedDate = DateFormatter().date(from: "\(date)")
  let dateVar = Date.init(timeIntervalSinceNow: TimeInterval(dateInMillis)/1000)
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "dd MMM, hh:mm aa"
  print(dateFormatter.string(from: dateVar))
  return dateFormatter.string(from: dateVar)
}

func returnDateFormat(dateInMillis: Double = 0) -> String {
  //let date = Date(timeIntervalSince1970: dateInMillis)
  
  //let defaultFormattedDate = DateFormatter().date(from: "\(date)")
  let dateVar = Date.init(timeIntervalSinceNow: TimeInterval(dateInMillis)/1000)
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "dd MMM"
  print(dateFormatter.string(from: dateVar))
  return dateFormatter.string(from: dateVar)
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
