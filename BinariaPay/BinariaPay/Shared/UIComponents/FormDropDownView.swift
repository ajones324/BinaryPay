//
//  FormDropDownView.swift
//  BinariaPay
//
//  Created by Andrew Ikenna Jones on 7/12/23.
//

import SwiftUI

struct FormDropdownView: View {
    @StateObject var viewModel: Self.ViewModel
    @State private var id = UUID()

    var body: some View {
        ScrollViewReader { proxy in
            VStack(alignment: .leading) {
                Text(viewModel.label)
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.white)
                    .opacity(viewModel.text != viewModel.label ? 1.0 : 0.0)
                    .padding(.bottom, 4)
                
                FormDisclosureGroup(animation: .easeInOut(duration: 0.2), isExpanded: $viewModel.isExpanded) {
                    viewModel.isExpanded.toggle()
                } prompt: {
                    HStack(spacing: 0) {
                        Text(viewModel.text)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(viewModel.text != viewModel.label ? .white : .gray)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .rotationEffect(viewModel.isExpanded ? Angle(degrees: 180) : .zero)
                    }
                } expandedView: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .padding(.horizontal, 12)
                            .frame(height: 32)
                            .foregroundColor(.white)
                        
                        Picker(viewModel.text, selection: $viewModel.text) {
                            ForEach(viewModel.selections, id: \.self) { filler in
                                HStack {
                                    Text(filler)
                                        .foregroundColor(.black)
                                        .font(.system(size: 16, weight: .bold))
                                    Spacer()
                                }
                                .padding(.horizontal, 16)
                            }
                            
                        }
                        .background(Color.gray)
                        .pickerStyle(.wheel)
                        .onTapGesture {
                            print(viewModel.isExpanded)
                            viewModel.text = viewModel.selections[0]
                        }
                    }
                    .padding(.top, 8)
                }
                .onChange(of: viewModel.text) { newValue in
                    withAnimation {
                        if newValue.isEmpty {
                            viewModel.text = viewModel.label
                        }

                        viewModel.isExpanded = false
                    }
                }

                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
            }
            .id(id)
            .onChange(of: viewModel.isExpanded) { isExpanded in
                withAnimation {
                    if isExpanded {
                        proxy.scrollTo(id)
                    }
                }
            }
        }
    }
}

struct FormDisclosureGroup<Prompt: View, ExpandedView: View>: View {
    
    @Binding var isExpanded: Bool

    var actionOnClick: () -> ()
    var animation: Animation?
    
    let prompt: Prompt
    let expandedView: ExpandedView
    
    init(animation: Animation?, isExpanded: Binding<Bool>, actionOnClick: @escaping () -> (), prompt: () -> Prompt, expandedView: () -> ExpandedView) {
        self.actionOnClick = actionOnClick
        self._isExpanded = isExpanded
        self.animation = animation
        self.prompt = prompt()
        self.expandedView = expandedView()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            prompt
            
            if isExpanded{
                expandedView
            }
        }
        .clipped()
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(animation) {
                actionOnClick()
            }
        }
    }
}
