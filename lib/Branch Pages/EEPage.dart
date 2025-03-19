import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../EE/Semester3EE.dart';
import '../EE/Semester4EE.dart';
import '../EE/Semester5EE.dart';
import '../EE/Semester6EE.dart';
import '../Semester1.dart';
import '../Semester2.dart';

class EEPage extends StatefulWidget {
  const EEPage({super.key});
  @override
  State<EEPage> createState() => EEPageState();
}

class EEPageState extends State<EEPage> {
  String? selectedSemester; // Variable to store the selected semester

  final List<String> semesters = ['Select Semester', 'Semester 1 (A/B)', 'Semester 2 (A/B)', 'Semester 3', 'Semester 4','Semester 5','Semester 6'];

  Widget getSemesterContent(String semester,Size screenSize) {
    // Dynamically return content based on the selected semester on the same page
    switch (semester) {
      case 'Semester 1 (A/B)':
        return Semester1();
      case 'Semester 2 (A/B)':
        return Semester2();
      case 'Semester 3':
        return Semester3EE();
      case 'Semester 4':
        return Semester4EE();
      case 'Semester 5':
        return Semester5EE();
      case 'Semester 6':
        return Semester6EE();
      default:
        return Center(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal:screenSize.width * 0.02),
            child: AutoSizeText('Please select a semester',
                maxLines: 1,
                maxFontSize: 17,
                style: TextStyle(fontSize: 17,color: Colors.white)
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0), // Fixed height
        child: AppBar(
          backgroundColor: Colors.blueAccent,
          title: AutoSizeText(
            'EE',
            maxFontSize: 23,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color:Colors.white),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlue, Colors.lightGreen],
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: AutoSizeText(
                  'Select Semester for EE',
                  maxLines: 1,
                  maxFontSize: 19,
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: screenSize.height * 0.013,bottom: screenSize.height * 0.01),
                  child: DropdownButtonHideUnderline(
                    child: Center(
                      child: Container(
                        width: screenSize.width * 0.75,
                        decoration: BoxDecoration(
                          color: Colors.amberAccent,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            width: 2.5,
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.03,vertical: screenSize.height * 0.014),
                          child: DropdownButton<String>(
                            dropdownColor: Colors.amberAccent,
                            iconSize: 20,
                            icon: Icon(Icons.arrow_drop_down_rounded,
                                color: Colors.black87),
                            elevation: 5,
                            value: selectedSemester,
                            hint: AutoSizeText('Select Semester',
                              maxFontSize: 12,
                              minFontSize: 8,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                            items: semesters.map((String semester) {
                              return DropdownMenuItem<String>(
                                value: semester,
                                child: Text(semester),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedSemester = newValue;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  )
              ),
              // Selected semester content to be displayed
              Expanded(child: getSemesterContent(selectedSemester ?? 'Select Semester',screenSize)),
            ],
          ),
        ),
      ),
    );
  }
}
