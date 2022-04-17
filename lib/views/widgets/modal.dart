import 'package:flutter/material.dart';

Future askModal(BuildContext context, String question) {
  return Navigator.push(
    context,
    PageRouteBuilder(
      opaque: false,
      pageBuilder: (context, _, __) {
        return AskModal(
          question: question,
        );
      },
    ),
  );
}

class AskModal extends StatelessWidget {
  final String question;

  const AskModal({
    Key? key,
    required this.question,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      alignment: Alignment.center,
      child: Card(
        child: Container(
          color: Colors.white,
          width: double.infinity,
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(question),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, 'ok');
                    },
                    child: const Text('ok'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, 'annuler');
                    },
                    child: const Text('annuler'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
