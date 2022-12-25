import 'package:flutter/material.dart';

class ZoomMeeting extends StatelessWidget {
  const ZoomMeeting({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Go To Zoom Meeting'),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  onPressed: () {}, child: const Text('JOIN MEETING')),
              const SizedBox(
                height: 30,
              ),
              const Text('OR copy the link bellow:'),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'https://gazaskygeeks.zoom.us/j/81507011523#success',
                style: TextStyle(color: Colors.blue),
              )
            ],
          ),
        ),
      ),
    );
  }
}
