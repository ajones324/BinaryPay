//
//  TransactionSuccessView.swift
//  BinariaPay
//
//  Created by Andrew Ikenna Jones on 7/14/23.
//

import SwiftUI

struct TransactionSuccessView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                Text("Binary Transaction Succeed!")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 12)
                    .padding(.top, 60)
                    .font(.system(size: 20, weight: .bold))
            }
            .background(BPColors.grey1000.swiftUIColor.edgesIgnoringSafeArea(.all))
            .foregroundColor(.white)
        }
        .navigationBarHidden(true)
    }
}

struct TransactionSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionSuccessView()
    }
}
