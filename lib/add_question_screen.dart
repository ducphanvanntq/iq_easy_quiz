import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AddQuestionScreen extends StatefulWidget {
  const AddQuestionScreen({super.key});

  @override
  State<AddQuestionScreen> createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  static const Color primaryColor = Color(0xFF06A8E8);
  static const Color secondaryColor = Color(0xFF00C9D7);

  int currentStep = 0;
  final PageController _pageController = PageController();

  String? selectedCategory;
  String? selectedCategoryTitle;
  String? selectedDifficulty;
  String? selectedQuestionType;
  
  final _questionController = TextEditingController();
  final _answer1Controller = TextEditingController();
  final _answer2Controller = TextEditingController();
  final _answer3Controller = TextEditingController();
  final _answer4Controller = TextEditingController();
  
  int? selectedCorrectAnswerIndex;

  final List<Map<String, String>> categories = [
    {'id': '9', 'title': 'General Knowledge'},
    {'id': '10', 'title': 'Books'},
    {'id': '11', 'title': 'Film'},
    {'id': '12', 'title': 'Music'},
    {'id': '13', 'title': 'Musicals & Theatres'},
    {'id': '14', 'title': 'Television'},
    {'id': '15', 'title': 'Video Games'},
    {'id': '16', 'title': 'Board Games'},
    {'id': '17', 'title': 'Science & Nature'},
    {'id': '18', 'title': 'Computers'},
    {'id': '19', 'title': 'Mathematics'},
    {'id': '20', 'title': 'Mythology'},
    {'id': '21', 'title': 'Sports'},
    {'id': '22', 'title': 'Geography'},
    {'id': '23', 'title': 'History'},
    {'id': '24', 'title': 'Politics'},
    {'id': '25', 'title': 'Art'},
    {'id': '26', 'title': 'Celebrities'},
    {'id': '27', 'title': 'Animals'},
    {'id': '28', 'title': 'Vehicles'},
    {'id': '29', 'title': 'Comics'},
    {'id': '30', 'title': 'Gadgets'},
    {'id': '31', 'title': 'Anime & Manga'},
    {'id': '32', 'title': 'Cartoons & Animations'},
  ];

  final List<Map<String, dynamic>> difficulties = [
    {
      'id': 'easy',
      'title': 'Easy',
      'icon': PhosphorIcons.smiley(PhosphorIconsStyle.fill),
      'color': Colors.green,
      'description': 'Perfect for beginners',
    },
    {
      'id': 'medium',
      'title': 'Medium',
      'icon': PhosphorIcons.lightbulb(PhosphorIconsStyle.fill),
      'color': Colors.orange,
      'description': 'A good challenge',
    },
    {
      'id': 'hard',
      'title': 'Hard',
      'icon': PhosphorIcons.fire(PhosphorIconsStyle.fill),
      'color': Colors.red,
      'description': 'For the experts',
    },
  ];

  final List<Map<String, dynamic>> questionTypes = [
    {
      'id': 'multiple',
      'title': 'Multiple Choice',
      'icon': PhosphorIcons.listChecks(PhosphorIconsStyle.fill),
      'description': '4 answer options',
    },
    {
      'id': 'boolean',
      'title': 'True / False',
      'icon': PhosphorIcons.checkSquare(PhosphorIconsStyle.fill),
      'description': 'Only 2 options',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    _questionController.dispose();
    _answer1Controller.dispose();
    _answer2Controller.dispose();
    _answer3Controller.dispose();
    _answer4Controller.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (currentStep < 4) {
      setState(() {
        currentStep++;
      });
      _pageController.animateToPage(
        currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
      _pageController.animateToPage(
        currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _submitQuestion() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
                color: Colors.green,
                size: 28,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Success!',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        content: Text(
          'Your question has been added successfully!',
          style: GoogleFonts.poppins(
            fontSize: 15,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(
              'OK',
              style: GoogleFonts.poppins(
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          'Add Question',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            PhosphorIcons.caretLeft(PhosphorIconsStyle.bold),
            color: Colors.white,
          ),
          onPressed: () {
            if (currentStep > 0) {
              _previousStep();
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (int i = 0; i < 5; i++)
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                            left: i == 0 ? 0 : 4,
                            right: i == 4 ? 0 : 4,
                          ),
                          height: 4,
                          decoration: BoxDecoration(
                            color: i <= currentStep ? primaryColor : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Step ${currentStep + 1} of 5',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildCategoryStep(),
                _buildDifficultyStep(),
                _buildQuestionTypeStep(),
                _buildQuestionAnswersStep(),
                _buildCorrectAnswerStep(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  PhosphorIcons.tag(PhosphorIconsStyle.fill),
                  color: primaryColor,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Select Category',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Choose the category for your question',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 24),
          ...categories.map((category) {
            final isSelected = selectedCategory == category['id'];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCategory = category['id'];
                    selectedCategoryTitle = category['title'];
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor.withOpacity(0.1) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? primaryColor : Colors.grey.shade300,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          category['title']!,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                            color: isSelected ? primaryColor : Colors.grey.shade800,
                          ),
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
                          color: primaryColor,
                          size: 24,
                        ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
          const SizedBox(height: 20),
          _buildNextButton(selectedCategory != null),
        ],
      ),
    );
  }

  Widget _buildDifficultyStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  PhosphorIcons.chartBar(PhosphorIconsStyle.fill),
                  color: primaryColor,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Select Difficulty',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Choose how difficult your question is',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 24),
          ...difficulties.map((difficulty) {
            final isSelected = selectedDifficulty == difficulty['id'];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDifficulty = difficulty['id'] as String;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? (difficulty['color'] as Color).withOpacity(0.1)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected
                          ? (difficulty['color'] as Color)
                          : Colors.grey.shade300,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: (difficulty['color'] as Color).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          difficulty['icon'] as IconData,
                          color: difficulty['color'] as Color,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              difficulty['title'] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800,
                              ),
                            ),
                            Text(
                              difficulty['description'] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
                          color: difficulty['color'] as Color,
                          size: 28,
                        ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
          const SizedBox(height: 20),
          _buildNextButton(selectedDifficulty != null),
        ],
      ),
    );
  }

  Widget _buildQuestionTypeStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  PhosphorIcons.listBullets(PhosphorIconsStyle.fill),
                  color: primaryColor,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Question Type',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Select the type of question',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 24),
          ...questionTypes.map((type) {
            final isSelected = selectedQuestionType == type['id'];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedQuestionType = type['id'] as String;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor.withOpacity(0.1) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? primaryColor : Colors.grey.shade300,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          type['icon'] as IconData,
                          color: primaryColor,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              type['title'] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800,
                              ),
                            ),
                            Text(
                              type['description'] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
                          color: primaryColor,
                          size: 28,
                        ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
          const SizedBox(height: 20),
          _buildNextButton(selectedQuestionType != null),
        ],
      ),
    );
  }

  Widget _buildQuestionAnswersStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  PhosphorIcons.question(PhosphorIconsStyle.fill),
                  color: primaryColor,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Question & Answers',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Write your question and 4 answer options',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 24),
          
          Text(
            'Question',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _questionController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Enter your question here...',
              hintStyle: GoogleFonts.poppins(
                color: Colors.grey.shade400,
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: primaryColor,
                  width: 2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          Text(
            'Answer Options',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 12),
          _buildAnswerField('A', _answer1Controller),
          const SizedBox(height: 12),
          _buildAnswerField('B', _answer2Controller),
          const SizedBox(height: 12),
          _buildAnswerField('C', _answer3Controller),
          const SizedBox(height: 12),
          _buildAnswerField('D', _answer4Controller),
          const SizedBox(height: 24),
          
          _buildNextButton(
            _questionController.text.trim().isNotEmpty &&
            _answer1Controller.text.trim().isNotEmpty &&
            _answer2Controller.text.trim().isNotEmpty &&
            _answer3Controller.text.trim().isNotEmpty &&
            _answer4Controller.text.trim().isNotEmpty,
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerField(String label, TextEditingController controller) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextField(
            controller: controller,
            onChanged: (value) => setState(() {}),
            decoration: InputDecoration(
              hintText: 'Enter answer $label',
              hintStyle: GoogleFonts.poppins(
                color: Colors.grey.shade400,
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: primaryColor,
                  width: 2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCorrectAnswerStep() {
    final answers = [
      {'label': 'A', 'text': _answer1Controller.text},
      {'label': 'B', 'text': _answer2Controller.text},
      {'label': 'C', 'text': _answer3Controller.text},
      {'label': 'D', 'text': _answer4Controller.text},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
                  color: Colors.green,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Select Correct Answer',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Which answer is correct?',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 24),
          
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Question:',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _questionController.text,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          ...List.generate(4, (index) {
            final isSelected = selectedCorrectAnswerIndex == index;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCorrectAnswerIndex = index;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.green.withOpacity(0.1) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? Colors.green : Colors.grey.shade300,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.green
                              : Colors.grey.shade200,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          answers[index]['label']!,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.grey.shade600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          answers[index]['text']!,
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                            color: isSelected ? Colors.green.shade700 : Colors.grey.shade800,
                          ),
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
                          color: Colors.green,
                          size: 24,
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 24),
          
          Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: selectedCorrectAnswerIndex != null
                    ? [primaryColor, secondaryColor]
                    : [Colors.grey.shade400, Colors.grey.shade400],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: selectedCorrectAnswerIndex != null
                  ? [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ]
                  : null,
            ),
            child: ElevatedButton(
              onPressed: selectedCorrectAnswerIndex != null ? _submitQuestion : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    PhosphorIcons.plusCircle(PhosphorIconsStyle.fill),
                    color: Colors.white,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Submit Question',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextButton(bool enabled) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: enabled
              ? [primaryColor, secondaryColor]
              : [Colors.grey.shade400, Colors.grey.shade400],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: enabled
            ? [
                BoxShadow(
                  color: primaryColor.withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ]
            : null,
      ),
      child: ElevatedButton(
        onPressed: enabled ? _nextStep : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Next',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(width: 12),
            Icon(
              PhosphorIcons.caretRight(PhosphorIconsStyle.bold),
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
