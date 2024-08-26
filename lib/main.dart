import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light, 
        ),
        backgroundColor: Colors.white,
        body: const SafeArea(
          child: SingleChildScrollView(
            // 使用 SingleChildScrollView 包裹布局
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: NumericKeypad(),
            ),
          ),
        ),
        resizeToAvoidBottomInset: true, 
      ),
    );
  }
}

class NumericKeypad extends StatefulWidget {
  const NumericKeypad({super.key});

  @override
  _NumericKeypadState createState() => _NumericKeypadState();
}

class _NumericKeypadState extends State<NumericKeypad> {
  List<String> keys = [];

  @override
  void initState() {
    super.initState();
    generateKeys();
  }

  void generateKeys() {
    List<String> numbers = List.generate(10, (index) => index.toString());
    numbers.shuffle(Random());

    setState(() {
      keys = [...numbers.take(9), "0", "<-", "C"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blue, width: 2),
          ),
          alignment: Alignment.centerRight,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
        const SizedBox(height: 25), 
        Container(
          padding: const EdgeInsets.all(15),
          color: Colors.grey[200],
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 1.8, // 调整键的宽高比
            ),
            itemCount: keys.length,
            itemBuilder: (context, index) {
              bool isLastRowSpecialButton =
                  index == keys.length - 2 || index == keys.length - 1;

              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isLastRowSpecialButton
                      ? Colors.red[300]
                      : Colors.blue[200],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  
                },
                child: Text(
                  keys[index],
                  style: const TextStyle(fontSize: 24),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
