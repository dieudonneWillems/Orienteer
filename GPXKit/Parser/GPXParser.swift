//
//  GPXParser.swift
//  GPXKit
//
//  Created by Don Willems on 15/12/2017.
//  Copyright © 2017 lapsedpacifist. All rights reserved.
//

import Cocoa

public class GPXParser: NSObject, XMLParserDelegate {
    
    private let GPXNamespace = "http://www.topografix.com/GPX/1/1"
    
    public let fileURL : URL
    public var delegate : GPXParserDelegate?
    public var extensionParsers = [GPXExtensionParser]()
    
    private let parser : XMLParser?
    private var result: GPSData?
    
    private var root : GPXElement?
    private var currentParentElement : GPXElement?
    private var dateTimeFormatter = DateFormatter()
    
    public init?(contentsOf file: URL) {
        self.fileURL = file
        parser = XMLParser(contentsOf: fileURL)
        if parser == nil {
            return nil
        }
        super.init()
        parser!.shouldProcessNamespaces = true
        parser!.delegate = self
        dateTimeFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    }
    
    public func parse() {
        parser!.parse()
    }
    
    private func parseRoot() {
        if root != nil && root!.elementName == "gpx" && root!.namespaceURI == GPXNamespace {
            result = GPSData()
            result!.creator = root!.attributes["creator"]
            for child in root!.children {
                if (child as? GPXElement) != nil {
                    let childELement = child as! GPXElement
                    if childELement.elementName == "metadata" && childELement.namespaceURI == GPXNamespace {
                        let metadata = self.metadata(fromElement: childELement)
                        result?.metadata = metadata
                    } else if childELement.elementName == "wpt" && childELement.namespaceURI == GPXNamespace {
                        let waypoint = self.waypoint(fromElement: childELement)
                        if waypoint != nil {
                            result?.wayPoints.append(waypoint!)
                        }
                    } else if childELement.elementName == "rte" && childELement.namespaceURI == GPXNamespace {
                        let route = self.route(fromElement: childELement)
                        if route != nil {
                            result?.routes.append(route!)
                        }
                    } else if childELement.elementName == "trk" && childELement.namespaceURI == GPXNamespace {
                        let track = self.track(fromElement: childELement)
                        if track != nil {
                            result?.tracks.append(track!)
                        }
                    } else if childELement.elementName == "extensions" && childELement.namespaceURI == GPXNamespace {
                        let extensions = self.extensions(fromElement: childELement)
                        result?.extensions = extensions
                    }
                }
            }
        } else {
            self.parser(parser!, parseErrorOccurred: GPXParserError.notAGPXFile)
        }
    }
    
