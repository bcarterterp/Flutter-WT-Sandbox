import 'package:equatable/equatable.dart';

class Recipe extends Equatable {
  const Recipe({required this.id, this.title, this.image});

  final int id;
  final String? title;
  final String? image;

  @override
  List<Object?> get props => [id, title, image];
}
