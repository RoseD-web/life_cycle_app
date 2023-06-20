import 'package:flutter/material.dart';
import 'main.dart';

class UpdateCounter extends StatelessWidget {
  final VoidCallback? incrementCallback;

  const UpdateCounter({Key? key, this.incrementCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  foregroundColor: Colors.yellow,
                  backgroundColor: Colors.green,
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                  if (incrementCallback != null) {
                    incrementCallback!();
                  }
                },
                child: Text('Update'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  foregroundColor: Colors.yellow,
                  backgroundColor: Colors.green,
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
