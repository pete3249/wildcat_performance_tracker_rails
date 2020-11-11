# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.first_or_create(name: "Katelyn Peterson", email: "katelynpeterson@westminster.net", password: "Sawyer123$")

student = Student.first_or_create(name: "Connor Wesselman", grad_year: "2021")

t1 = TestType.find_or_create_by(name: "Vertical Jump")
t2 = TestType.find_or_create_by(name: "Broad Jump")
ts = TestType.find_or_create_by(name: "40 Meter Sprint")

p1 = student.performance_tests.find_or_create_by(result: "28", date_taken: DateTime.strptime("07/04/2020 10:30", "%m/%d/%Y %H:%M"), user_id: 1, test_type_id: 1)
p2 = student.performance_tests.find_or_create_by(result: "90", date_taken: DateTime.strptime("07/04/2020 10:45", "%m/%d/%Y %H:%M"), user_id: 1, test_type_id: 2)
p3 = student.performance_tests.find_or_create_by(result: "4.78", date_taken: DateTime.strptime("07/04/2020 11:00", "%m/%d/%Y %H:%M"), user_id: 1, test_type_id: 3)
