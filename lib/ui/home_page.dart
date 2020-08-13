import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:todo_app/dbhelper.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/ui/details_todo.dart';
import 'package:todo_app/ui/new_todo.dart';
import 'package:todo_app/ui/update_todo.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double _borderRadius = 24;
  DbHelper healper;

  @override
  void initState() {
    super.initState();
    healper = DbHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Todo App',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 25,
            fontWeight: FontWeight.w700,
            fontFamily: 'Avenir',
          ),
        ),
      ),
      body: FutureBuilder(
        future: healper.allTodo(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: Text(
              'Add New Todo',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ));
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, i) {
              Todo todo = Todo.fromMap(snapshot.data[i]);
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TodoDetails(todo),
                    ),
                  );
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(_borderRadius),
                            gradient: LinearGradient(
                                colors: [Color(0xff6DC8F3), Color(0xff73A1F9)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff73A1F9),
                                blurRadius: 12,
                                offset: Offset(0, 6),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          top: 0,
                          child: CustomPaint(
                            size: Size(100, 150),
                            painter: CustomCardShapePainter(_borderRadius,
                                Color(0xff6DC8F3), Color(0xff73A1F9)),
                          ),
                        ),
                        Positioned.fill(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Image.asset(
                                  'assets/icon.png',
                                  height: 64,
                                  width: 64,
                                ),
                                flex: 2,
                              ),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '${todo.title}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontFamily: 'Avenir',
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      '${todo.description}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontFamily: 'Avenir',
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${todo.date}    ${todo.time}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontFamily: 'Avenir',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    IconButton(
                                      iconSize: 35,
                                      onPressed: () {
                                        setState(() {
                                          healper.delete(todo.id);
                                        });
                                      },
                                      icon: Icon(
                                        Icons.delete_forever,
                                        color: Colors.red.shade400,
                                      ),
                                    ),
                                    IconButton(
                                      iconSize: 30,
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UpdateTodo(todo)));
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black45,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => NewTodo()));
          }),
    );
  }
}

class CustomCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter(this.radius, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = 24.0;

    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(size.width, size.height), [
      HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
      endColor
    ]);

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
