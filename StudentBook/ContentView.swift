// ContentView.swift

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var context

//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Student.ident_, ascending: true)],
//        animation: .default)
    @FetchRequest(fetchRequest: Student.request_allStudent)
    private var students: FetchedResults<Student>

    var body: some View {
        Text("StudentList").font(.system(.title))
        
        List {
            ForEach(students) { student in
                StudentView(name: student.name, ident: student.ident, email: student.email)
            }
            .onDelete(perform: deleteItems)
        }
        
        Button(action: addItem) {
            Label("Add Student", systemImage: "plus")
        }
    }

    private func addItem() {
        withAnimation {
            let newStudent = Student(context: context)
            newStudent.name_ = "yxj"
            newStudent.ident_ = 1

            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { students[$0] }.forEach(context.delete)

            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct StudentView: View {
    var name: String
    var ident: Int
    var email: String?

    var body: some View {
        HStack {
            Text(name).font(.system(.title))
            VStack {
                Text("\(ident)")
                if let email = email {
                    Text(email)
                }
            }
        }
    }
}
