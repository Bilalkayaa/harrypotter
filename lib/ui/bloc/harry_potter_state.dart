import 'package:equatable/equatable.dart';
import 'package:harrypotter/data/models/gryffindor_model.dart';
import 'package:harrypotter/data/models/spells_model.dart';
import 'package:harrypotter/data/models/staff_model.dart';
import 'package:harrypotter/data/models/student_model.dart';

abstract class HarryPotterState extends Equatable {
  @override
  List<Object> get props => [];
}

class HarryPotterInitial extends HarryPotterState {}

class HarryPotterLoading extends HarryPotterState {}

class HarryPotterError extends HarryPotterState {
  final String message;
  HarryPotterError(this.message);

  @override
  List<Object> get props => [message];
}

class StudentsLoaded extends HarryPotterState {
  final List<Student> students;
  StudentsLoaded(this.students);

  @override
  List<Object> get props => [students];
}

class StaffLoaded extends HarryPotterState {
  final List<Staff> staff;
  StaffLoaded(this.staff);

  @override
  List<Object> get props => [staff];
}

class GryffindorStudentsLoaded extends HarryPotterState {
  final List<Gryffindor> gryffindorStudents;
  GryffindorStudentsLoaded(this.gryffindorStudents);

  @override
  List<Object> get props => [gryffindorStudents];
}

class SpellsLoaded extends HarryPotterState {
  final List<Spells> spells;
  SpellsLoaded(this.spells);

  @override
  List<Object> get props => [spells];
}
