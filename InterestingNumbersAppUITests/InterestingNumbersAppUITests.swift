

import XCTest

class InterestingNumbersAppUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false

    }
    
    func testGameStyleSwitch() throws {
        
        app.buttons["Random number"].tap()
        
        let app2 = app
        app2?/*@START_MENU_TOKEN@*/.staticTexts["Number in a range"]/*[[".buttons[\"Number in a range\"].staticTexts[\"Number in a range\"]",".staticTexts[\"Number in a range\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app2?/*@START_MENU_TOKEN@*/.staticTexts["Multiple numbers"]/*[[".buttons[\"Multiple numbers\"].staticTexts[\"Multiple numbers\"]",".staticTexts[\"Multiple numbers\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app2?/*@START_MENU_TOKEN@*/.staticTexts["User  number"]/*[[".buttons[\"User  number\"].staticTexts[\"User  number\"]",".staticTexts[\"User  number\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let displayFactStaticText = app2?/*@START_MENU_TOKEN@*/.staticTexts["Display Fact"]/*[[".buttons[\"Display Fact\"].staticTexts[\"Display Fact\"]",".staticTexts[\"Display Fact\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        displayFactStaticText?.tap()
        
        let closeButton = app.buttons["close"]
        closeButton.tap()
        
        let exADate420OrANumber42TextField = app.textFields["ex: a date(4/20) or a number(42)"]
        exADate420OrANumber42TextField.tap()
        exADate420OrANumber42TextField.tap()
        displayFactStaticText?.tap()
        closeButton.tap()
      
    }
}
