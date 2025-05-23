//
//  DesignSystem.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/6/25.
//

import UIKit

enum DesignSystem {
    enum Color {
        enum Tint : String {
            case main = "334155"
            case submain = "8E99A8"
            
            func inUIColor() -> UIColor {
                return UIColor(hex: self.rawValue)
            }
        }
        
        enum Background : String {
            case main = "FFFFFF"
            case segment = "EFF2F5"
            
            func inUIColor() -> UIColor {
                return UIColor(hex: self.rawValue)
            }
        }
        
        enum Renewal : String {
            case tint = "8B5CF6"
            case subTint = "D8B4FE"
            
            case mainText = "1E1B2E"
            case subText = "2A253C"
            
            func inUIColor() -> UIColor {
                return UIColor(hex: self.rawValue)
            }
            
        }
        
        enum InfoDeliver : String {
            case positive = "F04452"
            case negative = "3182F6"
            
            func inUIColor() -> UIColor {
                return UIColor(hex: self.rawValue)
            }
        }
    }
    
    enum Icon {
        enum Info : String {
            case back = "arrow.left"
            case coinAndNft = "chart.bar.fill"
            case exchange = "chart.line.uptrend.xyaxis"
            
            func toUIImage() -> UIImage {
                return UIImage(systemName: self.rawValue)!
            }
        }
        
        enum Input : String {
            case search = "magnifyingglass"
            case detail = "chevron.right"
            case star = "book"
            case ascendent = "arrowtriangle.up"
            case descendent = "arrowtriangle.down"
            
            func toUIImage() -> UIImage {
                return UIImage(systemName: self.rawValue)!
            }
            
            func fill() -> UIImage {
                switch self {
                case .ascendent, .descendent, .star :
                    return UIImage(systemName: "\(self.rawValue).fill")!
                    
                case .search, .detail:
                    return toUIImage()
                }
            }
        }
    }
}



