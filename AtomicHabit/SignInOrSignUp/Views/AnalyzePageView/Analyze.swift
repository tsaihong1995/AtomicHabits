//
//  SwiftUIView.swift
//  AtomicAnalyze
//
//  Created by Sandeep Adode on 2021-03-25.
//
import SwiftUI

struct AnalyzeChart_Previews: PreviewProvider {
    static var previews: some View {
        AnalyzeChart().environmentObject(UserInfo())
    }
}

struct AnalyzeChart : View{
    
    @ObservedObject var habitRepo = HabitRepository()
    @EnvironmentObject var userInfo: UserInfo
    
    @State var isHabitSelected = false
    @State var selectedHabitID = ""
    
    @State var seletedHabit: Habit?
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    let gridItems = [GridItem()]
    
    var body: some View {
        NavigationView{
            VStack{
                TopBarView()
                TitleView(title: "Habit Progress")
                ScrollView(.horizontal) {
                    LazyHGrid(rows: gridItems, alignment: .center, spacing: columnSpacing, pinnedViews: [], content: {
                        Section() {
                            ForEach(habitRepo.habits) { habit in
                                Button(action: {
                                    self.seletedHabit = habit
                                }, label: {
                                    HStack(alignment: .center, spacing: 10) {
                                        Spacer()
                                        
                                        Text(habit.title.uppercased())
                                            .fontWeight(.light)
                                            .foregroundColor(.gray)
                                            .multilineTextAlignment(.center)
                                            .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                                            .font(.caption)
                                            .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                                        
                                        Spacer()
                                    } //: HSTACK
                                    .frame(width: 150, height: 10)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.gray, lineWidth: 1)
                                    )
                                }) //: BUTTON
                            }
                        }
                    }) //: GRID
                    .frame(height: 50)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                }
                    if(seletedHabit == nil){
                        VStack{
                            Image("BlankPage")
                                .resizable()
                                .scaledToFit()
                                .offset(y: -30)
                            Text("To see how your progress, please select 1 habit you own.")
                                .frame(maxWidth: 280)
                                .multilineTextAlignment(.center)
                                .font(.title3)
                                .foregroundColor(.gray)
                                .offset(y: -105)
                        }
                    }
                    else{
                        VStack{
                            Text(seletedHabit!.title)
                              .font(.title3)
                              .fontWeight(.bold)
                            ZStack{
                                Circle()
                                    .trim(from: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, to: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                                    .stroke(Color.orange.opacity(0.05), lineWidth: 10)
                                    .frame(width: (UIScreen.main.bounds.width-100), height: (UIScreen.main.bounds.width-100))
                                
                                Circle()
                                    .trim(from: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, to: (CGFloat(seletedHabit!.currentCount)/CGFloat(seletedHabit!.goalCount)))
                                    .stroke(Color.orange, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                                    .frame(width: (UIScreen.main.bounds.width-100), height: (UIScreen.main.bounds.width-100))
                                    .animation(.linear)
                                
                                
                                Text(getPercent(current: CGFloat(seletedHabit!.currentCount), Goal: CGFloat(seletedHabit!.goalCount)) + "%")
                                    .font(.system(size: 24))
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(.orange)
                                    .rotationEffect(.init(degrees: 90))
                            }
                            .rotationEffect(.init(degrees: -90))
                            .padding()
                        }//: VStack
                        .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
                        .padding(.top)
                        
                        
                    }
                
                
                Spacer()
                
                if(isHabitSelected == true){
                    Details(habitRepo: habitRepo, habitId: selectedHabitID)
                    
                }
                else{
                    Details(habitRepo: habitRepo, habitId: selectedHabitID).hidden()
                }
            }
            .navigationBarHidden(true)
        }
        
        
    }
}
struct Details : View{
    
    @ObservedObject var habitRepo : HabitRepository
    
    var habitId = ""
    var body: some View{
        ForEach(habitRepo.habits){
            habitDetails in
            if habitId == habitDetails.id{
                VStack {
                    Text(habitDetails.title).font(.largeTitle).foregroundColor(.black)
                    Spacer()
                    Text("Current Habit Streak "+String(habitDetails.currentCount)).font(.title2)
                    Text("Your Goal "+String(habitDetails.goalCount)).font(.title2)
                    if habitDetails.currentCount < habitDetails.goalCount {
                        Text("Awesome!! Keep going")
                    }
                    else{
                        Text("Kudos!! You made it!").font(.system(size: 30))
                    }
                    Spacer()
                }
                .padding()
                .frame(width: (UIScreen.main.bounds.width-50), height: (UIScreen.main.bounds.height)/4)
                .background(Color.blue.opacity(0.1))
                .scaledToFit()
                
            }
            
        }
    }
    
}
func getPercent(current : CGFloat, Goal : CGFloat) -> String{
    let per = (current/Goal) * 100
    return String(format: "%.1f", per)
}