    private func metadata(fromElement element: GPXElement) -> Metadata? {
        var metadata = Metadata()
        for child in element.children {
            if (child as? GPXElement) != nil {
                let childELement = child as! GPXElement
                if childELement.elementName == "name" && childELement.namespaceURI == GPXNamespace {
                    metadata.name = childELement.textContent
                } else if childELement.elementName == "desc" && childELement.namespaceURI == GPXNamespace {
                    metadata.fileDescription = childELement.textContent
                } else if childELement.elementName == "author" && childELement.namespaceURI == GPXNamespace {
                    let author = self.person(fromElement: childELement)
                    metadata.author = author
                } else if childELement.elementName == "copyright" && childELement.namespaceURI == GPXNamespace {
                    let copyright = self.copyright(fromElement: childELement)
                    metadata.copyright = copyright
                } else if childELement.elementName == "link" && childELement.namespaceURI == GPXNamespace {
                    let link = self.link(fromElement: childELement)
                    if link != nil {
                        metadata.links.append(link!)
                    }
                } else if childELement.elementName == "time" && childELement.namespaceURI == GPXNamespace {
                    let tc = childELement.textContent
                    if tc != nil {
                        metadata.creationDate = dateTimeFormatter.date(from: tc!)
                    }
                } else if childELement.elementName == "keywords" && childELement.namespaceURI == GPXNamespace {
                    let keywords = childELement.textContent?.split(separator: ",")
                    if keywords != nil {
                        for keyword in keywords! {
                            metadata.keywords.append(keyword.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
                        }
                    }
                } else if childELement.elementName == "bounds" && childELement.namespaceURI == GPXNamespace {
                    let bounds = self.bounds(fromElement: childELement)
                    metadata.bounds = bounds
                } else if childELement.elementName == "extensions" && childELement.namespaceURI == GPXNamespace {
                    let extensions = self.extensions(fromElement: childELement)
                    metadata.extensions = extensions
                }
            }
        }
        return metadata
    }
    
    private func waypoint(fromElement element: GPXElement) -> WayPoint? {
        let lat = element.attributes["lat"]
        let lon = element.attributes["lon"]
        if lat != nil && lon != nil {
            let latitude = Double(lat!)
            let longitude = Double(lon!)
            if latitude != nil && longitude != nil {
                var waypoint = WayPoint(withLongitude: longitude!, andLatitude: latitude!)
                for child in element.children {
                    if (child as? GPXElement) != nil {
                        let childELement = child as! GPXElement
                        if childELement.elementName == "name" && childELement.namespaceURI == GPXNamespace {
                            waypoint.name = childELement.textContent
                        } else if childELement.elementName == "cmt" && childELement.namespaceURI == GPXNamespace {
                            waypoint.comment = childELement.textContent
                        } else if childELement.elementName == "desc" && childELement.namespaceURI == GPXNamespace {
                            waypoint.wayPointDescription = childELement.textContent
                        } else if childELement.elementName == "src" && childELement.namespaceURI == GPXNamespace {
                            waypoint.source = childELement.textContent
                        } else if childELement.elementName == "time" && childELement.namespaceURI == GPXNamespace {
                            let tc = childELement.textContent
                            if tc != nil {
                                waypoint.time = dateTimeFormatter.date(from: tc!)
                            }
                        } else if childELement.elementName == "ele" && childELement.namespaceURI == GPXNamespace {
                            let elestr = childELement.textContent
                            if elestr != nil {
                                let elevation = Double(elestr!)
                                waypoint.elevation = elevation
                            }
                        } else if childELement.elementName == "magvar" && childELement.namespaceURI == GPXNamespace {
                            let magvarstr = childELement.textContent
                            if magvarstr != nil {
                                let magneticvariation = Double(magvarstr!)
                                waypoint.magneticVariation = magneticvariation
                            }
                        } else if childELement.elementName == "geoidheight" && childELement.namespaceURI == GPXNamespace {
                            let geoidheightstr = childELement.textContent
                            if geoidheightstr != nil {
                                let geoidheight = Double(geoidheightstr!)
                                waypoint.geoidHeight = geoidheight
                            }
                        } else if childELement.elementName == "link" && childELement.namespaceURI == GPXNamespace {
                            let link = self.link(fromElement: childELement)
                            if link != nil {
                                waypoint.links.append(link!)
                            }
                        } else if childELement.elementName == "sym" && childELement.namespaceURI == GPXNamespace {
                            waypoint.symbol = childELement.textContent
                        } else if childELement.elementName == "type" && childELement.namespaceURI == GPXNamespace {
                            waypoint.type = childELement.textContent
                        } else if childELement.elementName == "fix" && childELement.namespaceURI == GPXNamespace {
                            let fixstr = childELement.textContent
                            if fixstr != nil {
                                if fixstr == "none" {
                                    waypoint.fix = FixType.none
                                } else if fixstr == "2d" {
                                    waypoint.fix = FixType.twoDimensional
                                } else if fixstr == "3d" {
                                    waypoint.fix = FixType.threeDimensional
                                } else if fixstr == "dgps" {
                                    waypoint.fix = FixType.differentialGlobalPositioning
                                } else if fixstr == "pps" {
                                    waypoint.fix = FixType.militarySignal
                                }
                            }
                        } else if childELement.elementName == "sat" && childELement.namespaceURI == GPXNamespace {
                            let satstr = childELement.textContent
                            if satstr != nil {
                                let sats = UInt(satstr!)
                                waypoint.numberOfSatellites = sats
                            }
                        } else if childELement.elementName == "hdop" && childELement.namespaceURI == GPXNamespace {
                            let hdopstr = childELement.textContent
                            if hdopstr != nil {
                                let hdop = Double(hdopstr!)
                                waypoint.horizontalDilutionOfPrecision = hdop
                            }
                        } else if childELement.elementName == "vdop" && childELement.namespaceURI == GPXNamespace {
                            let vdopstr = childELement.textContent
                            if vdopstr != nil {
                                let vdop = Double(vdopstr!)
                                waypoint.verticalDilutionOfPrecision = vdop
                            }
                        } else if childELement.elementName == "pdop" && childELement.namespaceURI == GPXNamespace {
                            let pdopstr = childELement.textContent
                            if pdopstr != nil {
                                let pdop = Double(pdopstr!)
                                waypoint.positionDilutionOfPrecision = pdop
                            }
                        } else if childELement.elementName == "ageofdgpsdata" && childELement.namespaceURI == GPXNamespace {
                            let ageofdgpsdatastr = childELement.textContent
                            if ageofdgpsdatastr != nil {
                                let ageofdgpsdata = Double(ageofdgpsdatastr!)
                                waypoint.numberOfSecondsSinceLastDGPSUpdate = ageofdgpsdata
                            }
                        } else if childELement.elementName == "dgpsid" && childELement.namespaceURI == GPXNamespace {
                            let dgpsidstr = childELement.textContent
                            if dgpsidstr != nil {
                                let dgpsid = UInt(dgpsidstr!)
                                waypoint.DGPSStationID = dgpsid
                            }
                        } else if childELement.elementName == "extensions" && childELement.namespaceURI == GPXNamespace {
                            let extensions = self.extensions(fromElement: childELement)
                            waypoint.extensions = extensions
                        }
                    }
                }
                return waypoint
            }
        }
        return nil
    }
    
    private func route(fromElement element: GPXElement) -> Route? {
        var route = Route()
        for child in element.children {
            if (child as? GPXElement) != nil {
                let childELement = child as! GPXElement
                if childELement.elementName == "name" && childELement.namespaceURI == GPXNamespace {
                    route.name = childELement.textContent
                } else if childELement.elementName == "cmt" && childELement.namespaceURI == GPXNamespace {
                    route.comment = childELement.textContent
                } else if childELement.elementName == "desc" && childELement.namespaceURI == GPXNamespace {
                    route.routeDescription = childELement.textContent
                } else if childELement.elementName == "src" && childELement.namespaceURI == GPXNamespace {
                    route.source = childELement.textContent
                } else if childELement.elementName == "link" && childELement.namespaceURI == GPXNamespace {
                    let link = self.link(fromElement: childELement)
                    if link != nil {
                        route.links.append(link!)
                    }
                } else if childELement.elementName == "number" && childELement.namespaceURI == GPXNamespace {
                    let numberstr = childELement.textContent
                    if numberstr != nil {
                        let number = UInt(numberstr!)
                        route.routeNumber = number
                    }
                } else if childELement.elementName == "type" && childELement.namespaceURI == GPXNamespace {
                    route.type = childELement.textContent
                } else if childELement.elementName == "extensions" && childELement.namespaceURI == GPXNamespace {
                    let extensions = self.extensions(fromElement: childELement)
                    route.extensions = extensions
                } else if childELement.elementName == "rtept" && childELement.namespaceURI == GPXNamespace {
                    let waypoint = self.waypoint(fromElement: childELement)
                    if waypoint != nil {
                        route.routePoints.append(waypoint!)
                    }
                }
            }
        }
        return route
    }
    
    private func track(fromElement element: GPXElement) -> Track? {
        var track = Track()
        for child in element.children {
            if (child as? GPXElement) != nil {
                let childELement = child as! GPXElement
                if childELement.elementName == "name" && childELement.namespaceURI == GPXNamespace {
                    track.name = childELement.textContent
                } else if childELement.elementName == "cmt" && childELement.namespaceURI == GPXNamespace {
                    track.comment = childELement.textContent
                } else if childELement.elementName == "desc" && childELement.namespaceURI == GPXNamespace {
                    track.trackDescription = childELement.textContent
                } else if childELement.elementName == "src" && childELement.namespaceURI == GPXNamespace {
                    track.source = childELement.textContent
                } else if childELement.elementName == "link" && childELement.namespaceURI == GPXNamespace {
                    let link = self.link(fromElement: childELement)
                    if link != nil {
                        track.links.append(link!)
                    }
                } else if childELement.elementName == "number" && childELement.namespaceURI == GPXNamespace {
                    let numberstr = childELement.textContent
                    if numberstr != nil {
                        let number = UInt(numberstr!)
                        track.trackNumber = number
                    }
                } else if childELement.elementName == "type" && childELement.namespaceURI == GPXNamespace {
                    track.type = childELement.textContent
                } else if childELement.elementName == "extensions" && childELement.namespaceURI == GPXNamespace {
                    let extensions = self.extensions(fromElement: childELement)
                    track.extensions = extensions
                } else if childELement.elementName == "trkseg" && childELement.namespaceURI == GPXNamespace {
                    let segment = self.segment(fromElement: childELement)
                    if segment != nil {
                        track.appendSegment(segment!)
                    }
                }
            }
        }
        return track
    }
    
    
    private func segment(fromElement element: GPXElement) -> Segment? {
        var segment = Segment()
        for child in element.children {
            if (child as? GPXElement) != nil {
                let childELement = child as! GPXElement
                if childELement.elementName == "extensions" && childELement.namespaceURI == GPXNamespace {
                    let extensions = self.extensions(fromElement: childELement)
                    segment.extensions = extensions
                } else if childELement.elementName == "trkpt" && childELement.namespaceURI == GPXNamespace {
                    let waypoint = self.waypoint(fromElement: childELement)
                    if waypoint != nil {
                        segment.appendTrackPoint(waypoint!)
                    }
                }
            }
        }
        return segment
    }
    
    
    private func person(fromElement element: GPXElement) -> Person? {
        var person = Person()
        for child in element.children {
            if (child as? GPXElement) != nil {
                let childELement = child as! GPXElement
                if childELement.elementName == "name" && childELement.namespaceURI == GPXNamespace {
                    person.name = childELement.textContent
                } else if childELement.elementName == "email" && childELement.namespaceURI == GPXNamespace {
                    person.email = childELement.textContent
                } else if childELement.elementName == "link" && childELement.namespaceURI == GPXNamespace {
                    let link = self.link(fromElement: childELement)
                    person.link = link
                }
            }
        }
        return person
    }
    
    private func link(fromElement element: GPXElement) -> Link? {
        let urlstr = element.attributes["href"]
        if urlstr != nil {
            let url = URL(string: urlstr!)
            if url != nil {
                var link = Link(withURL: url!)
                for child in element.children {
                    if (child as? GPXElement) != nil {
                        let childELement = child as! GPXElement
                        if childELement.elementName == "text" && childELement.namespaceURI == GPXNamespace {
                            link.text = childELement.textContent
                        } else if childELement.elementName == "type" && childELement.namespaceURI == GPXNamespace {
                            link.mimeType = childELement.textContent
                        }
                    }
                }
                return link
            }
        }
        return nil
    }
    
    private func copyright(fromElement element: GPXElement) -> Copyright? {
        let author = element.attributes["author"]
        if author != nil {
            var copyright = Copyright(withAuthor: author!)
            for child in element.children {
                if (child as? GPXElement) != nil {
                    let childELement = child as! GPXElement
                    if childELement.elementName == "year" && childELement.namespaceURI == GPXNamespace {
                        let yearstr = childELement.textContent
                        if yearstr != nil {
                            let year = Int(childELement.textContent!)
                            copyright.year = year
                        }
                    } else if childELement.elementName == "license" && childELement.namespaceURI == GPXNamespace {
                        copyright.license = childELement.textContent
                    }
                }
            }
            return copyright
        }
        return nil
    }
    
    private func bounds(fromElement element: GPXElement) -> Bounds? {
        let minlat = element.attributes["minlat"]
        let minlon = element.attributes["minlat"]
        let maxlat = element.attributes["minlat"]
        let maxlon = element.attributes["minlat"]
        if minlat != nil && minlon != nil && maxlat != nil && maxlon != nil {
            let minlatitude = Double(minlat!)
            let minlongitude = Double(minlon!)
            let maxlatitude = Double(maxlat!)
            let maxlongitude = Double(maxlon!)
            if minlatitude != nil && minlongitude != nil && maxlatitude != nil && maxlongitude != nil {
                let bounds = Bounds(minimumLatitude: minlatitude!, maximumLatitude: maxlatitude!, minimumLongitude: minlongitude!, maximumLongitude: maxlongitude!)
                return bounds
            }
        }
        return nil
    }
    
    private func extensions(fromElement element: GPXElement) -> [Extension] {
        var extensions = [Extension]()
        
        // TODO: parse extensions
        
        return extensions
    }
    
    public func parserDidStartDocument(_ parser: XMLParser) {
        delegate?.parserDidStartGPXDocument(self)
    }
    
    public func parserDidEndDocument(_ parser: XMLParser) {
        parseRoot()
        delegate?.parser(self, finishedParsingDocumentWithResult: result)
    }
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if root == nil {
            root = GPXElement(elementName: elementName, namespaceURI: namespaceURI, attributes: attributeDict)
            currentParentElement = root
        } else {
            let newElement = GPXElement(elementName: elementName, namespaceURI: namespaceURI, attributes: attributeDict)
            currentParentElement?.children.append(newElement)
            newElement.parent = currentParentElement
            currentParentElement = newElement
        }
    }
    
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
        if currentParentElement?.elementName == elementName && currentParentElement?.namespaceURI == namespaceURI {
            currentParentElement = currentParentElement?.parent
        } else {
            self.parser(parser, parseErrorOccurred: GPXParserError.invalidClosingElement)
        }
    }
    
    public func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        delegate?.parser(self, encounteredError: parseError)
    }
    
    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        if string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count > 0 {
            currentParentElement?.children.append(string)
        }
    }
    
    public func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        currentParentElement?.children.append(CDATABlock)
    }
}

internal class GPXElement {
    let elementName : String
    let namespaceURI : String?
    let attributes : [String:String]
    
    var parent : GPXElement?
    var children = [Any]()
    
    var depth : Int {
        get {
            if parent != nil {
                return parent!.depth - 1
            }
            return 0
        }
    }
    
    var textContent : String? {
        get {
            var text = ""
            for child in children {
                if (child as? String) != nil {
                    text.append(child as! String)
                } else if (child as? GPXElement) != nil {
                    let tc = (child as! GPXElement).textContent
                    if tc != nil {
                        text.append(tc!)
                    }
                }
            }
            if text.count <= 0 {
                return nil
            }
            return text
        }
    }
    
    init(elementName: String, namespaceURI: String?, attributes : [String : String]) {
        self.elementName = elementName
        self.namespaceURI = namespaceURI
        self.attributes = attributes
    }

}

public enum GPXParserError: Error {
    case notAGPXFile
    case invalidChildElement
    case invalidClosingElement
}
