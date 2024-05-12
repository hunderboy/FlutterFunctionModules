import 'package:flutter/material.dart';



class TestPageRadioButton extends StatefulWidget {
  const TestPageRadioButton({Key? key}) : super(key: key);

  @override
  State<TestPageRadioButton> createState() => _TestPageRadioButtonState();
}

class _TestPageRadioButtonState extends State<TestPageRadioButton> {

  // function to handle changes in radio button value
  int radioValue = 0;
  void handleRadioValueChanged(int? value) {
    setState(() {
      radioValue = value!;
    });
  }

  // function to handle changes in custom radio button value
  int _selectedValue = 0;
  void _onRadioValueChanged(int value) {
    setState(() {
      _selectedValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Radio Button'),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max, // set mainAxisSize to max
              children: [

                // .................................................. radio
                const Text('Radio'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int index = 0; index < 2; ++index)
                      Radio(
                        value: index,
                        groupValue: radioValue,
                        onChanged:  handleRadioValueChanged,
                      ),
                  ],
                ),

                // Disabled radio buttons
                const Text('Disabled Radio'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int index = 0; index < 2; ++index)
                      Radio<int>(
                        value: index,
                        groupValue: radioValue,
                        onChanged: null,
                      ),
                  ],
                ),

                // Custom radio button
                const Text('Custom Radio'),
                CustomRadioWidget(
                  valueChanged: _onRadioValueChanged,
                  initialValue: _selectedValue,
                ),
              ]),
        )
    );
  }
}



class CustomRadioWidget extends StatefulWidget {
  final Function(int) valueChanged;
  final int initialValue;

  // constructor for custom radio button widget
  const CustomRadioWidget({Key? key, required this.valueChanged, this.initialValue = 0}) : super(key: key);

  @override
  State createState() => _CustomRadioWidgetState();
}

class _CustomRadioWidgetState extends State<CustomRadioWidget> {
  int _value = 0;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  // function to create custom radio buttons
  Widget customRadioButton(String text, IconData iconData, int index) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            _value = index;
            widget.valueChanged(_value);
          });
        },
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          side: BorderSide(
            color: (_value == index) ? Colors.blue : Colors.grey,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              iconData,
              color: (_value == index) ? Colors.blue : Colors.grey,
            ),

          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        customRadioButton("", Icons.male, 1),
        customRadioButton("", Icons.female, 2),
        customRadioButton("", Icons.category, 3)
      ],
    );
  }
}