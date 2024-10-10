import 'package:flutter/material.dart';

class Step2 extends StatefulWidget {
  @override
  _Step2State createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  DateTime? selectedDate; // Variable to hold the selected date
  String? selectedCollegeCourse; // Selected college course
  String? selectedGraduateCourse; // Selected graduate course
  String prcLicenseNo = ''; // Variable to hold PRC License No.
  String customCollegeCourse = ''; // Variable for custom college course
  String customGraduateCourse = ''; // Variable for custom graduate course
  bool isOtherCourseSelected = false; // Flag to check if 'Others' is selected
  bool isOtherGraduateSelected =
      false; // Flag to check if 'Others' is selected for graduate courses

  // Mapping of college courses to their corresponding graduate courses
  final Map<String, List<String>> courseMap = {
    'BS in Communication': ['Master of Arts in Communication'],
    'BS in Journalism': ['Master of Arts in Communication'],
    'BS in Fine Arts': ['Master of Arts in Fine Arts'],
    'BS in Philosophy': ['Master of Arts in Philosophy'],
    'BS in Literature': ['Master of Arts in Literature'],
    'BS in English': ['Master of Arts in English'],
    'BS in Accountancy (BSA)': ['Master of Science in Accountancy'],
    'BS in Business Administration (BSBA)': [
      'Master of Business Administration (MBA)',
      'Master of Entrepreneurship',
    ],
    'BS in Hospitality Management': [
      'Master of Science in Hospitality Management'
    ],
    'BS in Nursing (BSN)': ['Master of Science in Nursing (MSN)'],
    'BS in Education': [
      'Master of Arts in Education',
      'Master of Education (MEd)'
    ],
    'BS in Information Technology': [
      'Master of Science in Information Technology',
      'Master of Science in Data Science',
    ],
    // Add more mappings as needed...
  };

  // List of all college courses
  List<String> courses = [
    'BS in Communication',
    'BS in Journalism',
    'BS in Fine Arts',
    'BS in Philosophy',
    'BS in Literature',
    'BS in English',
    'BS in Accountancy (BSA)',
    'BS in Business Administration (BSBA)',
    'BS in Hospitality Management',
    'BS in Nursing (BSN)',
    'BS in Education',
    'BS in Information Technology', // Added course
    'Others', // Added 'Others' option
    // Add more college courses as needed...
  ];

  // List of all graduate courses (will be filtered based on selected college course)
  List<String> graduateCourses = [
    'Master of Arts in Communication',
    'Master of Arts in Education',
    'Master of Arts in Philosophy',
    'Master of Business Administration (MBA)',
    'Master of Science in Accountancy',
    'Master of Entrepreneurship',
    'Master of Engineering',
    'Master of Science in Information Technology',
    'Master of Science in Computer Science',
    'Master of Arts in Education',
    'Master of Education (MEd)',
    'Master of Arts in Special Education',
    'Master of Science in Nursing (MSN)',
    'Master in Public Health (MPH)',
    'Master of Science in Pharmacy',
    'Master of Arts in Psychology',
    'Master of Social Work',
    'Master in Public Administration (MPA)',
    'Master of Laws (LLM)',
    'Master of Science in Biology',
    'Master of Science in Chemistry',
    'Master of Science in Environmental Science',
    'Master of Science in Agriculture',
    'Master of Science in Agricultural Engineering',
    'Master of Architecture',
    'Master of Interior Design',
    'Master of Science in Maritime Studies',
    'Master of Science in Information Systems',
    'Master of Science in Data Science',
    'Master of Arts in Film',
    'Master of Arts in Music',
    'Master of Science in Hospitality Management',
    'Master of Science in Aviation',
    'Others', // Added 'Others' option for graduate courses
  ];

  // Function to show the date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate; // Update the selected date
      });
    }
  }

  // Function to add a new course
  void _addCourse() {
    showDialog(
      context: context,
      builder: (context) {
        String newCourse = '';
        return AlertDialog(
          title: Text('Add New Course'),
          content: TextField(
            onChanged: (value) {
              newCourse = value;
            },
            decoration: InputDecoration(hintText: "Enter course name"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (newCourse.isNotEmpty) {
                  setState(() {
                    courses.add(newCourse); // Add the new course to the list
                  });
                  Navigator.of(context).pop(); // Close the dialog
                }
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Determine the list of graduate courses based on the selected college course
    List<String> filteredGraduateCourses = selectedCollegeCourse != null
        ? courseMap[selectedCollegeCourse!] ?? []
        : [];

    return Column(
      children: [
        DropdownButtonFormField<String>(
          items: courses
              .map((course) =>
                  DropdownMenuItem(value: course, child: Text(course)))
              .toList(),
          onChanged: (value) {
            setState(() {
              selectedCollegeCourse =
                  value; // Update the selected college course
              selectedGraduateCourse =
                  null; // Reset the selected graduate course
              isOtherCourseSelected = selectedCollegeCourse ==
                  'Others'; // Check if 'Others' is selected
            });
            // Handle the selected value
            print('Selected college course: $value');
          },
          decoration: InputDecoration(labelText: 'College Course'),
        ),
        if (isOtherCourseSelected) ...[
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Custom College Course',
            ),
            onChanged: (value) {
              setState(() {
                customCollegeCourse = value; // Update custom college course
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Custom Graduate Course',
            ),
            onChanged: (value) {
              setState(() {
                customGraduateCourse = value; // Update custom graduate course
              });
            },
          ),
        ],
        DropdownButtonFormField<String>(
          items: filteredGraduateCourses.isNotEmpty
              ? filteredGraduateCourses
                  .map((course) =>
                      DropdownMenuItem(value: course, child: Text(course)))
                  .toList()
              : graduateCourses
                  .where((course) =>
                      course != 'Others') // Exclude 'Others' for empty list
                  .map((course) =>
                      DropdownMenuItem(value: course, child: Text(course)))
                  .toList(),
          onChanged: (value) {
            setState(() {
              selectedGraduateCourse =
                  value; // Update the selected graduate course
              isOtherGraduateSelected = selectedGraduateCourse ==
                  'Others'; // Check if 'Others' is selected for graduate courses
            });
            // Handle the selected value
            print('Selected graduate course: $value');
          },
          decoration: InputDecoration(labelText: 'Graduate Course'),
        ),
        if (isOtherGraduateSelected) ...[
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Custom Graduate Course',
            ),
            onChanged: (value) {
              setState(() {
                customGraduateCourse = value;
              });
            },
          ),
        ],
        TextFormField(
          readOnly: true,
          decoration: InputDecoration(
            labelText: 'Date of Graduation',
            suffixIcon: IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () =>
                  _selectDate(context), // Call to the date picker function
            ),
          ),
          controller: TextEditingController(
            text: selectedDate != null
                ? "${selectedDate!.toLocal()}".split(' ')[0]
                : '', // Format the date for display
          ),
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'PRC License No.',
          ),
          onChanged: (value) {
            setState(() {
              prcLicenseNo = value; // Update PRC License No.
            });
          },
        ),
        SizedBox(height: 20), // Space before the button
        ElevatedButton(
          onPressed: _addCourse,
          child: Text('Add Course'),
        ),
      ],
    );
  }
}
