// Styles.swift

import SwiftUI

// Dimensions
struct Dims {
    static let hero: CGFloat = 230
    static let bookNow: CGFloat = 50
    static let search: CGFloat = 50
    static let imWidth: CGFloat = hero * 0.5
    static let imHeight: CGFloat = hero * 0.5
    static let heroSearch: CGFloat = 60
    static let header: CGFloat = 50
}

struct MainColors {
    static let green = "#495E57"
    static let yellow = "#F4CE14"
}

struct SecondaryColors {
    static let orange = "#EE9972"
    static let peach = "#FBDABB"
    static let lightGrey = "#EDEFEE"
    static let black = "#333333"
}

let llGreen = Color(hex: MainColors.green)
let llYellow = Color(hex: MainColors.yellow)
let llWhite = Color(hex: SecondaryColors.lightGrey)
let llBlack = Color(hex: SecondaryColors.black)
let llOrange = Color(hex: SecondaryColors.orange)
let llPeach = Color(hex: SecondaryColors.peach)

let backgroundMainColor = Color.white
let reservationBackgroundColor = llWhite

struct llFonts {
    /* Note that font names are not necessarily and often not
     equal to the font file names. Write them down when you
     download the font */
    static let titleFont = "Markazi Text Regular"
    /* Markazi font names
        Markazi Text Regular
        Markazi Text Medium
        Markazi Text SemiBold
        Markazi Text Bold */
    
    static let textFont = "Karla"
    // use .fontWeight to set weight
    
    static let displaySize: CGFloat = 64
    static let subtitleSize: CGFloat = 40
    static let subtitleSize2: CGFloat = 24
    static let sectionSize: CGFloat = 20
    static let cardSize: CGFloat = 18
    static let specialsSize: CGFloat = 16
    static let regularSize: CGFloat = 16
}



extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")

        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}


