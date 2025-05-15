import 'package:equatable/equatable.dart';

abstract class HarryPotterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchStudents extends HarryPotterEvent {}

class FetchStaff extends HarryPotterEvent {}

class FetchGryffindorStudents extends HarryPotterEvent {}

class FetchSpells extends HarryPotterEvent {}
