import Cocoa
import Foundation

public class RateParser : NSObject , NSXMLParserDelegate
{
    var parser: NSXMLParser
    
    var rates: [Rate]
    
    var currentRate : Rate
    
    var currentElement : String
    
    var foo : (rates: [Rate]) -> ()
    
    init(data: NSData, callback: (rates: [Rate]) -> ())
    {
        parser = NSXMLParser(data: data)
        rates = Array()
        currentRate = Rate()
        currentElement = ""
        foo = callback
        super.init()
        parser.delegate = self
    }
    
    func startParsing()
    {
        parser.parse()
    }
    
    public func parserDidStartDocument(parser: NSXMLParser!) {
        println("Start Doc called")
    }
    
    public func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]!) {
        if (elementName == "rate")
        {
            currentRate = Rate()
        }
        
        currentElement = elementName
    
    }
    
    public func parser(parser: NSXMLParser!, foundCharacters string: String!) {
        if(currentElement == "from")
        {
            currentRate.from = string
        } else if (currentElement == "to"){
            currentRate.to = string
        } else if (currentElement == "conversion") {
            currentRate.conversion = (string as NSString).floatValue
        }
    }
    
    public func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!) {
        if ( elementName == "rate")
        {
            rates.append(currentRate)
        }
        
        // Reset current element
        currentElement = ""
    }
    
    public func parserDidEndDocument(parser: NSXMLParser!) {
        foo(rates: rates)
    }
}

public class Rate : NSObject
{
    var from : String = String()
    var to : String = String()
    var conversion : Float = 0.0
}


let bundle = NSBundle.mainBundle()

let transPath = bundle.pathForResource("SAMPLE_TRANS", ofType: "csv")

let xmlPath = bundle.pathForResource("SAMPLE_RATES", ofType: "xml")

let data = NSData.dataWithContentsOfFile(xmlPath, options: nil, error: nil)
data.length

var parser = RateParser(data: data) { rates in
    for blag in rates
    {
        println(blag.from)
        println(blag.to)
        println(blag.conversion)
    }
}
parser.startParsing()










