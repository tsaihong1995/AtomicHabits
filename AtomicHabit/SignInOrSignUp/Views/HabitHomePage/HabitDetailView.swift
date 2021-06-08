//
//  HabitDetailView.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-02-16.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import SwiftUI




// MARK: - DetailCardRowView
struct DetailCardRowView: View {
    // MARK: - PROPERTIES
    
    var name: String
    var content: String? = nil
    var linkLabel: String? = nil
    var linkDestination: String? = nil
    var unitDescription: String? = ""
    
    // MARK: - BODY
    
    var body: some View {
        
        VStack {
            Divider().padding(.vertical, 4)
            
            HStack {
                Text(name).foregroundColor(Color.gray)
                Spacer()
                if (content != nil) {
                    Text("\(content!) \(unitDescription!)")
                } else if (linkLabel != nil && linkDestination != nil) {
                    Link(linkLabel!, destination: URL(string: "https://\(linkDestination!)")!)
                    Image(systemName: "arrow.up.right.square").foregroundColor(.pink)
                }
                else {
                    EmptyView()
                }
            }
        }
    }
}

let mockData1 = [
    Habit(title: "My 1st Habit", goalCount: 20, currentCount: 2, achieve: false, description: "Some description of 1st Habit", unitDescription: "times"),
    Habit(title: "My 2nd Habit", goalCount: 30, currentCount: 5, achieve: false, description: "Some description of 2st Habit", unitDescription: "times"),
    Habit(title: "My 3rd Habit", goalCount: 10, currentCount: 11, achieve: true, description: "Some description of 3rd Habit", unitDescription: "times"),
]

struct HabitDetailView: View {
    @ObservedObject var habitListVM = HabitListViewModel()
    @ObservedObject var habitRepo = HabitRepository()
    @ObservedObject var networkManager = NetworkManager()
    
    @Binding var habitCellVM : HabitCellViewModel

    @State var selectedHabit: Habit
    @Environment(\.presentationMode) var presentationMode
    @State private var presentingSheet = false
    
    var body: some View {
        
        
        ScrollView{
            ZStack{
                VStack(alignment: .leading) {
                    GroupBox(
                        label:
                            SettingLabelView(labelText: habitCellVM.habit.title, labelImage: "info.circle")
                    ) {
                        
                        DetailCardRowView(name: "Category", content: habitCellVM.habit.category.rawValue)
                        DetailCardRowView(name: "Your Goal", content: String(habitCellVM.habit.goalCount), unitDescription: habitCellVM.habit.unitDescription)
                        DetailCardRowView(name: "Current Count", content: String(habitCellVM.habit.currentCount))
                        DetailCardRowView(name: "Description", content: String(habitCellVM.habit.description))
                        
                        VStack {
                            Divider().padding(.vertical, 4)
                            HStack {
                                Text("Acheivement").foregroundColor(Color.gray)
                                Spacer()
                                Image(systemName: habitCellVM.habit.achieve ? "checkmark.circle.fill" : "xmark.circle").foregroundColor(.pink)
                            }
                        }
                    }
                    .padding()
                    
                    TitleView(title: "Comment")
                    if(habitRepo.comments.isEmpty) {
                        VStack{
                            Image("BlankPage")
                                .resizable()
                                .scaledToFit()
                                .offset(y: -75)
                            Text("Haven't have comment yet. Keep it up!")
                                .frame(maxWidth: 280)
                                .multilineTextAlignment(.center)
                                .font(.title3)
                                .foregroundColor(.gray)
                                .offset(y: -150)
                            Spacer()
                        }

                    }
                    else {
                        ForEach(habitRepo.comments, id: \.self) { ref in
                            HStack{
                                CommentRowView(commenterName: ref.commenterName!, commentContext: ref.comment)
                                    .padding(.bottom, 2)
                            }
                        }
                    }
                }
                .navigationBarTitle("Habit Detail", displayMode: .inline)
                
                //This toolbar item that the user edit the selected habit.
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            self.presentingSheet = true
                        }, label: {
                            Text("Edit")
                        })

                    }
                }
                Spacer()
                if(!networkManager.networkStatus) {
                    Text("Check Your Network Status")
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        .background(Color.red)
                        .cornerRadius(25)
                        .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
                }
            }
            
            
        }//: ScrollView
        .onAppear{
            habitRepo.loadComment(habit: selectedHabit)
        }
        .sheet(isPresented: $presentingSheet, content: {
            HabitDetailEditView(selectedHabit: $selectedHabit)
        })

    }
    
    func DoneHasTapped(_ habit: Habit) {
        habitListVM.updateHabit(habit: habit)
        dismiss()
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

// MARK: - CommentRowView
struct CommentRowView: View {
    // MARK: - PROPERTIES
    
    var commenterName: String
    var commentContext: String
    
    // MARK: - BODY
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Image("Icon-51")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 35)
                    .cornerRadius(9)
                    .padding(.leading, 10)
                VStack(alignment: .leading) {
                    Text(commenterName)
                        .foregroundColor(.gray)
                        .font(.caption2)
                    Text(commentContext)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineSpacing(-50)
                        .font(.caption)
                }
                .padding(.trailing)
            } //: HSTACK
            .padding(.top, 5)
        }
        
    }
}

struct HabitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            HabitDetailView(habitListVM: HabitListViewModel(), habitRepo: HabitRepository(), habitCellVM: .constant(HabitCellViewModel(habit: Habit())), selectedHabit: mockData1[1])
            CommentRowView(commenterName: "User_1", commentContext: "My message test is Okay, or not. Also test for jsakldjflksj lkjsadl asldkfj lkjsadlk jlj sklajfl kjlsak j aslkdjflk jldk jsadkfljslj salkjlfkj  slkdjflkj fjskal jfsklaf sdjfklj salkjfljj lksadjflkjlkj lskafjdlk jslksadj lksadj fl the long text")
                .previewLayout(PreviewLayout.sizeThatFits)
                .padding()
                .previewDisplayName("Comment Row View")
            CommentRowView(commenterName: "User_1", commentContext: "My message test is Okay, or not. Also test for jsakldjflksj lkjsadl asldkfj lkjsadlk jlj sklajfl kjlsak j aslkdjflk jldk jsadkfljslj salkjlfkj  slkdjflkj fjskal jfsklaf sdjfklj salkjfljj lksadjflkjlkj lskafjdlk jslksadj lksadj fl the long text")
                .previewLayout(PreviewLayout.sizeThatFits)
                .padding()
                .previewDisplayName("Comment Row View - Dark View")
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        }
        
    }
}
