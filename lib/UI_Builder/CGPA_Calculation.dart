import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiit_cgpa_calculator/UI_Builder/CGPA_DialogBox.dart';
import 'package:url_launcher/url_launcher.dart';

class CGPA_Calculation {
  static Future<double?> enter_detailsDialogBox(BuildContext context) async {
    TextEditingController previousCGPAController = TextEditingController();
    TextEditingController totalPreviousSemestersController = TextEditingController();
    TextEditingController currentSGPAController = TextEditingController();

    return await showDialog<double>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.lightGreenAccent,
          title: Center(
            child: Text(
              'Enter Details:',
              style: TextStyle(
                fontSize: 17.5,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 14.0, vertical: 3.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: previousCGPAController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  hintText: "CGPA upto Previous Semester",
                  prefixStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () =>
                    kiitSAP(context,
                        "https://kiitportal.kiituniversity.net/irj/portal/"),
                child:
                Text(
                  'Forgot recent CGPA?',
                  style: TextStyle(
                      fontSize: 12,
                      decoration: TextDecoration.underline,
                      color: Colors.blue
                  ),
                ),
              ),
              TextField(
                controller: totalPreviousSemestersController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  hintText: "Total Previous Semesters",
                  prefixStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              TextField(
                controller: currentSGPAController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  hintText: "Current Semester SGPA",
                  prefixStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (previousCGPAController.text.isEmpty ||
                    currentSGPAController.text.isEmpty ||
                    totalPreviousSemestersController.text.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        AlertDialog(
                          backgroundColor: Colors.lightGreenAccent,
                          title: Center(
                            child: Text("Please enter required details!",
                              style: TextStyle(
                                fontSize: 17.5,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('OK')
                            ),
                          ],
                        ),
                  );
                  return;
                }
                double previousCGPA = double.tryParse(
                    previousCGPAController.text) ?? 0.0;
                int totalPreviousSemesters = int.tryParse(
                    totalPreviousSemestersController.text) ?? 1;
                double currentSGPA = double.tryParse(
                    currentSGPAController.text) ?? 0.0;
                int totalSemesters = totalPreviousSemesters + 1;
                double newCGPA = ((previousCGPA * totalPreviousSemesters) +
                    currentSGPA) / totalSemesters;
                Navigator.pop(context);
                CGPA_DialogBox.cgpaDialogBox(context, newCGPA);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  static Future<void> kiitSAP(BuildContext context, String s) async {
    final Uri url = Uri.parse(s);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
    else {
      if (context.mounted) {
        SnackBar(
          backgroundColor: Colors.blueAccent,
          content: AutoSizeText('Unable to open link! Please try again!',
            maxFontSize: 20,
            maxLines: 1,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: Colors.white),
          ),
          duration: Duration(seconds: 1),
        );
      }
    }
  }
}