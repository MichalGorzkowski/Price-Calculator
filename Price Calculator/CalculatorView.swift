//
//  CalculatorView.swift
//  Price Calculator
//
//  Created by Michał Gorzkowski on 01/08/2023.
//

import SwiftUI

struct CalculatorView: View {
    
    // Buy price input
    @State var inputBuyPrice: String = ""
    @State var isVatIncludedBuyPrice: Bool = true
    
    // Sell price input
    @State var inputSellPrice: String = ""
    @State var isVatIncludedSellPrice: Bool = true
    
    // Commission Percent input
    @State var inputCommissionPercent: String = "8"
    
    // Large shipment input
    @State var isXXL: Bool = false
    
    
    // Prices without VAT
    var buyPrice: Double {
        guard let price = Double(inputBuyPrice.replacingOccurrences(of: ",", with: ".")) else { return 0 }
        return isVatIncludedBuyPrice ? round((price/1.23) * 100) / 100.0 : price
    }
    
    var sellPrice: Double {
        guard let price = Double(inputSellPrice.replacingOccurrences(of: ",", with: ".")) else { return 0 }
        return isVatIncludedSellPrice ? round((price/1.23) * 100) / 100.0 : price
    }
    
    var shippmentPrice: Double {
        var price: Double = 0.0
        
        switch sellPrice {
        case 40..<50:
            price = 2.09 / 1.23
        case 50..<60:
            price = 2.49 / 1.23
        case 60..<70:
            price = 2.79 / 1.23
        case 70..<80:
            price = 3.49 / 1.23
        case 80..<100:
            price = 4.99 / 1.23
        case 100..<150:
            price = 5.99 / 1.23
        case 150..<200:
            price = 6.99 / 1.23
        case 200..<300:
            price = 9.49 / 1.23
        case 300...:
            price = 10.99 / 1.23
        default:
            price = 0.0
        }
        
        return Double(round(price * 100) / 100.0)
    }
    
    // Commission price without VAT
    var commission: Double {
        guard let commission = Double(inputCommissionPercent) else { return 0 }
        return sellPrice * round((commission/100) * 100) / 100.0
    }
    
    var transaction: Double {
        let transaction = round((1.0) * 100) / 100
        return transaction
    }
    
    var calculation : Double {
        let buy = buyPrice
        let sell  = sellPrice
        let shippment = shippmentPrice
        let commission = commission
        
        var standardResult = sell - buy - shippment - commission
        
        return isXXL ? (standardResult - 4.06) : standardResult
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 20.0) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Buy price")
                            .font(.system(.footnote))
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        Text("VAT")
                            .font(.system(.footnote))
                            .foregroundColor(.gray)
                        
                        CheckBoxView(checked: $isVatIncludedBuyPrice)
                    }
                    
                    ZStack {
                        Rectangle()
                            .frame(width: .infinity, height: 50)
                            .cornerRadius(10)
                            .foregroundColor(Color(UIColor.lightGray))
                        
                        TextField("Price", text: $inputBuyPrice)
                            .foregroundColor(.black)
                            .padding(.horizontal)
                            .keyboardType(.decimalPad)
                    }
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Sell price")
                            .font(.system(.footnote))
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        Text("VAT")
                            .font(.system(.footnote))
                            .foregroundColor(.gray)
                        
                        CheckBoxView(checked: $isVatIncludedSellPrice)
                    }
                    
                    ZStack {
                        Rectangle()
                            .frame(width: .infinity, height: 50)
                            .cornerRadius(10)
                            .foregroundColor(Color(UIColor.lightGray))
                        
                        TextField("Price", text: $inputSellPrice)
                            .foregroundColor(.black)
                            .padding(.horizontal)
                            .keyboardType(.decimalPad)
                    }
                }
            }
            .padding()
            
            HStack(spacing: 20.0) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Shippment")
                            .font(.system(.footnote))
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        Text("with VAT")
                            .font(.system(.footnote))
                            .foregroundColor(.gray)
                        
                        //CheckBoxView(checked: $isVatIncludedShippmentPrice)
                    }
                    
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(width: .infinity, height: 50)
                            .cornerRadius(10)
                            .foregroundColor(Color(UIColor.lightGray))
                        
                        Text("\(shippmentPrice, specifier: "%.2f")")
                            .foregroundColor(.black)
                            .padding(.horizontal)
                    }
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Commission %")
                            .font(.system(.footnote))
                            .foregroundColor(.gray)
                    }
                    
                    ZStack {
                        Rectangle()
                            .frame(width: .infinity, height: 50)
                            .cornerRadius(10)
                            .foregroundColor(Color(UIColor.lightGray))
                        
                        TextField("Percent", text: $inputCommissionPercent)
                            .foregroundColor(.black)
                            .padding(.horizontal)
                            .keyboardType(.decimalPad)
                    }
                }
            }
            .padding()
            
            HStack {
                Text("XXL")
                    .font(.system(.footnote))
                .foregroundColor(.gray)
                
                CheckBoxView(checked: $isXXL)
            }
            .padding()
            
            
            VStack {
                Text("Commission Fee")
                Text("\(commission, specifier: "%.2f")")
            }
            .padding()
            
            VStack {
                Text("Transaction Fee")
                Text("\(transaction, specifier: "%.2f")")
            }
            .padding()
            
            VStack(spacing: 5) {
                Text("Result")

                Text("\(calculation, specifier: "%.2f")")
                    .foregroundColor(calculation>0.0 ? .green : .red)
                    .font(.system(size: 25))
                    .bold()
            }
            .padding()
            
            Spacer()
        }
        .padding(.top, 20)
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
