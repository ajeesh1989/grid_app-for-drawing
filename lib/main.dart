import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const GridApp(),
      theme: ThemeData.dark(),
    );
  }
}

class GridApp extends StatefulWidget {
  const GridApp({super.key});

  @override
  _GridAppState createState() => _GridAppState();
}

class _GridAppState extends State<GridApp> {
  int rows = 5;
  int columns = 5;
  Color gridColor = Colors.black;
  bool showNumbers = true;
  double lineWidth = 1.0;

  void changeGridColor(Color color) {
    setState(() {
      gridColor = color;
    });
  }

  void increaseRows() {
    setState(() {
      rows++;
    });
  }

  void decreaseRows() {
    if (rows > 1) {
      setState(() {
        rows--;
      });
    }
  }

  void increaseColumns() {
    setState(() {
      columns++;
    });
  }

  void decreaseColumns() {
    if (columns > 1) {
      setState(() {
        columns--;
      });
    }
  }

  void toggleShowNumbers() {
    setState(() {
      showNumbers = !showNumbers;
    });
  }

  void increaseLineWidth() {
    setState(() {
      lineWidth += 0.5;
    });
  }

  void decreaseLineWidth() {
    if (lineWidth > 0.5) {
      setState(() {
        lineWidth -= 0.5;
      });
    }
  }

  void resetApp() {
    setState(() {
      rows = 3;
      columns = 3;
      gridColor = Colors.black;
      showNumbers = true;
      lineWidth = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grid App'),
        actions: <Widget>[
          IconButton(
            onPressed: resetApp,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              itemCount: rows * columns,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
              ),
              itemBuilder: (context, index) {
                final number = showNumbers ? (index + 1).toString() : '';
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: gridColor,
                      width: lineWidth,
                    ),
                  ),
                  child: Center(
                    child: Text(number),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  color: Colors.blue.shade100,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Rows',
                        style: TextStyle(color: Colors.black),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: increaseRows,
                            icon: const Icon(Icons.add, color: Colors.black),
                          ),
                          IconButton(
                            onPressed: decreaseRows,
                            icon:
                                const Icon(Icons.minimize, color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.blue.shade100,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Columns',
                        style: TextStyle(color: Colors.black),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: increaseColumns,
                            icon: const Icon(Icons.add, color: Colors.black),
                          ),
                          IconButton(
                            onPressed: decreaseColumns,
                            icon:
                                const Icon(Icons.minimize, color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Pick a Color'),
                          content: SingleChildScrollView(
                            child: ColorPicker(
                              pickerColor: gridColor,
                              onColorChanged: changeGridColor,
                              // ignore: deprecated_member_use
                              showLabel: true,
                              pickerAreaHeightPercent: 0.8,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade100,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                  child: const Text(
                    'Change Color',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: toggleShowNumbers,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                ),
                child: Text(showNumbers ? 'Hide Numbers' : 'Show Numbers'),
              ),
              ElevatedButton(
                onPressed: increaseLineWidth,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                ),
                child: const Text('Inc Line Width'),
              ),
              ElevatedButton(
                onPressed: decreaseLineWidth,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                ),
                child: const Text('Dec Line Width'),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
