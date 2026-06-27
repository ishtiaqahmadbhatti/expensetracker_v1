import 'package:flutter/material.dart';

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String category;
  final IconData icon;
  final Color iconColor;
  final bool isIncome;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    required this.icon,
    required this.iconColor,
    this.isIncome = false,
  });
}
