import 'package:hive/hive.dart';
part 'task.g.dart';

@HiveType(typeId: 1)
class Task
{
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String category;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final DateTime startTime;
  @HiveField(4)
  final String endTime;
  @HiveField(5)
  final String description;

  Task({required this.title,required this.category,required this.date,required this.startTime,required this.endTime,required this.description});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'category': category,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'description': description,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'] ?? '',
      category: json['category'] ?? '',
      date: json['date'] ?? DateTime.now(),
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      description: json['description'] ?? '',
    );
  }
}