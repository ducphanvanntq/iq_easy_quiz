import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'services/statistics_service.dart';
import 'package:intl/intl.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  static const Color primaryColor = Color(0xFF06A8E8);
  static const Color secondaryColor = Color(0xFF00C9D7);

  bool isLoading = true;
  Map<String, dynamic> overallStats = {};
  Map<String, int> quizzesByDifficulty = {};
  Map<String, double> avgScoreByDifficulty = {};
  Map<String, int> topCategories = {};
  List<Map<String, dynamic>> last7DaysActivity = [];
  Map<String, dynamic> missionStats = {};

  @override
  void initState() {
    super.initState();
    _loadStatistics();
  }

  Future<void> _loadStatistics() async {
    setState(() {
      isLoading = true;
    });

    final stats = await Future.wait([
      StatisticsService.getOverallStats(),
      StatisticsService.getQuizzesByDifficulty(),
      StatisticsService.getAverageScoreByDifficulty(),
      StatisticsService.getTopCategories(),
      StatisticsService.getLast7DaysActivity(),
      StatisticsService.getMissionStats(),
    ]);

    setState(() {
      overallStats = stats[0] as Map<String, dynamic>;
      quizzesByDifficulty = stats[1] as Map<String, int>;
      avgScoreByDifficulty = stats[2] as Map<String, double>;
      topCategories = stats[3] as Map<String, int>;
      last7DaysActivity = stats[4] as List<Map<String, dynamic>>;
      missionStats = stats[5] as Map<String, dynamic>;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: Colors.grey.shade50,
        body: Center(
          child: CircularProgressIndicator(color: primaryColor),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [primaryColor, secondaryColor],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 40, 20, 12),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            PhosphorIcons.chartBar(PhosphorIconsStyle.fill),
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Statistics',
                                style: GoogleFonts.poppins(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Your performance overview',
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildOverviewCards(),
                const SizedBox(height: 16),
                _buildQuizDistributionChart(),
                const SizedBox(height: 16),
                _buildScoreByDifficultyChart(),
                const SizedBox(height: 16),
                _buildActivityChart(),
                const SizedBox(height: 16),
                _buildTopCategoriesChart(),
                const SizedBox(height: 16),
                _buildMissionCompletionChart(),
                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCards() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: PhosphorIcons.target(PhosphorIconsStyle.fill),
            title: 'Quizzes',
            value: '${overallStats['totalQuizzes'] ?? 0}',
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            icon: PhosphorIcons.trophy(PhosphorIconsStyle.fill),
            title: 'Avg Score',
            value: '${overallStats['averageScore'] ?? 0}%',
            color: Colors.amber,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            icon: PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
            title: 'Missions',
            value: '${overallStats['missionCompletionRate'] ?? 0}%',
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizDistributionChart() {
    final total = (quizzesByDifficulty['easy'] ?? 0) +
        (quizzesByDifficulty['medium'] ?? 0) +
        (quizzesByDifficulty['hard'] ?? 0);

    if (total == 0) {
      return _buildEmptyChart('No quiz data available');
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                PhosphorIcons.chartPie(PhosphorIconsStyle.fill),
                color: primaryColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Quiz Distribution',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 40,
                sections: [
                  PieChartSectionData(
                    value: (quizzesByDifficulty['easy'] ?? 0).toDouble(),
                    color: Colors.green,
                    title: '${quizzesByDifficulty['easy'] ?? 0}',
                    radius: 50,
                    titleStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  PieChartSectionData(
                    value: (quizzesByDifficulty['medium'] ?? 0).toDouble(),
                    color: Colors.orange,
                    title: '${quizzesByDifficulty['medium'] ?? 0}',
                    radius: 50,
                    titleStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  PieChartSectionData(
                    value: (quizzesByDifficulty['hard'] ?? 0).toDouble(),
                    color: Colors.red,
                    title: '${quizzesByDifficulty['hard'] ?? 0}',
                    radius: 50,
                    titleStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildLegendItem('Easy', Colors.green),
              _buildLegendItem('Medium', Colors.orange),
              _buildLegendItem('Hard', Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScoreByDifficultyChart() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                PhosphorIcons.chartLineUp(PhosphorIconsStyle.fill),
                color: primaryColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Average Score by Difficulty',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 100,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const titles = ['Easy', 'Medium', 'Hard'];
                        if (value.toInt() < titles.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              titles[value.toInt()],
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '${value.toInt()}%',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: Colors.grey.shade600,
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 25,
                ),
                borderData: FlBorderData(show: false),
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(
                        toY: avgScoreByDifficulty['easy'] ?? 0,
                        color: Colors.green,
                        width: 40,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [
                      BarChartRodData(
                        toY: avgScoreByDifficulty['medium'] ?? 0,
                        color: Colors.orange,
                        width: 40,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 2,
                    barRods: [
                      BarChartRodData(
                        toY: avgScoreByDifficulty['hard'] ?? 0,
                        color: Colors.red,
                        width: 40,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityChart() {
    if (last7DaysActivity.isEmpty) {
      return _buildEmptyChart('No activity data available');
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                PhosphorIcons.pulse(PhosphorIconsStyle.fill),
                color: primaryColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Last 7 Days Activity',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: Colors.grey.shade600,
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() >= 0 && value.toInt() < last7DaysActivity.length) {
                          final date = last7DaysActivity[value.toInt()]['date'] as DateTime;
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              DateFormat('E').format(date).substring(0, 1),
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: List.generate(
                      last7DaysActivity.length,
                      (index) => FlSpot(
                        index.toDouble(),
                        (last7DaysActivity[index]['quizzes'] as int).toDouble(),
                      ),
                    ),
                    isCurved: true,
                    color: primaryColor,
                    barWidth: 3,
                    dotData: const FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      color: primaryColor.withOpacity(0.1),
                    ),
                  ),
                  LineChartBarData(
                    spots: List.generate(
                      last7DaysActivity.length,
                      (index) => FlSpot(
                        index.toDouble(),
                        (last7DaysActivity[index]['missions'] as int).toDouble(),
                      ),
                    ),
                    isCurved: true,
                    color: Colors.amber,
                    barWidth: 3,
                    dotData: const FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      color: Colors.amber.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem('Quizzes', primaryColor),
              const SizedBox(width: 20),
              _buildLegendItem('Missions', Colors.amber),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopCategoriesChart() {
    if (topCategories.isEmpty) {
      return _buildEmptyChart('No category data available');
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                PhosphorIcons.star(PhosphorIconsStyle.fill),
                color: primaryColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Top Categories',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...topCategories.entries.map((entry) {
            final maxValue = topCategories.values.reduce((a, b) => a > b ? a : b);
            final percentage = (entry.value / maxValue);
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          entry.key,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '${entry.value}',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: percentage,
                      minHeight: 8,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildMissionCompletionChart() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                PhosphorIcons.listChecks(PhosphorIconsStyle.fill),
                color: primaryColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Mission Completion',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildMissionRow(
            'Easy',
            missionStats['easy']['completed'],
            missionStats['easy']['total'],
            Colors.green,
          ),
          const SizedBox(height: 12),
          _buildMissionRow(
            'Medium',
            missionStats['medium']['completed'],
            missionStats['medium']['total'],
            Colors.orange,
          ),
          const SizedBox(height: 12),
          _buildMissionRow(
            'Hard',
            missionStats['hard']['completed'],
            missionStats['hard']['total'],
            Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildMissionRow(String label, int completed, int total, Color color) {
    final percentage = total > 0 ? (completed / total) : 0.0;
    
    return Row(
      children: [
        SizedBox(
          width: 60,
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: percentage,
              minHeight: 12,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          '$completed/$total',
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyChart(String message) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Column(
          children: [
            Icon(
              PhosphorIcons.chartLineDown(PhosphorIconsStyle.regular),
              size: 48,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

