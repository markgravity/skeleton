import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeletor/skeletor.dart';

class App extends StatefulWidget {
  const App({Key? key, required this.content}) : super(key: key);
  final Widget content;

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoPageScaffold(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Skeleton(
                isShown: isLoading,
                child: widget.content,
              ),
              CupertinoButton(
                child: Text("toggle"),
                onPressed: () {
                  setState(() {
                    isLoading = !isLoading;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(
    App(
      content: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Bone(
                    width: 100,
                    height: 100,
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Image(
                        image: NetworkImage(
                            "https://en.gravatar.com/userimage/137591909/6a42a5a20cd79d50edb957644bc41b0c.png?size=200"),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Bone.hidden(child: Text("MarkG"))
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Bone(
                width: 300,
                height: 30,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: 30,
                  child: Text(
                    "What is Lorem Ipsum?",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Bone.multiple(
                number: 8,
                spacing: 8,
                height: 30,
                variants: [1, 1, 0.95],
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 8 * 7 + 8 * 30,
                  child: Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
