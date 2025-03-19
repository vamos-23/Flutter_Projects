import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class GradeDropdown extends StatelessWidget {
  final String subjectName;
  final List<String> grades;
  final String selectedGrade;
  final ValueChanged<String?> onChanged;
  final int credit;

  GradeDropdown({
    super.key,
    required this.subjectName,
    required this.grades,
    required this.selectedGrade,
    required this.onChanged,
    required this.credit, 
    required int index, 
    required List<String> allSelectedGrades,
    required List<int> allCredits,
  });

  @override
  Widget build(BuildContext context) {
    String validSelectedGrade = selectedGrade.isEmpty ? grades[0] : selectedGrade;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonHideUnderline(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.amberAccent,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  width: 2,
                  color: Colors.lightBlueAccent,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    label: AutoSizeText(
                      subjectName,
                      maxLines: 1,
                      maxFontSize: 16,
                      style: TextStyle(
                        fontSize:16 , // Scaling the font size
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  dropdownColor: Colors.amberAccent,
                  items: grades.map((String grade) {
                    return DropdownMenuItem<String>(
                      value: grade,
                      child: AutoSizeText(
                        grade,
                        maxLines:1,
                        maxFontSize:16,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: onChanged,
                  value: validSelectedGrade,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: AutoSizeText(
            'Credits: $credit',
            maxLines: 1,
            maxFontSize: 13,
            style: TextStyle(
              fontSize: 13, // Scaling text size for the credits
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
