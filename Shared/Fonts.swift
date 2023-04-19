//
//  SwiftUIView.swift
//  
//
//  Created by Wahyu Alfandi on 14/04/23.
//


import SwiftUI

struct Caveat{
    public var fontNameRegular : String = "Caveat-Regular"
    public var fontNameBold : String = "Caveat-Bold"
    private var cfURL : CFURL
    public var bodyRegular: Font?
    public var bodyRegular2: Font?
    public var bodyRegular3: Font?
    public var bodyBold: Font?
    public var bodyBold2: Font?
    public var bodyBold3: Font?
    public var captionRegular: Font?
    public var captionBold: Font?
    
    
    init(){
        cfURL = Bundle.main.url(forResource: fontNameRegular, withExtension: "ttf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        
        
        //initializee
        bodyRegular = getFont(size: 16, fontName: fontNameRegular)
        captionRegular = getFont(size: 14, fontName: fontNameRegular)
        
        cfURL = Bundle.main.url(forResource: fontNameBold, withExtension: "ttf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        
        
        bodyBold = getFont(size: 16, fontName: fontNameBold)
        bodyBold2 = getFont(size: 18, fontName: fontNameBold)
        bodyBold3 = getFont(size: 20, fontName: fontNameBold)
        
        bodyRegular = getFont(size: 16, fontName: fontNameRegular)
        bodyRegular2 = getFont(size: 18, fontName: fontNameRegular)
        bodyRegular3 = getFont(size: 20, fontName: fontNameRegular)
        captionRegular = getFont(size: 14, fontName: fontNameRegular)
    }
    
    func getFont(size : CGFloat, fontName: String) -> Font{
        let uiFont = UIFont(name: fontName, size: size)
        
        return Font(uiFont ?? UIFont())
    }
}

let caveat = Caveat()
