import 'package:flutter/material.dart';

class Question {
  final String questionText;
  final List<String> options;
  final int correctOptionIndex;

  Question({
    required this.questionText,
    required this.options,
    required this.correctOptionIndex,
  });
}

class Course {
  final String id;
  final String title;
  final String description;
  final String iconEmoji;
  final Color color;
  final int totalLessons;
  final int completedLessons;
  final List<Question> questions;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.iconEmoji,
    required this.color,
    required this.totalLessons,
    required this.completedLessons,
    required this.questions,
  });
}

// Mock Data
final List<Course> mockCourses = [
  Course(
    id: '1',
    title: 'İngilizce Temel',
    description: 'Günlük konuşma ve temel kelimeler',
    iconEmoji: '🇬🇧',
    color: const Color(0xFF58CC02),
    totalLessons: 10,
    completedLessons: 3,
    questions: [
      Question(
        questionText: '"Elma" kelimesinin İngilizcesi nedir?',
        options: ['Banana', 'Apple', 'Orange', 'Grape'],
        correctOptionIndex: 1,
      ),
      Question(
        questionText: '"Kedi" kelimesinin İngilizcesi nedir?',
        options: ['Dog', 'Bird', 'Cat', 'Fish'],
        correctOptionIndex: 2,
      ),
      Question(
        questionText: 'Aşağıdakilerden hangisi bir renktir?',
        options: ['Table', 'Red', 'Run', 'Fast'],
        correctOptionIndex: 1,
      ),
    ],
  ),
  Course(
    id: '2',
    title: 'İspanyolca Giriş',
    description: 'Hola! İspanyolca öğrenmeye başla',
    iconEmoji: '🇪🇸',
    color: const Color(0xFFCE82FF),
    totalLessons: 12,
    completedLessons: 0,
    questions: [
      Question(
        questionText: '"Merhaba" İspanyolca nasıl denir?',
        options: ['Hola', 'Adiós', 'Gracias', 'Por favor'],
        correctOptionIndex: 0,
      ),
    ],
  ),
  Course(
    id: '3',
    title: 'Fransızca A1',
    description: 'Romantik dilin temelleri',
    iconEmoji: '🇫🇷',
    color: const Color(0xFFFF4B4B),
    totalLessons: 8,
    completedLessons: 1,
    questions: [
      Question(
        questionText: '"Teşekkürler" Fransızca nasıl denir?',
        options: ['Bonjour', 'Merci', 'Oui', 'Non'],
        correctOptionIndex: 1,
      ),
    ],
  ),
];
