//
//  Cart.swift
//  arbuzTest
//


import SwiftUI

struct Cart: View {
    
    @State var totalPrice = 0.00
    @State var goToDataValidation = false
    
    @State private var name: String = ""
    @State private var address: String = ""
    @State private var number: String = ""
    @State private var isNameValid: Bool = false
    @State private var isAddressValid: Bool = false
    @State private var isNumberValid: Bool = false


    let vegetables = [
        "Авокадо",
        "Банан",
        "Курица"
    ]
    @State private var selectedVegetableIndex = 0
    @State private var weight: Double = 0.0
    @State private var subscriptionDate = Date()
    @State private var isSubscriptionEnabled = false
    
    let daysOfWeek = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]
    let deliveryPeriods = ["Утром", "Обед", "Вечером"]
        
    @State private var selectedDayIndex = 0
    @State private var selectedPeriodIndex = 0
    
    var body: some View {
        VStack {
            Text("Моя корзина")
                .font(.system(size: 44, weight: .semibold, design: .rounded))
                .frame(width: 320, alignment: .leading)
            Form {
            List {
                ForEach(0..<cartItems.endIndex, id:\.self) {item in
                    HStack {
                        Image(cartItems[item][0] as! String)
                            .resizable()
                            .frame(width: 40, height: 40)
                        VStack(spacing: 5) {
                            Text(cartItems[item][1] as! String)
                            Text("\(String(format: "%.2f", cartItems[item][2] as! Double))₸")
                                .foregroundColor(.gray)
                        }
                    }
                }.onDelete{indexSet in
                    cartItems.remove(atOffsets: indexSet)
                    self.calculateTotalPrice()
                }
            }
            
            
                Section(header: Text("Имя")) {
                    TextField("Введите ваше имя", text: $name)
                        .onChange(of: name, perform: { value in
                            validateName()
                        })
                        .foregroundColor(isNameValid ? .green : .red)
                }
                
                Section(header: Text("Адрес")) {
                    TextField("Введите ваш адрес", text: $address)
                        .onChange(of: address, perform: { value in
                            validateAddress()
                        })
                        .foregroundColor(isAddressValid ? .green : .red)
                }
                
                Section(header: Text("Телефон")) {
                    TextField("Введите ваш телефон", text: $number)
                        .onChange(of: number, perform: { value in
                            validateNumber()
                        })
                        .foregroundColor(isNumberValid ? .green : .red)
                }
                
                Section(header: Text("Продукт")) {
                                Picker("Выберите продукт", selection: $selectedVegetableIndex) {
                                    ForEach(0..<vegetables.count, id:\.self) { index in
                                        Text(vegetables[index])
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())
                            }
                            
                Section(header: Text("Вес")) {
                                Slider(value: $weight, in: 0...1000, step: 100)
                                Text("\(Int(weight)) грамм")
                            }
                
                Section(header: Text("День недели")) {
                                Picker("Выберите день", selection: $selectedDayIndex) {
                                    ForEach(0..<daysOfWeek.count, id:\.self) { index in
                                        Text(daysOfWeek[index])
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())
                            }
                            
                            Section(header: Text("Период доставки")) {
                                Picker("Выберите период", selection: $selectedPeriodIndex) {
                                    ForEach(0..<deliveryPeriods.count, id:\.self) { index in
                                        Text(deliveryPeriods[index])
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())
                            }
                
                Section(header: Text("Подписка")) {
                                Toggle("Включить подписку", isOn: $isSubscriptionEnabled)
                                
                                if isSubscriptionEnabled {
                                    DatePicker("Дата подписки", selection: $subscriptionDate, displayedComponents: .date)
                                }
                            }
                


            }
        
            
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.green)
                    .opacity(0.8)
                    .frame(width: 350, height: 120)
                VStack {
                    Text("Итого")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .frame(width: 350, alignment: .leading)
                        .padding(.leading, 60)
                    Text("\(String(format: "%.2f", totalPrice))₸")
                        .foregroundColor(.white)
                        .font(.system(size: 26, weight: .bold))
                        .frame(width: 350, alignment: .leading)
                        .padding(.leading, 60)
                }
                Button() {
                    makePayment()
                    goToDataValidation = true
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder()
                            .frame(width: 120, height: 50)
                            .foregroundColor(.white)
                        Text("Оплатить >")
                            .foregroundColor(.white)
                            .bold()
                            
                    }
                    
                    .navigationDestination(isPresented: $goToDataValidation) {
                        DataValidation()
                    }
                }
                .disabled(!isNameValid || !isAddressValid || !isNumberValid)
                .offset(x: 80)
            }
        }.onAppear(perform: self.calculateTotalPrice)
        
    }
    
    func validateName() {
        // Simple name validation - check if name is not empty
        isNameValid = !name.isEmpty
    }
    
    func validateAddress() {
        // Simple name validation - check if name is not empty
        isAddressValid = !address.isEmpty
    }
    
    func validateNumber() {
        // Simple name validation - check if name is not empty
        isNumberValid = !number.isEmpty
    }

    
    func makePayment() {
        let selectedVegetable = vegetables[selectedVegetableIndex]
        // Handle form submission
        print("Name: \(name)")
        print("Address: \(address)")
        print("Number: \(number)")
        print("Selected Vegetable: \(selectedVegetable)")
        print("Weight: \(weight) grams")
        
        if isSubscriptionEnabled {
                    print("Subscription Enabled")
                    let formatter = DateFormatter()
                    formatter.dateStyle = .short
                    let dateString = formatter.string(from: subscriptionDate)
                    print("Subscription Date: \(dateString)")
                } else {
                    print("Subscription Disabled")
                }
        
        let selectedDay = daysOfWeek[selectedDayIndex]
        let selectedPeriod = deliveryPeriods[selectedPeriodIndex]
                
        print("Selected Day: \(selectedDay)")
        print("Selected Period: \(selectedPeriod)")
    }

    
    
    func calculateTotalPrice() {
        totalPrice = 0.00
        for i in 0..<cartItems.count {
            totalPrice += Double(Int(cartItems[i][2] as! Double))
        }
    }
}
struct Cart_Previews: PreviewProvider {
    static var previews: some View {
        Cart()
    }
}

