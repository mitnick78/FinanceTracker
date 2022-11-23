//
//  IconSelector.swift
//  FinanceTracker
//
//  Created by Christophe on 16/10/2022.
//

import SwiftUI

struct IconSelector: View {
    @Binding var selectedIcon: String
    
    private let icons = [
        "icon_001",
        "icon_002",
        "icon_003",
        "icon_004",
        "icon_005",
        "icon_006",
        "icon_007",
    ]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack {
                ForEach(icons, id: \.self) { icon in
                    Button {
                        selectedIcon = icon
                    } label: {
                        Circle()
                            .frame(width: 65, height: 65)
                            .foregroundColor(icon == selectedIcon ? .black : .white)
                            .overlay {
                                Image(icon)
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(icon == selectedIcon ? .white : .black)
                                    .frame(width: 35, height: 35)
                                     
                            }
                    }

                    
                    
                }
            }.padding(.horizontal, 16)
        }
    }
}

struct IconSelector_Previews: PreviewProvider {
    @State static var previewSelector = "icon_001"
    static var previews: some View {
        IconSelector(selectedIcon: $previewSelector)
            .padding(.vertical)
            .previewLayout(.sizeThatFits)
            .background(Color("grey"))
    }
}
