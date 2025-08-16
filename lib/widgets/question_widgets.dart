import 'package:flutter/material.dart';
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
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Auto-focus the input field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

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
        
        const SizedBox(height: 40),
        
        // Answer input
        SizedBox(
          width: widget.isTablet ? 200 : 150,
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: widget.isTablet ? 32 : 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1976D2),
            ),
            decoration: InputDecoration(
              hintText: '?',
              hintStyle: TextStyle(
                color: Colors.grey[400],
                fontSize: widget.isTablet ? 32 : 24,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Color(0xFF1976D2), width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Color(0xFF1976D2), width: 3),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(
                vertical: widget.isTablet ? 20 : 15,
                horizontal: 20,
              ),
            ),
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                widget.onSubmit(value);
              }
            },
          ),
        ),
        
        const SizedBox(height: 40),
        
        // Submit button
        SizedBox(
          width: widget.isTablet ? 200 : 150,
          child: ElevatedButton(
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                widget.onSubmit(_controller.text);
              }
            },
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
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late List<Map<String, dynamic>> patternData;

  @override
  void initState() {
    super.initState();
    _generatePatternData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _generatePatternData() {
    final table = widget.question.multiplicand;
    final targetMultiplier = widget.question.multiplier;
    
    // Create a pattern with 3 examples and 1 missing
    patternData = [];
    
    // Add 2 examples before the target
    for (int i = 1; i <= 2; i++) {
      patternData.add({
        'equation': '$table ÷ $table',
        'answer': i,
        'isTarget': false,
      });
    }
    
    // Add the target question (missing answer)
    patternData.add({
      'equation': '${table * targetMultiplier} ÷ $table',
      'answer': null,
      'isTarget': true,
    });
    
    // Add one more example after
    if (targetMultiplier < 12) {
      patternData.add({
        'equation': '${table * (targetMultiplier + 1)} ÷ $table',
        'answer': targetMultiplier + 1,
        'isTarget': false,
      });
    }
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
        
        // Answer input
        SizedBox(
          width: widget.isTablet ? 150 : 120,
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: widget.isTablet ? 28 : 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1976D2),
            ),
            decoration: InputDecoration(
              hintText: '?',
              hintStyle: TextStyle(
                color: Colors.grey[400],
                fontSize: widget.isTablet ? 28 : 24,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Color(0xFF2196F3), width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Color(0xFF2196F3), width: 3),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(
                vertical: widget.isTablet ? 15 : 12,
                horizontal: 15,
              ),
            ),
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                widget.onSubmit(value);
              }
            },
          ),
        ),
        
        const SizedBox(height: 30),
        
        // Submit button
        SizedBox(
          width: widget.isTablet ? 200 : 150,
          child: ElevatedButton(
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                widget.onSubmit(_controller.text);
              }
            },
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

