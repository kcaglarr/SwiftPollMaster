//
//  SwiftPollMaster.swift
//
//
//  Created by Kerim Çağlar on 28.07.2024.
//

import SwiftUI

struct SwiftPollMaster: View {
    
    @ObservedObject var keyboardHeightHelper = KeyboardHeightHelper()

    @State private var choices: [String] = ["", ""]
    @State private var newChoice = ""
    
    private let dividerId = "dividerId"
    let regular14 = Font.system(size: 14, weight: .regular)
    let medium14 = Font.system(size: 14, weight: .medium)
    let medium16 = Font.system(size: 16, weight: .medium)
    let medium18 = Font.system(size: 18, weight: .medium)
    
    var body: some View {
        
        VStack(spacing: 10) {

            
            VStack(alignment: .leading, spacing: 10) {
                
                Text("Poll Choices")
                    .font(medium16)
                    .padding(.bottom, 2)
                
                ScrollViewReader { scrollViewProxy in
                    ForEach(choices.prefix(10).indices, id: \.self) { index in
                        HStack {
                            
                            TextField("Enter a choice", text: Binding(
                                get: {
                                    return index < choices.count ? choices[index] : ""
                                },
                                set: { newValue in
                                    choices[index] = newValue
                                }
                            ))
                            .frame(height: 48)
                            .font(regular14)
                            .padding(.leading, 16)
                            .foregroundColor(.black)
                            .background(Color.clear)
                            Spacer()
                            if index > 1 {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.black)
                                    .padding(.trailing, 10)
                                    .onTapGesture {
                                        choices.remove(at: index)
                                    }
                            }
                        }
                        .id(index)
                        .overlay {
                            RoundedRectangle(cornerRadius: 12).stroke(.black, lineWidth: 2)
                        }
                        .frame(maxWidth: .infinity)
                        .onChange(of: choices.count) { _ in
                            // Scroll to the newly added choice
                            withAnimation {
                                scrollViewProxy.scrollTo(choices.count - 1, anchor: .top)
                            }
                        }
                    }
                    .padding(.vertical, 2)

                    Button(action: {
                        choices.append("")
                        newChoice = ""
                    }) {
                        HStack {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundStyle(.white)
                            Text(" Add New Choice")
                                .foregroundColor(.white)
                                .font(medium14)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 46)
                        .background(Color.black)
                        .cornerRadius(10)
                    }
                    .padding(.top, 8)
                    
                    VStack(alignment: .leading) {
                        Text("Poll length")
                            .font(medium16)
                            .padding(.top, 18)
                        
                        HStack {
                            Text("Choose One")
                            .font(regular14)
                            .padding(.leading, 20)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .padding(.trailing, 20)
                        }
                        .frame(height: 36)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(HexColor("#CBD3DD"), lineWidth: 2)
                                
                        }
                        .onTapGesture {
                            print("denemeee")
                        }
                    }
                    .id(dividerId)
                    
                    Button(action: {
                        choices.removeAll()
                    }) {
                        HStack {
                            Image(systemName: "trash.fill")
                                .foregroundColor(.white)
                                .frame(width: 20, height: 20)
                            Text(" Remove Poll")
                                .foregroundColor(.white)
                                .font(medium14)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(HexColor("#E24723"))
                        .cornerRadius(10)
                    }
                    .padding(.bottom)
                    .padding(.top, 6)
                    .onChange(of: keyboardHeightHelper.keyboardIsOpen, perform: { value in
                        if value {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    scrollViewProxy.scrollTo(dividerId, anchor: .top)
                                }
                            }
                        }
                    })
                    
                    Divider()
                        .frame(height: self.keyboardHeightHelper.keyboardHeight / 4)
                    
                }
            }
        }
        .padding(.horizontal, 1)
    }
}

#Preview {
    SwiftPollMaster()
        .padding()
}
