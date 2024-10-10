import 'package:flutter/material.dart';

class Step4 extends StatefulWidget {
  @override
  _Step4State createState() => _Step4State();
}

class _Step4State extends State<Step4> {
  String position = ''; // Variable to hold the position
  String company = ''; // Variable to hold the company name
  DateTime? startDate; // Variable to hold the start date
  DateTime? endDate; // Variable to hold the end date

  // Function to show the start date picker
  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != startDate) {
      setState(() {
        startDate = pickedDate; // Update the start date
      });
    }
  }

  // Function to show the end date picker
  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: endDate ?? DateTime.now(),
      firstDate: startDate ??
          DateTime(2000), // Ensure end date cannot be before start date
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != endDate) {
      setState(() {
        endDate = pickedDate; // Update the end date
      });
    }
  }

  // Function to show the modal to add a position
  void _showAddPositionModal() {
    final TextEditingController positionController = TextEditingController();
    final TextEditingController companyController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Position'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: positionController,
                decoration: InputDecoration(labelText: 'Position'),
              ),
              TextField(
                controller: companyController,
                decoration: InputDecoration(labelText: 'Company'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  position = positionController.text; // Set the position
                  company = companyController.text; // Set the company
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Save'),
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
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Position',
          ),
          onChanged: (value) {
            setState(() {
              position = value; // Update the position
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Company',
          ),
          onChanged: (value) {
            setState(() {
              company = value; // Update the company name
            });
          },
        ),
        TextFormField(
          readOnly: true,
          decoration: InputDecoration(
            labelText: 'Start Date',
            suffixIcon: IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () => _selectStartDate(
                  context), // Call to the start date picker function
            ),
          ),
          controller: TextEditingController(
            text: startDate != null
                ? "${startDate!.toLocal()}".split(' ')[0]
                : '', // Format the start date for display
          ),
        ),
        TextFormField(
          readOnly: true,
          decoration: InputDecoration(
            labelText: 'End Date',
            suffixIcon: IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () => _selectEndDate(
                  context), // Call to the end date picker function
            ),
          ),
          controller: TextEditingController(
            text: endDate != null
                ? "${endDate!.toLocal()}".split(' ')[0]
                : '', // Format the end date for display
          ),
        ),
        SizedBox(height: 20), // Space before the button
        ElevatedButton(
          onPressed: () {
            // Show the modal to add position
            _showAddPositionModal();
          },
          child: Text('Add Position'),
        ),
      ],
    );
  }
}
