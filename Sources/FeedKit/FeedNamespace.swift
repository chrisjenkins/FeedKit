//
//  FeedNamespace.swift
//
//  Copyright (c) 2016 - 2024 Nuno Dias
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Foundation

/// Represents various feed namespaces used in syndication feeds.
///
/// The `FeedNamespace` enum defines different namespaces that are commonly used
/// in syndication feeds (e.g., RSS, Atom) to represent metadata and extensions.
/// Each case corresponds to a specific namespace that can be used in feed parsing
/// and handling. These namespaces provide additional information and functionality
/// for feeds beyond the core elements.
enum FeedNamespace: CaseIterable {
  /// Represents the Dublin Core metadata terms used for describing
  /// resources in a standardized way.
  case dublinCore
  /// Represents the iTunes namespace, typically used in podcasts and
  /// media feeds.
  case itunes
  /// Represents the syndication namespace, used for feed metadata
  /// related to syndication functionality.
  case syndication
  /// Represents the media namespace, used for media-related content
  /// (e.g., images, audio, and video) in feeds.
  case media
  /// Represents the content namespace, used for providing additional
  /// content metadata.
  case content
  /// Represents the GeoRSS namespace, used for geographic data in feeds.
  case georss
  /// Represents the Geography Markup Language (GML) namespace, used
  /// for encoding geographic information.
  case gml
  /// Represents the YouTube namespace, used for YouTube-specific metadata
  /// in video feeds.
  case youTube
  /// Represents the Atom feed namespace, typically used for syndication
  /// in the Atom format.
  case atom

  /// The namespace prefix.
  var prefix: String {
    switch self {
    case .dublinCore:
      return "xmlns:dc"
    case .itunes:
      return "xmlns:itunes"
    case .syndication:
      return "xmlns:sy"
    case .media:
      return "xmlns:media"
    case .content:
      return "xmlns:content"
    case .georss:
      return "xmlns:georss"
    case .gml:
      return "xmlns:gml"
    case .youTube:
      return "xmlns:yt"
    case .atom:
      return "xmlns:atom"
    }
  }

  /// The URL associated with the namespace.
  var url: String {
    switch self {
    case .dublinCore:
      return "http://purl.org/dc/elements/1.1/"
    case .itunes:
      return "http://www.itunes.com/dtds/podcast-1.0.dtd"
    case .syndication:
      return "http://purl.org/rss/1.0/modules/syndication/"
    case .media:
      return "http://search.yahoo.com/mrss/"
    case .content:
      return "http://purl.org/rss/1.0/modules/content/"
    case .georss:
      return "http://www.georss.org/georss"
    case .gml:
      return "http://www.opengis.net/gml"
    case .youTube:
      return "http://www.youtube.com/xml/schemas/2015"
    case .atom:
      return "http://www.w3.org/2005/Atom"
    }
  }
}

// MARK: - Should Include in Feed

extension FeedNamespace {
  /// Determines whether the namespace should be included in an XML document.
  /// - Parameter feed: The RSS feed being converted.
  /// - Returns: A Boolean indicating whether the namespace should be included.
  func shouldInclude(in feed: RSSFeed) -> Bool {
    switch self {
    case .dublinCore:
      return
        feed.channel?.dublinCore != nil ||
        feed.channel?.items?.contains(where: { $0.dublinCore != nil }) ?? false
    case .itunes:
      return
        feed.channel?.iTunes != nil ||
        feed.channel?.items?.contains(where: { $0.iTunes != nil }) ?? false
    case .syndication:
      return feed.channel?.syndication != nil
    case .media:
      return feed.channel?.items?.contains(where: { $0.media != nil }) ?? false
    case .content:
      return feed.channel?.items?.contains(where: { $0.content != nil }) ?? false
    case .georss:
      return feed.channel?.items?.contains(where: { $0.media?.location?.geoRSS != nil }) ?? false
    case .gml:
      return feed.channel?.items?.contains(where: { $0.media?.location?.geoRSS?.gmlPoint != nil }) ?? false
    case .youTube:
      return false
    case .atom:
      return feed.channel?.atom != nil
    }
  }

  /// Determines whether the namespace should be included in an XML document.
  /// - Parameter feed: The RSS feed being converted.
  /// - Returns: A Boolean indicating whether the namespace should be included.
  func shouldInclude(in feed: AtomFeed) -> Bool {
    switch self {
    case .youTube:
      return feed.entries?.contains(where: { $0.youTube != nil }) ?? false
    default:
      return false
    }
  }
}
