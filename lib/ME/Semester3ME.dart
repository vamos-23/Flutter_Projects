import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kiit_cgpa_calculator/UI_Builder/SGPA.dart';
import '../UI_Builder/CGPA_Calculation.dart';
import '../UI_Builder/SGPA_DialogBox.dart';
import '../UI_Builder/ui_builder.dart';

class Semester3ME extends StatefulWidget {
  const Semester3ME({super.key});

  @override
  State<Semester3ME> createState() => _Semester3MEState();
}

class _Semester3MEState extends State<Semester3ME> {
  var grades = ['Select Grade', 'O', 'E', 'A', 'B', 'C', 'D', 'F'];
  var subjects = [
    'Mechanics of Solids',
    'Fluid Mech. & Hydr. Machines',
    'Manufacturing Technology - 1',
    'Material Science & Engineering',
    'Probability & Statistics',
    'Scientific & Technical Writing',
    'Fluid Mech. & Hydr. Machine Lab ',
    'Material Testing Lab',
    'Manufacturing Practices - 1',
    'Vocational Elective'
  ];
  List<String> selectedGrades = List.filled(10, ''); // List to store selected grades
  final credits = [4,3,4,3,4,2,1,1,1,1];
  double sgpa = 0.0;
  bool isSGPACalculated = false;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  bool areAllGradesSelected() {
    if(!selectedGrades.contains('') && !selectedGrades.contains("Select Grade")){
      return true;
    }
    else{
      _scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          backgroundColor: Colors.blueAccent,
          content:AutoSizeText('Please select all grades',
            maxFontSize: 20,
            maxLines: 1,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color:Colors.white),),
          duration: Duration(seconds: 1),
        ),
      );
    }
    return false;
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
                  selectedGrades[index] = newValue!;
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

    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
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
                            SizedBox(width:10),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.amberAccent,
                                ),
                                onPressed: () {
                                  CGPA_Calculation.enter_detailsDialogBox(context);
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
      ),
    );
  }
}