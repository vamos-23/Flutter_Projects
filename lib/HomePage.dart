import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'Branch Pages/CEPage.dart';
import 'Branch Pages/CSCEPage.dart';
import 'Branch Pages/CSEPage.dart';
import 'Branch Pages/CSSEPage.dart';
import 'Branch Pages/ECSPage.dart';
import 'Branch Pages/EEEPage.dart';
import 'Branch Pages/EEPage.dart';
import 'Branch Pages/ETCPage.dart';
import 'Branch Pages/ITPage.dart';
import 'Branch Pages/MEPage.dart';

class HomePage extends StatefulWidget{
  final String username;
  const HomePage({required this.username, super.key});
  @override
  HomePageState createState() => HomePageState();
}
class HomePageState extends State<HomePage> {
String? selectedBranch;
var br = ['CSE','CSCE','CSSE','IT','EE','EEE','ETC','ECS','ME','CE'];
void screenNavigator(String branch) {
  switch (branch) {
    case 'CSE':
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CSEPage())
      );
      break;
    case 'CSCE':
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CSCEPage())
      );
      break;
    case 'CSSE':
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CSSEPage())
      );
      break;
    case 'IT':
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ITPage())
      );
      break;
    case 'EE':
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => EEPage())
      );
      break;
    case 'ECS':
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ECSPage())
      );
      break;
    case 'EEE':
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => EEEPage())
      );
      break;
    case 'ETC':
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ETCPage())
      );
      break;
    case 'ME':
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => MEPage())
      );
      break;
    case 'CE':
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CEPage())
      );
      break;
    default:
      break;
  }
}
@override
Widget build(BuildContext context) {
  final Size screenSize = MediaQuery.of(context).size;
  final bool isLandscape = screenSize.width > screenSize.height;

  return Scaffold(
    appBar: PreferredSize(
      preferredSize: const Size.fromHeight(60.0), // Fixed height
      child: AppBar(
        backgroundColor: Colors.blueAccent,
        title: AutoSizeText(
          'Select Your Branch',
          maxFontSize: 23,
          style: TextStyle(fontSize:22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    ),
    body: SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.lightBlue, Colors.lightGreen],
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
            )
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(11.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    "Welcome, ${widget.username} !",
                    maxLines: 1,
                    maxFontSize: 22,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Barlow',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.011),
                  Row(
                    children: [
                      SizedBox(
                        width: screenSize.width * 0.89,
                        child: AutoSizeText(
                          'The SGPA/CGPA Calculation for BTech. programmes follows the below schema:',
                          overflow: TextOverflow.visible,
                          maxLines: 3,
                          maxFontSize: 19,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.014,
                          horizontal: screenSize.width * 0.017),
                      child: Table(
                        border: TableBorder.all(
                          color: Colors.lightBlueAccent,
                          width: 2.5,
                        ),
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        children: [
                          _buildTableRow("Grade Symbol", "Marks Range", "Grade Point", screenSize),
                          _buildTableRow("O", "90-100", "10", screenSize),
                          _buildTableRow("E", "80-89", "9", screenSize),
                          _buildTableRow("A", "70-79", "8", screenSize),
                          _buildTableRow("B", "60-69", "7", screenSize),
                          _buildTableRow("C", "50-59", "6", screenSize),
                          _buildTableRow("D", "40-49", "5", screenSize),
                          _buildTableRow("F", "< 40", "2", screenSize),
                        ],
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.018),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: isLandscape ? screenSize.height * 0.015 : screenSize.height * 0.02,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: Center(
                          child: Container(
                            width: screenSize.width * 0.75,
                            height: isLandscape ? screenSize.height * 0.099 : screenSize.height * 0.083,
                            decoration: BoxDecoration(
                              color: Colors.amberAccent,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                width: 2,
                                color: Colors.lightBlueAccent,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.03,
                              ),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                key: ValueKey(selectedBranch),
                                dropdownColor: Colors.amberAccent,
                                iconSize: 30,
                                icon: Icon(Icons.arrow_drop_down_rounded, color: Colors.black87),
                                elevation: 10,
                                hint: AutoSizeText(
                                  maxLines: 1,
                                  maxFontSize: 17,
                                  'Select Branch ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                items: br.map((String branch) {
                                  return DropdownMenuItem<String>(
                                    value: branch,
                                    child: Text(branch),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedBranch = newValue;
                                  });
                                  if (selectedBranch != null &&
                                      selectedBranch != 'Select Branch') {
                                    screenNavigator(selectedBranch!);
                                  }
                                  borderRadius: BorderRadius.circular(12);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.038),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

TableRow _buildTableRow(String symbol, String range, String point,Size screenSize) {
  return TableRow(
    decoration: BoxDecoration(color: Colors.yellowAccent),
    children: [
      _buildTableCell(symbol,screenSize),
      _buildTableCell(range,screenSize),
      _buildTableCell(point,screenSize),
    ],
  );
}
TableCell _buildTableCell(String text,Size screenSize){
  return TableCell(
    verticalAlignment: TableCellVerticalAlignment.middle,
    child: Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.027,
            vertical: screenSize.height * 0.009),
      child: AutoSizeText(text,
        maxFontSize: 15,
        style:TextStyle(
          fontSize: 15, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
}