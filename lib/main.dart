import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Market App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal,
          foregroundColor: Color.fromARGB(255, 236, 222, 222),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.teal,
          foregroundColor: Color.fromARGB(255, 245, 233, 233),
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(color: Colors.teal, fontSize: 36, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(color: Colors.teal),
        ),
      ),
      home: const MyHomePage(title: 'سبحان الله'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<int> _achievements = [];
  bool _showAchievements = false;

  void _incrementCounter() {
    setState(() {
      _counter += 1;
      if (_counter > 99) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text("انتهت التسبيحة الاولي", style: TextStyle(color: Colors.teal)),
            backgroundColor: Color.fromARGB(255, 247, 247, 247),
          ),
        );
      }
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  void _saveNumber() {
    setState(() {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("تم حفظ الرقم: $_counter"),
          backgroundColor: Colors.teal,
        ),
      );
    });
  }

  void _addAchievement() {
    setState(() {
      _achievements.add(_counter);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("تم إضافة الإنجاز: $_counter"),
          backgroundColor: Colors.teal,
        ),
      );
    });
  }

  void _toggleAchievements() {
    setState(() {
      _showAchievements = !_showAchievements;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Color.fromARGB(255, 176, 196, 217), // Set the background color 
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'عدد التسبيح:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _toggleAchievements,
                child: const Text('عرض الانجازات'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 74, 49, 49),
                  backgroundColor: Colors.teal,
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
              Visibility(
                visible: _showAchievements,
                child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue[50], // Changed to light blue
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: _achievements
                        .asMap()
                        .entries
                        .map(
                          (entry) => ListTile(
                            title: Text('إنجاز ${entry.key + 1}: ${entry.value} تسبيحات'),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'سبح من هنا',
            child: const Icon(Icons.add_box),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _resetCounter,
            tooltip: 'إعادة التعيين',
            child: const Icon(Icons.refresh),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _saveNumber,
            tooltip: 'حفظ الرقم',
            child: const Icon(Icons.save),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _addAchievement,
            tooltip: 'إضافة إنجاز',
            child: const Icon(Icons.emoji_events),
          ),
        ],
      ),
    );
  }
}
