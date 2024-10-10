import 'package:flutter/material.dart';
import 'step1.dart';
import 'step2.dart';
import 'step3.dart';
import 'step4.dart';
import 'step5.dart';
import 'step6.dart';
import 'step7.dart';
import 'step8.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StepperForm(),
    );
  }
}

class StepperForm extends StatefulWidget {
  @override
  _StepperFormState createState() => _StepperFormState();
}

class _StepperFormState extends State<StepperForm> {
  int _currentStep = 0;
  List<Step> getSteps() => [
        Step(
          title: Text('Step 1 Personal Information'),
          content: Step1(),
          isActive: _currentStep >= 0,
          state: _currentStep > 0 ? StepState.complete : StepState.indexed,
        ),
        Step(
          title: Text('Step 2 Educational Background'),
          content: Step2(),
          isActive: _currentStep >= 1,
          state: _currentStep > 1 ? StepState.complete : StepState.indexed,
        ),
        Step(
          title: Text('Step 3 Employment History'),
          content: Step3(),
          isActive: _currentStep >= 2,
          state: _currentStep > 2 ? StepState.complete : StepState.indexed,
        ),
        Step(
          title: Text('Step 4 I dont know man'),
          content: Step4(),
          isActive: _currentStep >= 3,
          state: _currentStep > 3 ? StepState.complete : StepState.indexed,
        ),
        //   Step(
        //     title: Text('Step 5'),
        //     content: Step5(),
        //     isActive: _currentStep >= 4,
        //     state: _currentStep > 4 ? StepState.complete : StepState.indexed,
        //   ),
        //   Step(
        //     title: Text('Step 6'),
        //     content: Step6(),
        //     isActive: _currentStep >= 5,
        //     state: _currentStep > 5 ? StepState.complete : StepState.indexed,
        //   ),
        //   Step(
        //     title: Text('Step 7'),
        //     content: Step7(),
        //     isActive: _currentStep >= 6,
        //     state: _currentStep > 6 ? StepState.complete : StepState.indexed,
        //   ),
        //   Step(
        //     title: Text('Step 8'),
        //     content: Step8(),
        //     isActive: _currentStep >= 7,
        //     state: _currentStep > 7 ? StepState.complete : StepState.indexed,
        //   ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delmonte Register'),
      ),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _currentStep,
        steps: getSteps(),
        onStepContinue: () {
          if (_currentStep < getSteps().length - 1) {
            setState(() {
              _currentStep += 1;
            });
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() {
              _currentStep -= 1;
            });
          }
        },
        onStepTapped: (step) {
          setState(() {
            _currentStep = step;
          });
        },
        // controlsBuilder: (BuildContext context,
        //     {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
        //   return Row(
        //     children: <Widget>[
        //       ElevatedButton(
        //         onPressed: onStepContinue,
        //         child: const Text('Continue'),
        //       ),
        //       SizedBox(width: 8),
        //       ElevatedButton(
        //         onPressed: onStepCancel,
        //         child: const Text('Cancel'),
        //       ),
        //     ],
        //   );
        // },
      ),
    );
  }
}
