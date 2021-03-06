import 'package:albiruni/albiruni.dart';

void main() {
  // initiate albiruni class with session & semester
  var albiruni = Albiruni(semester: 1, session: "2021/2022");

  // comment/uncomment to test it

  subjectsFirstPage(albiruni);
  // searchSubject(albiruni);
  // allSubjects(albiruni);
  // testPreflight();
}

/// Print all the subjects on first page
void subjectsFirstPage(Albiruni query) async {
  var subjects = await query.fetch("ENGIN");
  for (var subject in subjects) {
    print(subject);
  }
}

/// Subject can be search by their course code.
void searchSubject(Albiruni query) async {
  var subjects =
      await query.fetch("IRKHS", course: "rkud4995".toAlbiruniFormat());
  for (var subject in subjects) {
    print(subject);
  }
}

// Get all the subject's course code from a kuliyyah
void allSubjects(Albiruni query) async {
  List<String> courseCodes = [];

  int i = 1; // page number

  // loop until it reached page with no data
  while (true) {
    try {
      var res = await query.fetch("CCAC", page: i);
      courseCodes.addAll(res.map((e) => e.code));
    } catch (e) {
      print('Error is thrown here. Mark the end of the subjects in a page.');
      break;
    }
    i++;
  }
  courseCodes = courseCodes.toSet().toList(); //remove duplication
  print(courseCodes.join(', ')); // all course codes
  print('Total: ${courseCodes.length}'); // number of courses
}

/// Quick test to see of requested scope is available/valid
void testPreflight() async {
  var anotherAlbiruniInstance = Albiruni(semester: 1, session: "2021/2022");

  print(await anotherAlbiruniInstance.preflight("KICT"));
}
