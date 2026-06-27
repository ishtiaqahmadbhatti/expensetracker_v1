import 'package:flutter/material.dart';
import '../models/transaction.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Transaction> _transactions = [
    Transaction(
      id: '1',
      title: 'Salary Credit',
      amount: 4500.0,
      date: DateTime.now().subtract(const Duration(days: 1)),
      category: 'Income',
      icon: Icons.wallet,
      iconColor: const Color(0xFF10B981),
      isIncome: true,
    ),
    Transaction(
      id: '2',
      title: 'Grocery Store',
      amount: 120.5,
      date: DateTime.now().subtract(const Duration(hours: 3)),
      category: 'Food',
      icon: Icons.shopping_basket_outlined,
      iconColor: const Color(0xFFF59E0B),
    ),
    Transaction(
      id: '3',
      title: 'Netflix Subscription',
      amount: 15.99,
      date: DateTime.now().subtract(const Duration(days: 2)),
      category: 'Entertainment',
      icon: Icons.movie_creation_outlined,
      iconColor: const Color(0xFFEF4444),
    ),
    Transaction(
      id: '4',
      title: 'Gym Membership',
      amount: 50.0,
      date: DateTime.now().subtract(const Duration(days: 3)),
      category: 'Health',
      icon: Icons.fitness_center,
      iconColor: const Color(0xFF06B6D4),
    ),
  ];

  double get _totalIncome => _transactions
      .where((t) => t.isIncome)
      .fold(0.0, (sum, t) => sum + t.amount);

  double get _totalExpenses => _transactions
      .where((t) => !t.isIncome)
      .fold(0.0, (sum, t) => sum + t.amount);

  double get _netBalance => _totalIncome - _totalExpenses;

  void _addTransaction(Transaction transaction) {
    setState(() {
      _transactions.insert(0, transaction);
    });
  }

  void _showAddTransactionSheet() {
    final titleController = TextEditingController();
    final amountController = TextEditingController();
    String selectedCategory = 'Food';
    bool isIncome = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1E293B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 24,
                right: 24,
                top: 24,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Add Transaction',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white60),
                          onPressed: () => Navigator.of(context).pop(),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Income / Expense Selector
                    Row(
                      children: [
                        Expanded(
                          child: ChoiceChip(
                            label: const Center(
                              child: Text('Expense'),
                            ),
                            selected: !isIncome,
                            selectedColor: const Color(0xFFEF4444).withValues(alpha: 0.2),
                            labelStyle: TextStyle(
                              color: !isIncome ? const Color(0xFFEF4444) : Colors.white60,
                              fontWeight: FontWeight.bold,
                            ),
                            onSelected: (selected) {
                              if (selected) {
                                setModalState(() => isIncome = false);
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ChoiceChip(
                            label: const Center(
                              child: Text('Income'),
                            ),
                            selected: isIncome,
                            selectedColor: const Color(0xFF10B981).withValues(alpha: 0.2),
                            labelStyle: TextStyle(
                              color: isIncome ? const Color(0xFF10B981) : Colors.white60,
                              fontWeight: FontWeight.bold,
                            ),
                            onSelected: (selected) {
                              if (selected) {
                                setModalState(() => isIncome = true);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: const TextStyle(color: Colors.white60),
                        filled: true,
                        fillColor: const Color(0xFF0B0F19),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: amountController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelText: 'Amount (\$)',
                        labelStyle: const TextStyle(color: Colors.white60),
                        filled: true,
                        fillColor: const Color(0xFF0B0F19),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    // Category selector dropdown
                    const Text(
                      'Category',
                      style: TextStyle(color: Colors.white60, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0B0F19),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedCategory,
                          dropdownColor: const Color(0xFF0B0F19),
                          isExpanded: true,
                          style: const TextStyle(color: Colors.white),
                          items: <String>['Food', 'Entertainment', 'Health', 'Transport', 'Shopping', 'Salary', 'Other']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setModalState(() => selectedCategory = newValue);
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF10B981),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        final title = titleController.text.trim();
                        final amount = double.tryParse(amountController.text) ?? 0.0;
                        if (title.isNotEmpty && amount > 0) {
                          IconData trIcon = Icons.help_outline;
                          Color trColor = Colors.grey;

                          switch (selectedCategory) {
                            case 'Food':
                              trIcon = Icons.shopping_basket_outlined;
                              trColor = const Color(0xFFF59E0B);
                              break;
                            case 'Entertainment':
                              trIcon = Icons.movie_creation_outlined;
                              trColor = const Color(0xFFEF4444);
                              break;
                            case 'Health':
                              trIcon = Icons.fitness_center;
                              trColor = const Color(0xFF06B6D4);
                              break;
                            case 'Transport':
                              trIcon = Icons.directions_car_filled_outlined;
                              trColor = const Color(0xFF3B82F6);
                              break;
                            case 'Shopping':
                              trIcon = Icons.local_mall_outlined;
                              trColor = const Color(0xFFEC4899);
                              break;
                            case 'Salary':
                              trIcon = Icons.wallet;
                              trColor = const Color(0xFF10B981);
                              break;
                            default:
                              trIcon = Icons.payment_outlined;
                              trColor = const Color(0xFF8B5CF6);
                          }

                          final newTx = Transaction(
                            id: DateTime.now().toString(),
                            title: title,
                            amount: amount,
                            date: DateTime.now(),
                            category: selectedCategory,
                            icon: trIcon,
                            iconColor: trColor,
                            isIncome: isIncome,
                          );

                          _addTransaction(newTx);
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text(
                        'Save Transaction',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: const Color(0xFF3B82F6).withValues(alpha: 0.2),
                          child: const Text(
                            'JD',
                            style: TextStyle(
                              color: Color(0xFF3B82F6),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome back,',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.5),
                                fontSize: 14,
                              ),
                            ),
                            const Text(
                              'John Doe',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E293B),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                      ),
                      child: const Icon(
                        Icons.notifications_none,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // Premium Balance Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF0F766E), // Dark Teal
                        Color(0xFF111827), // Deep Navy
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF0F766E).withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Balance',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$${_netBalance.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Income Stats
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF10B981).withValues(alpha: 0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.arrow_downward,
                                  color: Color(0xFF10B981),
                                  size: 18,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Income',
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.5),
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '\$${_totalIncome.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      color: Color(0xFF10B981),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // Expense Stats
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEF4444).withValues(alpha: 0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.arrow_upward,
                                  color: Color(0xFFEF4444),
                                  size: 18,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Expenses',
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.5),
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '\$${_totalExpenses.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      color: Color(0xFFEF4444),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // Analytics Graph Title & Graphic
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Activity Chart',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'This Week',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  height: 150,
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                  ),
                  child: CustomPaint(
                    painter: ChartPainter(),
                  ),
                ),
                const SizedBox(height: 28),

                // Recent Transactions Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recent Transactions',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'See All',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Transactions List
                _transactions.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Text(
                            'No transactions added yet.',
                            style: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
                          ),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _transactions.length,
                        itemBuilder: (context, index) {
                          final tx = _transactions[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E293B).withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.white.withValues(alpha: 0.02)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: tx.iconColor.withValues(alpha: 0.12),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(
                                        tx.icon,
                                        color: tx.iconColor,
                                        size: 24,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          tx.title,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          tx.category,
                                          style: TextStyle(
                                            color: Colors.white.withValues(alpha: 0.5),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${tx.isIncome ? '+' : '-'} \$${tx.amount.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        color: tx.isIncome ? const Color(0xFF10B981) : Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${tx.date.day}/${tx.date.month}',
                                      style: TextStyle(
                                        color: Colors.white.withValues(alpha: 0.4),
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTransactionSheet,
        backgroundColor: const Color(0xFF10B981),
        foregroundColor: Colors.white,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }
}

// Custom Painter for a premium line chart
class ChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Draw guide lines
    final linePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 1.0;

    for (int i = 1; i <= 3; i++) {
      double y = size.height * (i / 4);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }

    // Chart path points
    final points = [
      Offset(0, size.height * 0.8),
      Offset(size.width * 0.2, size.height * 0.75),
      Offset(size.width * 0.4, size.height * 0.4),
      Offset(size.width * 0.6, size.height * 0.6),
      Offset(size.width * 0.8, size.height * 0.25),
      Offset(size.width, size.height * 0.3),
    ];

    // Create gradient fill path
    final fillPath = Path()
      ..moveTo(points.first.dx, size.height)
      ..lineTo(points.first.dx, points.first.dy);

    for (int i = 1; i < points.length; i++) {
      // Use smooth Bezier curve
      final p1 = points[i - 1];
      final p2 = points[i];
      final controlPoint1 = Offset(p1.dx + (p2.dx - p1.dx) / 2, p1.dy);
      final controlPoint2 = Offset(p1.dx + (p2.dx - p1.dx) / 2, p2.dy);
      fillPath.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx, controlPoint2.dy, p2.dx, p2.dy);
    }
    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    // Paint the gradient fill
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        const Color(0xFF10B981).withValues(alpha: 0.3),
        const Color(0xFF10B981).withValues(alpha: 0.0),
      ],
    );

    final fillPaint = Paint()
      ..shader = gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;
    canvas.drawPath(fillPath, fillPaint);

    // Draw the main line
    final strokePath = Path()..moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      final p1 = points[i - 1];
      final p2 = points[i];
      final controlPoint1 = Offset(p1.dx + (p2.dx - p1.dx) / 2, p1.dy);
      final controlPoint2 = Offset(p1.dx + (p2.dx - p1.dx) / 2, p2.dy);
      strokePath.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx, controlPoint2.dy, p2.dx, p2.dy);
    }

    final strokePaint = Paint()
      ..color = const Color(0xFF10B981)
      ..strokeWidth = 3.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(strokePath, strokePaint);

    // Draw data points/dots
    final dotOutlinePaint = Paint()
      ..color = const Color(0xFF1E293B)
      ..style = PaintingStyle.fill;
    final dotPaint = Paint()
      ..color = const Color(0xFF10B981)
      ..style = PaintingStyle.fill;

    for (var point in points) {
      canvas.drawCircle(point, 6.0, dotOutlinePaint);
      canvas.drawCircle(point, 4.0, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
