import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:ionicons/ionicons.dart';

class QuizCategory {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  QuizCategory({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}

final List<QuizCategory> quizCategories = [
  QuizCategory(
    id: 'any',
    title: 'Any Category',
    description: 'Random questions',
    icon: PhosphorIcons.shuffleAngular(PhosphorIconsStyle.fill),
    color: const Color(0xFF6C5CE7),
  ),
  QuizCategory(
    id: '9',
    title: 'General Knowledge',
    description: 'Test your general knowledge',
    icon: PhosphorIcons.brain(PhosphorIconsStyle.fill),
    color: const Color(0xFF00B894),
  ),
  QuizCategory(
    id: '10',
    title: 'Books',
    description: 'Entertainment: Books',
    icon: PhosphorIcons.book(PhosphorIconsStyle.fill),
    color: const Color(0xFFE17055),
  ),
  QuizCategory(
    id: '11',
    title: 'Film',
    description: 'Entertainment: Film',
    icon: PhosphorIcons.filmSlate(PhosphorIconsStyle.fill),
    color: const Color(0xFF0984E3),
  ),
  QuizCategory(
    id: '12',
    title: 'Music',
    description: 'Entertainment: Music',
    icon: PhosphorIcons.musicNotes(PhosphorIconsStyle.fill),
    color: const Color(0xFFD63031),
  ),
  QuizCategory(
    id: '13',
    title: 'Musicals & Theatres',
    description: 'Entertainment',
    icon: PhosphorIcons.maskHappy(PhosphorIconsStyle.fill),
    color: const Color(0xFF00CEC9),
  ),
  QuizCategory(
    id: '14',
    title: 'Television',
    description: 'Entertainment: TV',
    icon: PhosphorIcons.television(PhosphorIconsStyle.fill),
    color: const Color(0xFFFD79A8),
  ),
  QuizCategory(
    id: '15',
    title: 'Video Games',
    description: 'Entertainment: Gaming',
    icon: PhosphorIcons.gameController(PhosphorIconsStyle.fill),
    color: const Color(0xFFFDCB6E),
  ),
  QuizCategory(
    id: '16',
    title: 'Board Games',
    description: 'Entertainment',
    icon: PhosphorIcons.diceFive(PhosphorIconsStyle.fill),
    color: const Color(0xFFA29BFE),
  ),
  QuizCategory(
    id: '17',
    title: 'Science & Nature',
    description: 'Natural sciences',
    icon: PhosphorIcons.atom(PhosphorIconsStyle.fill),
    color: const Color(0xFF55EFC4),
  ),
  QuizCategory(
    id: '18',
    title: 'Computers',
    description: 'Science: Computers',
    icon: PhosphorIcons.desktop(PhosphorIconsStyle.fill),
    color: const Color(0xFF74B9FF),
  ),
  QuizCategory(
    id: '19',
    title: 'Mathematics',
    description: 'Science: Mathematics',
    icon: PhosphorIcons.mathOperations(PhosphorIconsStyle.fill),
    color: const Color(0xFFFF7675),
  ),
  QuizCategory(
    id: '20',
    title: 'Mythology',
    description: 'Ancient myths & legends',
    icon: PhosphorIcons.lightning(PhosphorIconsStyle.fill),
    color: const Color(0xFFFAB1A0),
  ),
  QuizCategory(
    id: '21',
    title: 'Sports',
    description: 'Athletic knowledge',
    icon: PhosphorIcons.soccerBall(PhosphorIconsStyle.fill),
    color: const Color(0xFF81ECEC),
  ),
  QuizCategory(
    id: '22',
    title: 'Geography',
    description: 'Discover the world',
    icon: PhosphorIcons.globe(PhosphorIconsStyle.fill),
    color: const Color(0xFFDFE6E9),
  ),
  QuizCategory(
    id: '23',
    title: 'History',
    description: 'Journey through time',
    icon: PhosphorIcons.clockCounterClockwise(PhosphorIconsStyle.fill),
    color: const Color(0xFFFF6348),
  ),
  QuizCategory(
    id: '24',
    title: 'Politics',
    description: 'Political knowledge',
    icon: PhosphorIcons.gavel(PhosphorIconsStyle.fill),
    color: const Color(0xFF2D3436),
  ),
  QuizCategory(
    id: '25',
    title: 'Art',
    description: 'Artistic knowledge',
    icon: PhosphorIcons.palette(PhosphorIconsStyle.fill),
    color: const Color(0xFFE17055),
  ),
  QuizCategory(
    id: '26',
    title: 'Celebrities',
    description: 'Famous people',
    icon: PhosphorIcons.star(PhosphorIconsStyle.fill),
    color: const Color(0xFFFDCB6E),
  ),
  QuizCategory(
    id: '27',
    title: 'Animals',
    description: 'Wildlife & pets',
    icon: PhosphorIcons.dog(PhosphorIconsStyle.fill),
    color: const Color(0xFF00B894),
  ),
  QuizCategory(
    id: '28',
    title: 'Vehicles',
    description: 'Cars, planes & more',
    icon: PhosphorIcons.car(PhosphorIconsStyle.fill),
    color: const Color(0xFF636E72),
  ),
  QuizCategory(
    id: '29',
    title: 'Comics',
    description: 'Entertainment: Comics',
    icon: PhosphorIcons.bookOpen(PhosphorIconsStyle.fill),
    color: const Color(0xFFFF7675),
  ),
  QuizCategory(
    id: '30',
    title: 'Gadgets',
    description: 'Science: Gadgets',
    icon: PhosphorIcons.cpu(PhosphorIconsStyle.fill),
    color: const Color(0xFF74B9FF),
  ),
  QuizCategory(
    id: '31',
    title: 'Anime & Manga',
    description: 'Japanese entertainment',
    icon: Ionicons.sparkles,
    color: const Color(0xFFFD79A8),
  ),
  QuizCategory(
    id: '32',
    title: 'Cartoons & Animations',
    description: 'Animated entertainment',
    icon: PhosphorIcons.smiley(PhosphorIconsStyle.fill),
    color: const Color(0xFFA29BFE),
  ),
];

