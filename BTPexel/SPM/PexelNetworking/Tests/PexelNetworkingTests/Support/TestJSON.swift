//
//  File.swift
//  PexelNetworking
//
//  Created by Ilia Baudin on 17.09.2025.
//

import Foundation

enum TestJSON {
    static let curatedOk2Photos = """
    {
      "page": 1,
      "per_page": 30,
      "photos": [
        {
          "id": 1001,
          "url": "https://pexels.com/p1",
          "photographer": "Alice",
          "alt": "A photo",
          "src": {
            "original": "o1",
            "large2x": "l1",
            "large": "L1",
            "medium": "m1"
          }
        },
        {
          "id": 1002.5,
          "url": "https://pexels.com/p2",
          "photographer": "Bob",
          "alt": "B photo",
          "src": {
            "original": "o2",
            "large2x": "",
            "large": "L2",
            "medium": "m2"
          }
        }
      ]
    }
    """.data(
        using: .utf8
    )!

    static let curatedEmpty = """
    { "page": 1, "per_page": 30, "photos": [] }
    """.data(
        using: .utf8
    )!

    static let malformed = "{ not json }".data(
        using: .utf8
    )!
}
