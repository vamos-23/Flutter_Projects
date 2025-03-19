import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kiit_cgpa_calculator/UI_Builder/SGPA.dart';
import '../UI_Builder/ui_builder.dart';
import 'UI_Builder/CGPA_DialogBox.dart';
import 'UI_Builder/SGPA_DialogBox.dart';

class Semester1 extends StatefulWidget {
  const Semester1({super.key});

  @override
  State<Semester1> createState() => Semester1State();
}

class Semester1State extends State<Semester1> {
  var grades = ['Select Grade', 'O', 'E', 'A', 'B', 'C', 'D', 'F'];
  var subjects = [
    'Physics',
    'DE & LA',
    'Science of Living Systems',
    'Environmental Science',
    'Engineering Drawing',
    'C Programming Lab',
    'Physics Lab',
    'Engineering Elective',
    'Science Elective'
  ];
  List<String> selectedGrades = List.filled(9, ''); // List to store selected grades
  final credits = [3, 4, 2, 2, 1, 4, 1, 2, 2];
  double sgpa = 0.0;
  bool isSGPACalculated = false;

  bool areAllGradesSelected() {
    if (!selectedGrades.contains('') && !selectedGrades.contains("Select Grade")) {
      return true;
    }
    else {
      Future.delayed(Duration.zero, () {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.blueAccent,
              content: AutoSizeText(
                'Please select all grades',
                maxFontSize: 20,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              duration: Duration(seconds: 1),
            ),
          );
        }
      });
      return false;
    }
  }

  Widget buildGradeDropdownList() {
    return Column(
      children: List.generate(subjects.length, (index) {
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: GradeDropdown(
            subjectName: subjects[index],
            index: index,
            grades: grades,
            selectedGrade: selectedGrades[index],
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedGrades[index] = newValue;
                });
              }
            },
            credit: credits[index],
            allSelectedGrades: selectedGrades,
            allCredits: credits,
          ),
        );
      }),
    );
  }


  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double buttonHeight = screenSize.height * 0.085;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: AutoSizeText(
                  'Please select grades for all subjects',
                  maxLines: 2,
                  maxFontSize: 15,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              buildGradeDropdownList(),
              SafeArea(
                bottom: true,
                child: Padding(
                  padding: const EdgeInsets.all(0.2),
                  child: SizedBox(
                    height: buttonHeight,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amberAccent,
                              ),
                              onPressed: () {
                                if (areAllGradesSelected()) {
                                  setState(() {
                                    sgpa = SGPA.calculateSGPA(selectedGrades, credits);
                                    isSGPACalculated = true;
                                  });
                                  SGPA_DialogBox.sgpaDialogBox(context, sgpa);
                                }
                              },
                              child: AutoSizeText(
                                'SGPA',
                                maxLines: 1,
                                maxFontSize: 20,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amberAccent,
                              ),
                              onPressed: () {
                                if (!isSGPACalculated) {
                                  Future.delayed(Duration.zero, () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.blueAccent,
                                        content: AutoSizeText(
                                          'Please calculate SGPA first!',
                                          maxFontSize: 20,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white,
                                          ),
                                        ),
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                  });
                                } else {
                                  CGPA_DialogBox.cgpaDialogBox(context, sgpa);
                                }
                              },
                              child: AutoSizeText(
                                'CGPA',
                                maxLines: 1,
                                maxFontSize: 20,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
