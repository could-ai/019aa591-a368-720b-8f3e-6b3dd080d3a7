import 'package:flutter/material.dart';
import 'package:couldai_user_app/models/course_model.dart';

class LessonScreen extends StatefulWidget {
  const LessonScreen({super.key});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  int _currentQuestionIndex = 0;
  int? _selectedOptionIndex;
  bool _isChecked = false;
  bool _isCorrect = false;

  @override
  Widget build(BuildContext context) {
    final course = ModalRoute.of(context)!.settings.arguments as Course;
    final question = course.questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: 12,
            child: LinearProgressIndicator(
              value: (_currentQuestionIndex + 1) / course.questions.length,
              backgroundColor: Colors.grey.shade200,
              color: course.color,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Doğru cevabı seçin',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Text(
                question.questionText,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: ListView.separated(
                itemCount: question.options.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return _buildOptionCard(index, question.options[index], question);
                },
              ),
            ),
            _buildBottomButton(course),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard(int index, String text, Question question) {
    bool isSelected = _selectedOptionIndex == index;
    Color borderColor = Colors.grey.shade300;
    Color backgroundColor = Colors.white;
    Color textColor = Colors.black87;

    if (_isChecked) {
      if (index == question.correctOptionIndex) {
        borderColor = Colors.green;
        backgroundColor = Colors.green.shade50;
        textColor = Colors.green.shade800;
      } else if (isSelected && index != question.correctOptionIndex) {
        borderColor = Colors.red;
        backgroundColor = Colors.red.shade50;
        textColor = Colors.red.shade800;
      }
    } else if (isSelected) {
      borderColor = Colors.blue;
      backgroundColor = Colors.blue.shade50;
      textColor = Colors.blue.shade800;
    }

    return GestureDetector(
      onTap: _isChecked ? null : () {
        setState(() {
          _selectedOptionIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 2),
          boxShadow: isSelected && !_isChecked
              ? [BoxShadow(color: Colors.blue.withOpacity(0.2), blurRadius: 8)]
              : [],
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                border: Border.all(color: borderColor),
                borderRadius: BorderRadius.circular(6),
                color: isSelected ? borderColor : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 16),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButton(Course course) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: _selectedOptionIndex == null ? null : () {
            if (_isChecked) {
              // Sonraki soruya geç
              if (_currentQuestionIndex < course.questions.length - 1) {
                setState(() {
                  _currentQuestionIndex++;
                  _selectedOptionIndex = null;
                  _isChecked = false;
                });
              } else {
                // Ders bitti
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Tebrikler! Dersi tamamladınız 🎉'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            } else {
              // Cevabı kontrol et
              setState(() {
                _isChecked = true;
                _isCorrect = _selectedOptionIndex == 
                    course.questions[_currentQuestionIndex].correctOptionIndex;
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: _isChecked 
                ? (_isCorrect ? Colors.green : Colors.red) 
                : Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
          ),
          child: Text(_isChecked 
              ? (_currentQuestionIndex < course.questions.length - 1 ? 'DEVAM ET' : 'BİTİR') 
              : 'KONTROL ET'),
        ),
      ),
    );
  }
}
