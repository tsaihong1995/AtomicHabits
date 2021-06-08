//
//  CommentTextField.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-03-17.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import SwiftUI

struct CommentTextField: View {
    @State var habit: Habit
    @State var comment = Comment(comment: "", habitID: "")
    @StateObject var communityVM : CommunityHabitsListViewModel
    @State private var textFieldData = ""
    
    var body: some View {
        HStack {
            TextField("Add a comment", text: $textFieldData)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .textContentType(.addressCity) // What kind of data
            
               Button(action: {
                saveButtonClick()
               }) {
                   Text("Post")
               }
               .accentColor(.orange)
           }
    }
    
    func saveButtonClick(){
        comment.comment = self.textFieldData
        comment.habitID = self.habit.id!
        communityVM.createComment(habit, comment: comment)
        self.textFieldData = ""
    }
}

struct CommentTextField_Previews: PreviewProvider {
    static var previews: some View {
        CommentTextField(habit: mockData1[1], communityVM: CommunityHabitsListViewModel() )
    }
}
