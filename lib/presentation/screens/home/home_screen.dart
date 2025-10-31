import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Google Gemini')),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Text(
            'Welcome to the Google Gemini App!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            'This app demonstrates the integration of Google\'s Gemini model with Flutter. Explore the features and capabilities of Gemini through this application.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.push('/basic-prompt');
            },
            child: Text('Get Started'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.push('/chat-context');
            },
            child: Text('Chat conversacional'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.push('/image-playground');
            },
            child: Text('Imágenes con Gemini'),
          ),
        ],
      ),
    );
  }
}
