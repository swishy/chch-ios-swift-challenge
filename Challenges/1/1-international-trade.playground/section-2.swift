import Cocoa

class Transaction {
    let store: String
    let sku: String
    let amount: NSDecimalNumber
    let currency: String
    init(store: String, sku: String, amount: NSDecimalNumber, currency: String) {
        self.store = store
        self.sku = sku
        self.amount = amount
        self.currency = currency
    }
}

class Rate {
    let fromCurrency: String
    let toCurrency: String
    let conversion: Double
    
    init(fromCurrency: String, toCurrency: String, conversion: NSDecimalNumber){
        self.fromCurrency = fromCurrency
        self.toCurrency = toCurrency
        self.conversion = conversion
    }
}

let bundle = NSBundle.mainBundle()

let transPath = bundle.pathForResource("SAMPLE_TRANS", ofType: "csv")
let csvString = String.stringWithContentsOfFile(transPath, encoding: NSUTF8StringEncoding, error: nil)!

let csvLines = csvString.componentsSeparatedByString("\n")
let cvsRows = csvLines[1..<csvLines.count-1]

var transactions = Array<Transaction>()
for line in cvsRows {
    let values = line.componentsSeparatedByString(",")
    let currencyAmount = values[2].componentsSeparatedByString(" ")
    let transaction = Transaction(store: values[0], sku: values[1], amount: NSDecimalNumber(string: currencyAmount[0]), currency: currencyAmount[1])
    transactions.append(transaction)
}
transactions

let ratesPath = bundle.pathForResource("SAMPLE_RATES", ofType: "xml")
let xmlString = String.stringWithContentsOfFile(ratesPath, encoding: NSUTF8StringEncoding, error: nil)
