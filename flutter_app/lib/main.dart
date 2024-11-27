import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  // ↓ Add this.
  void getNext() {
    current = WordPair.random();
    notifyListeners(); //метод ChangeNotifier) , 
                      // который гарантирует, что каждый,
                      // кто смотрит MyAppState будет уведомлен.
  }
}


class MyHomePage extends StatelessWidget {
  @override
  // Вызывается каждый раз, когда обстоятельства виджета меняются, чтобы
  // виджет оставался актуальным 
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>(); // метод для отслеживания изменения состояния



    // Каждый метод build должен возвращать виджет 
    //или (чаще) вложенное дерево виджетов. 
    //В данном случае виджет верхнего уровня — Scaffold
    return Scaffold( // очень распространенный виджет 
      
      // один из самых простых виджетов
      // берет любое количество детей и помещает их в столбец сверху вниз
      // По умолчанию столбец визуально размещает дочерние элементы вверху
      body: Column(
        children: [
          Text('A random AWESOME idea:'),
          Text(appState.current.asLowerCase),
           ElevatedButton(
            onPressed: () {
              // print('button pressed!');
              appState.getNext();
            },
            child: Text('Next'),
          ),
        ], // необязательная запятая, но её лучше ставить
      ),
    );
  }
}