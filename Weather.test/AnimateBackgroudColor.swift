//
//  AnimateBackgroudGradient.swift
//  Weather.test
//
//  Created by Ковалева on 25.11.17.
//  Copyright © 2017 Ковалев. All rights reserved.
//

import Foundation
import UIKit

class Animate
{
    func backgroundColor(of view: GradientView) {
        var colorsArray: [(color1: UIColor, color2: UIColor)] = []
        var currentColorsArrayIndex = -1
        
        colorsArray.append((color1: Color.orange, color2: Color.orangeLight))
        colorsArray.append((color1: Color.orangeLight, color2: Color.mintGreen))
        colorsArray.append((color1: Color.mintGreen, color2: Color.malachiteGreen))
        colorsArray.append((color1: Color.malachiteGreen, color2: Color.pacificBlue))
        colorsArray.append((color1: Color.pacificBlue, color2: Color.powderBlue))
        colorsArray.append((color1: Color.powderBlue, color2: Color.violet))
        colorsArray.append((color1: Color.violet, color2: Color.orchid))
        colorsArray.append((color1: Color.orchid, color2: Color.orange))
        
        currentColorsArrayIndex = currentColorsArrayIndex == (colorsArray.count - 1) ? 0 : currentColorsArrayIndex + 1
        
        UIView.transition(with: view, duration: 2, options: [.transitionCrossDissolve], animations: {
            view.firstColor = colorsArray[currentColorsArrayIndex].color1
            view.secondColor = colorsArray[currentColorsArrayIndex].color2
        }) { (success) in
            self.backgroundColor(of: view)
        }
    }
    
    
}
