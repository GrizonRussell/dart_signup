import 'package:flutter/material.dart';

class Step1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Last Name'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'First Name'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Middle Name'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Contact Number'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Alternate Contact Number'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Alternate Email Address'),
        ),
      ],
    );
  }
}
