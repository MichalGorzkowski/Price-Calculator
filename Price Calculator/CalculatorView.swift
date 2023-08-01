//
//  CalculatorView.swift
//  Price Calculator
//
//  Created by Michał Gorzkowski on 01/08/2023.
//

import SwiftUI

struct CalculatorView: View {
    // Buy price input
    @State var inputBuyPrice: String = "0"
    @State var isVatIncludedBuyPrice: Bool = true
    
    // Sell price input
    @State var inputSellPrice: String = "0"
    @State var isVatIncludedSellPrice: Bool = true
    
    //Shipment price input
    @State var inputShippmentPrice: String = "0"
    @State var isVatIncludedShippmentPrice: Bool = true
    
    // Commission Percent input
    @State var inputCommissionPercent: String = "8"
    
    
    // Prices without VAT
    var buyPrice: Double {
        guard let price = Double(inputBuyPrice) else { return 0 }
        return isVatIncludedBuyPrice ? round((price/1.23) * 100) / 100.0 : price
    }
    
    var sellPrice: Double {
        guard let price = Double(inputSellPrice) else { return 0 }
        return isVatIncludedSellPrice ? round((price/1.23) * 100) / 100.0 : price
    }
    
    var shippmentPrice: Double {
        guard let price = Double(inputShippmentPrice) else { return 0 }
        return isVatIncludedShippmentPrice ? price : round((price/1.23) * 100) / 100.0
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
        
        return round((sell - buy - shippment - commission - transaction) * 100) / 100
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
                        
                        Text("VAT")
                            .font(.system(.footnote))
                            .foregroundColor(.gray)
                        
                        CheckBoxView(checked: $isVatIncludedShippmentPrice)
                    }
                    
                    ZStack {
                        Rectangle()
                            .frame(width: .infinity, height: 50)
                            .cornerRadius(10)
                            .foregroundColor(Color(UIColor.lightGray))
                        
                        TextField("Price", text: $inputShippmentPrice)
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
                    }
                }
            }
            .padding()
            
            VStack {
                Text("Commission Fee")
                Text(String(commission))
            }
            .padding()
            
            VStack {
                Text("Transaction Fee")
                Text(String(transaction))
            }
            .padding()
            
            VStack {
                Text("Result")

                Text("\(calculation)")
                    .foregroundColor(calculation>0.0 ? .green : .red)
            }
            .padding()
            
            Spacer()
        }
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView(inputBuyPrice: "123", isVatIncludedBuyPrice: true, inputSellPrice: "123", isVatIncludedSellPrice: true, inputShippmentPrice: "0", isVatIncludedShippmentPrice: true, inputCommissionPercent: "8")
    }
}
