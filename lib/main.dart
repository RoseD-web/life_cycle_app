import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'update_counter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Main(),
        '/update_counter': (context) => const UpdateCounter()
      },
    );
  }
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

int label = 0;
void plusLabel10() {
  label += 1;
}

class _MainState extends State<Main> with WidgetsBindingObserver {
  late DateTime startTime;

  int label = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadCounter();
  }

  void _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      label = (prefs.getInt('counter') ?? 0);
    });
  }

  void incrementLabel5() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      label = (prefs.getInt('counter') ?? 0) + 5;
      prefs.setInt('counter', label);
    });
  }

  void incrementLabel2() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      label = (prefs.getInt('counter') ?? 0) + 2;
      prefs.setInt('counter', label);
    });
  }

  void incrementLabel10() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      label = (prefs.getInt('counter') ?? 0) + 10;
      prefs.setInt('counter', label);
    });
  }

  void minusLabel(int a) {
    if (a == 0) {
      label -= 2;
    } else {
      label -= 2 * a;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) return;
    final isBackground = state == AppLifecycleState.paused;
    final isBack = state == AppLifecycleState.resumed;
    if (isBackground) {
      setLabelData(label);
      startTime = DateTime.now();
      print(isBackground);
      setState(() {
        incrementLabel5();
      });
    }
    if (isBack) {
      var usageTime = DateTime.now().difference(startTime);
      print(usageTime.inMinutes.toInt());
      print(isBack);
      setState(() {
        incrementLabel2();
        minusLabel(usageTime.inMinutes.toInt());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(label.toDouble()),
              color: Colors.yellow,
            ),
            height: 325,
            width: 325,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(label.toString()),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: FloatingActionButton.large(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateCounter(
                                incrementCallback: incrementLabel10,
                              ),
                            ),
                          ).then((flag) {
                            if (flag != null) {
                              setState(() {});
                            }
                          });
                        },
                        backgroundColor: Colors.blue,
                        child: Text('Tap'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getLabel() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    label = pref.getInt('label')!;
  }

  Future<void> setLabelData(labelValue) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('label', labelValue);
  }
}
