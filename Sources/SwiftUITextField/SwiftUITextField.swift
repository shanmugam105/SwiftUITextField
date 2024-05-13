import SwiftUI

public struct SwiftUITextField: View {
    
    public typealias Completion = () -> Void
    public let placeholder: String
    @Binding public var text: String
    public var dateFormatter: String?
    public var trailingIcon: String?
    public var trailingAction: Completion?
    public var dropDownOptions: [String] = []
    @State private var showDropDown: Bool = false
    
    public init(placeholder: String, 
                text: Binding<String>,
                dateFormatter: String? = nil,
                trailingIcon: String? = nil,
                trailingAction: SwiftUITextField.Completion? = nil,
                dropDownOptions: [String] = []) {
        self.placeholder = placeholder
        self._text = text
        self.dateFormatter = dateFormatter
        self.trailingIcon = trailingIcon
        self.trailingAction = trailingAction
        self.dropDownOptions = dropDownOptions
    }
    
    public var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack(alignment: .topLeading) {
                VStack {
                    TextField(placeholder, text: $text)
                        .font(.system(size: 14, weight: .medium))
                        .autocorrectionDisabled(true)
                        .padding(EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 10))
                    if !dropDownOptions.isEmpty, showDropDown {
                        VStack(alignment: .leading, spacing: 0) {
                            ForEach(dropDownOptions, id: \.self) { item in
                                HStack(alignment: .center) {
                                    Text(item)
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(Color(UIColor(rgb: 0x353535)))
                                        .padding(12)
                                    Spacer()
                                }
                                .onTapGesture {
                                    text = item
                                    showDropDown = false
                                }
                                Divider()
                                    .padding(.horizontal, 12)
                            }
                        }
                        .addBorder(Color.gray.opacity(0.5), cornerRadius: 5)
                        .padding([.horizontal, .bottom], 8)
                    }
                }
                .addBorder(Color.gray.opacity(0.5), cornerRadius: 5)
                .disabled(dateFormatter != nil && dateFormatter?.isEmpty == false)
                
                Text(placeholder)
                    .foregroundColor(.gray)
                    .padding(4)
                    .font(.caption)
                    .background(Color.white)
                    .offset(x: 15, y: -10)
            }
            
            if (dateFormatter != nil && dateFormatter?.isEmpty == false) || !dropDownOptions.isEmpty {
                VStack{}
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(UIColor.lightGray.withAlphaComponent(0.025)))
                    .frame(height: 45)
                    .onTapGesture {
                        if let dateFormatter {
                            let datePicker = DatePickerWithButtons(dateText: $text, dateFormat: dateFormatter)
                            let vc = UIHostingController(rootView: datePicker)
                            vc.modalPresentationStyle = .overCurrentContext
                            vc.view.backgroundColor = .clear
                            UIApplication.topViewController()?.present(vc, animated: true)
                        }
                        
                        if !dropDownOptions.isEmpty {
                            showDropDown.toggle()
                        }
                    }
            }
            
            if let trailingIcon {
                Button {
                    if !dropDownOptions.isEmpty {
                        showDropDown.toggle()
                    }
                    trailingAction?()
                } label: {
                    Image(trailingIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .padding(10)
                }
            }
        }
        .onAppear {
            if dateFormatter?.isEmpty == false && !dropDownOptions.isEmpty {
                fatalError("Please avoid the parameter for date picker and dropdown on sametime.")
            }
            if trailingIcon == nil && trailingAction != nil {
                fatalError("Please set trailing icon")
            }
        }
    }
}

