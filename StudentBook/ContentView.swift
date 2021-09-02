// ContentView.swift

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var context

    @FetchRequest(fetchRequest: Student.request_allStudent)
    private var students: FetchedResults<Student>

    var body: some View {
        Text("Student List").font(.system(.title))

        List {
            ForEach(students) { student in
                StudentView(name: student.name, ident: student.ident, email: student.email)
            }
            .onDelete(perform: deleteItems)
        }

        AddStudentView()
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

struct AddStudentView: View {
    @Environment(\.managedObjectContext) private var context

    @State private var name_input: String = ""
    @State private var ident_input: String = ""
    @State private var email_input: String = ""

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("name")
                TextField("name",
                          text: $name_input) { _ in } onCommit: {}
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack {
                Text("ident")
                TextField("ident",
                          text: $ident_input) { _ in } onCommit: {}
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack {
                Text("email")
                TextField("email",
                          text: $email_input) { _ in } onCommit: {}
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }

            Button(action: AddButtonClicked) {
                Label("Add Student", systemImage: "plus")
            }
        }
        .padding()
    }

    private func AddButtonClicked() {
        print("[Button] Clicked")

        // deal with input
        let isEmptyNameInput: Bool = name_input == ""
        let isEmptyIdentInput: Bool = ident_input == ""
        let isEmptyEmailInput: Bool = email_input == ""

        let ident_int: Int? = Int(ident_input)
        let isIdentInt: Bool = ident_int != nil

        if !isEmptyNameInput, !isEmptyIdentInput, isIdentInt {
            // create Student
            let studentInfo = StudentInfo(
                name: name_input,
                ident: ident_int!,
                email: isEmptyEmailInput ? nil : email_input)

            Student.create(studentInfo: studentInfo, context: context)

            // prepare for next input
            name_input = ""
            ident_input = ""
            email_input = ""
        } else {
            // TODO: add handling
            print("cannot create")
        }
    }
}
