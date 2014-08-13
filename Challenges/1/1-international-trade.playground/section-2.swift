import Foundation

let bundle = NSBundle.mainBundle()

let transactionsPath = bundle.pathForResource("SAMPLE_TRANS", ofType: "csv")



struct Rate {
    var from: String = "",
        to: String = "",
        conversionRate: NSDecimalNumber = NSDecimalNumber()
}

class Rates : NSXMLParser, NSXMLParserDelegate {
    var rates: [Rate]

    var currentElement: String?,
        currentRate: Rate?

    init(fileName: String) {
        rates = Array()

        var error: NSError?;
        var data = NSData(contentsOfFile: fileName,
                                 options: .DataReadingMappedIfSafe,
                                   error: &error)

        super.init(data: data)

        self.delegate = self;
        self.parse()
    }

    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName: String!, attributes: [NSObject : AnyObject]!) {
        currentElement = elementName

        if elementName == "rate" {
            currentRate = Rate()
        }
    }

    func parser(parser: NSXMLParser!, foundCharacters string: String!) {
        if let element = currentElement {
            switch element {
                case "from":
                    currentRate!.from = string
                case "to":
                    currentRate!.to = string
                case "conversion":
                    currentRate!.conversionRate = NSDecimalNumber(string: string)
                default:
                    break
            }
        }
    }

    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName: String!) {
        currentElement = nil
        if elementName == "rate" {
            rates.append(currentRate!)
        }
    }
}

let ratesPath = bundle.pathForResource("RATES", ofType: "xml")
let rates = Rates(fileName: ratesPath)
rates.rates























