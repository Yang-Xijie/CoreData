// Student+.swift

import CoreData
import Foundation

extension Student {
    // MARK: - request to get data from Core Data (use in UI)

    static var request_allStudent: NSFetchRequest<Student> {
        let request = NSFetchRequest<Student>(entityName: "Student")
        request.sortDescriptors = [NSSortDescriptor(key: "ident_", ascending: true)]
        return request
    }

    static func request(predicate: NSPredicate) -> NSFetchRequest<Student> {
        let request = NSFetchRequest<Student>(entityName: "Student")
        request.sortDescriptors = [NSSortDescriptor(key: "ident_", ascending: true)]
        request.predicate = predicate
        return request
    }

    // MARK: - deal with data in Core Data

    var ident: Int {
        get { Int(ident_) }
        set { ident_ = Int32(newValue) }
    }

    var name: String {
        get { name_! }
        set { name_ = newValue }
    }

    var email: String? {
        get { email_ }
        set { email_ = newValue }
    }

    // MARK: - analysis on Core Data

    // MARK: - operate on Core Data

    static func create(studentInfo: StudentInfo, context: NSManagedObjectContext) {
        let newStudent = Student(context: context)
        newStudent.name = studentInfo.name
        newStudent.ident = studentInfo.ident
        newStudent.email = studentInfo.email

        try? context.save()
    }
}
