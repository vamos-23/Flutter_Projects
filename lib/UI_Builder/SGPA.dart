class SGPA {
  double sgpa = 0.0;
  static Map<String, double> gradePoint = {
    'O': 10.0,
    'E': 9.0,
    'A': 8.0,
    'B': 7.0,
    'C': 6.0,
    'D': 5.0,
    'F': 2.0
  };

  static double calculateSGPA(List<String> selectedGrades, List<int> credits) {
    double totalGradePoints = 0.0;
    double totalCredits = 0.0;
    for (int i = 0; i < selectedGrades.length; i++) {
        double grade = gradePoint[selectedGrades[i]] ?? 0.0; //returns grade value as 0.0 instead of NULL if no value is available
        totalGradePoints += grade * credits[i];
        totalCredits += credits[i];
    }
    return (totalCredits>0) ? totalGradePoints / totalCredits : 0.0;
  }
}
