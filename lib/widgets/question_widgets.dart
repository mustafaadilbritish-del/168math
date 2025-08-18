import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import '../models/app_state.dart';

class TypeAnswerWidget extends StatefulWidget {
  final Question question;
  final Function(String) onSubmit;
  final bool isTablet;

  const TypeAnswerWidget({
    super.key,
    required this.question,
    required this.onSubmit,
    required this.isTablet,
  });

  @override
  State<TypeAnswerWidget> createState() => _TypeAnswerWidgetState();
}

class _TypeAnswerWidgetState extends State<TypeAnswerWidget> {
  String _inputValue = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Question text
        Text(
          'Type the answer',
          style: TextStyle(
            fontSize: widget.isTablet ? 24 : 20,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF7B1FA2),
          ),
        ),
        
        const SizedBox(height: 40),
        
        // Math equation
        Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Text(
            '${widget.question.multiplicand} × ${widget.question.multiplier} = ?',
            style: TextStyle(
              fontSize: widget.isTablet ? 36 : 28,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1976D2),
            ),
          ),
        ),
        
        const SizedBox(height: 30),
        
        // Display input
        Container(
          width: widget.isTablet ? 200 : 160,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: const Color(0xFF1976D2), width: 2),
          ),
          child: Center(
            child: Text(
              _inputValue.isEmpty ? '?' : _inputValue,
              style: TextStyle(
                fontSize: widget.isTablet ? 32 : 26,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1976D2),
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 20),
        
        // Number keypad
        SizedBox(
          width: widget.isTablet ? 320 : 260,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: ['1','2','3'].map((d) => _buildDigitButton(d)).toList(),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: ['4','5','6'].map((d) => _buildDigitButton(d)).toList(),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: ['7','8','9'].map((d) => _buildDigitButton(d)).toList(),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildActionButton('CLEAR', onPressed: () {
                    setState(() => _inputValue = '');
                  }),
                  _buildDigitButton('0'),
                  _buildActionButton('⌫', onPressed: () {
                    if (_inputValue.isNotEmpty) {
                      setState(() => _inputValue = _inputValue.substring(0, _inputValue.length - 1));
                    }
                  }),
                ],
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 30),
        
        // Submit button
        SizedBox(
          width: widget.isTablet ? 200 : 150,
          child: ElevatedButton(
            onPressed: _inputValue.isNotEmpty
                ? () {
                    widget.onSubmit(_inputValue);
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4CAF50),
              padding: EdgeInsets.symmetric(vertical: widget.isTablet ? 15 : 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Text(
              'CHECK',
              style: TextStyle(
                fontSize: widget.isTablet ? 20 : 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDigitButton(String digit) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: ElevatedButton(
          onPressed: () {
            setState(() => _inputValue = _inputValue + digit);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF1976D2),
            padding: EdgeInsets.symmetric(vertical: widget.isTablet ? 16 : 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Color(0xFF1976D2), width: 2),
            ),
          ),
          child: Text(
            digit,
            style: TextStyle(
              fontSize: widget.isTablet ? 22 : 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, {required VoidCallback onPressed}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2196F3),
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: widget.isTablet ? 16 : 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: widget.isTablet ? 16 : 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class MultipleChoiceWidget extends StatefulWidget {
  final Question question;
  final Function(String) onSubmit;
  final bool isTablet;

  const MultipleChoiceWidget({
    super.key,
    required this.question,
    required this.onSubmit,
    required this.isTablet,
  });

  @override
  State<MultipleChoiceWidget> createState() => _MultipleChoiceWidgetState();
}

class _MultipleChoiceWidgetState extends State<MultipleChoiceWidget> {
  int? selectedChoice;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Question text
        Text(
          'Select the answer',
          style: TextStyle(
            fontSize: widget.isTablet ? 24 : 20,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF7B1FA2),
          ),
        ),
        
        const SizedBox(height: 40),
        
        // Math equation
        Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Text(
            '${widget.question.multiplicand} × ${widget.question.multiplier} = ?',
            style: TextStyle(
              fontSize: widget.isTablet ? 36 : 28,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1976D2),
            ),
          ),
        ),
        
        const SizedBox(height: 40),
        
        // Answer choices
        for (final entry in widget.question.choices!.asMap().entries) ...[
          Builder(
            builder: (context) {
              final index = entry.key;
              final choice = entry.value;
              final isSelected = selectedChoice == index;
              
              return Container(
                margin: const EdgeInsets.only(bottom: 15),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedChoice = index;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected 
                        ? const Color(0xFF2196F3) 
                        : Colors.white,
                    foregroundColor: isSelected 
                        ? Colors.white 
                        : const Color(0xFF1976D2),
                    padding: EdgeInsets.symmetric(vertical: widget.isTablet ? 20 : 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(
                        color: isSelected 
                            ? const Color(0xFF2196F3) 
                            : const Color(0xFF1976D2),
                        width: 2,
                      ),
                    ),
                  ),
                  child: Text(
                    '$choice',
                    style: TextStyle(
                      fontSize: widget.isTablet ? 24 : 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
        
        const SizedBox(height: 30),
        
        // Submit button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: selectedChoice != null
                ? () {
                    widget.onSubmit(widget.question.choices![selectedChoice!].toString());
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4CAF50),
              padding: EdgeInsets.symmetric(vertical: widget.isTablet ? 15 : 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Text(
              'CHECK',
              style: TextStyle(
                fontSize: widget.isTablet ? 20 : 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FollowPatternWidget extends StatefulWidget {
  final Question question;
  final Function(String) onSubmit;
  final bool isTablet;

  const FollowPatternWidget({
    super.key,
    required this.question,
    required this.onSubmit,
    required this.isTablet,
  });

  @override
  State<FollowPatternWidget> createState() => _FollowPatternWidgetState();
}

class _FollowPatternWidgetState extends State<FollowPatternWidget> {
  late List<Map<String, dynamic>> patternData;
  late List<int> _options;
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _generatePatternData();
    _generateOptions();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _generatePatternData() {
    final int table = widget.question.multiplicand;
    final int targetMultiplier = widget.question.multiplier;
    const int maxMultiplier = 30;

    patternData = [];

    int start = targetMultiplier - 2;
    if (start < 1) start = 1;
    if (start + 3 > maxMultiplier) {
      final int adjusted = maxMultiplier - 3;
      start = adjusted < 1 ? 1 : adjusted;
    }

    for (int i = 0; i < 4; i++) {
      final int m = start + i;
      final bool isTarget = (m == targetMultiplier);
      patternData.add({
        'equation': '${table} × ${m}',
        'answer': isTarget ? null : table * m,
        'isTarget': isTarget,
      });
    }
  }

  void _generateOptions() {
    final int correct = widget.question.multiplicand * widget.question.multiplier;
    final int maxAnswer = widget.question.multiplicand * 30;
    final Set<int> optionSet = {correct};
    final random = Random();

    while (optionSet.length < 4) {
      int candidate;
      if (random.nextBool()) {
        candidate = (correct + (random.nextInt(11) - 5)).toInt(); // +/- 5
      } else {
        candidate = random.nextInt(maxAnswer) + 1; // 1..max
      }
      if (candidate > 0 && candidate != correct) {
        optionSet.add(candidate);
      }
    }

    _options = optionSet.toList()..shuffle(random);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Question text
        Text(
          'Follow the pattern',
          style: TextStyle(
            fontSize: widget.isTablet ? 24 : 20,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF7B1FA2),
          ),
        ),
        
        const SizedBox(height: 40),
        
        // Pattern table
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: patternData.map((data) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: data['isTarget'] 
                      ? const Color(0xFFE3F2FD) 
                      : Colors.grey[50],
                  borderRadius: BorderRadius.circular(10),
                  border: data['isTarget'] 
                      ? Border.all(color: const Color(0xFF2196F3), width: 2)
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data['equation'],
                      style: TextStyle(
                        fontSize: widget.isTablet ? 20 : 18,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1976D2),
                      ),
                    ),
                    if (data['isTarget'])
                      Container(
                        width: widget.isTablet ? 80 : 60,
                        height: widget.isTablet ? 40 : 35,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2196F3).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xFF2196F3),
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '?',
                            style: TextStyle(
                              fontSize: widget.isTablet ? 24 : 20,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF2196F3),
                            ),
                          ),
                        ),
                      )
                    else
                      Text(
                        '${data['answer']}',
                        style: TextStyle(
                          fontSize: widget.isTablet ? 20 : 18,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF4CAF50),
                        ),
                      ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        
        const SizedBox(height: 40),
        
        // Four square options (2x2)
        SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: _buildOptionButton(0)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildOptionButton(1)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _buildOptionButton(2)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildOptionButton(3)),
                ],
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 30),
        
        // Submit button
        SizedBox(
          width: widget.isTablet ? 200 : 150,
          child: ElevatedButton(
            onPressed: _selectedIndex != null
                ? () {
                    widget.onSubmit(_options[_selectedIndex!].toString());
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4CAF50),
              padding: EdgeInsets.symmetric(vertical: widget.isTablet ? 15 : 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Text(
              'CHECK',
              style: TextStyle(
                fontSize: widget.isTablet ? 20 : 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOptionButton(int index) {
    final bool isSelected = _selectedIndex == index;
    final int value = _options[index];
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? const Color(0xFF2196F3) : Colors.white,
        foregroundColor: isSelected ? Colors.white : const Color(0xFF1976D2),
        padding: EdgeInsets.symmetric(vertical: widget.isTablet ? 24 : 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(
            color: isSelected ? const Color(0xFF2196F3) : const Color(0xFF1976D2),
            width: 2,
          ),
        ),
      ),
      child: Text(
        '$value',
        style: TextStyle(
          fontSize: widget.isTablet ? 22 : 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

