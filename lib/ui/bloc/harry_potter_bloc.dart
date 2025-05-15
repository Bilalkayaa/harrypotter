import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harrypotter/data/repository/harry_potter_repository.dart';

import 'harry_potter_event.dart';
import 'harry_potter_state.dart';

class HarryPotterBloc extends Bloc<HarryPotterEvent, HarryPotterState> {
  final HarryPotterRepository repository;

  HarryPotterBloc({required this.repository}) : super(HarryPotterInitial()) {
    on<FetchStudents>((event, emit) async {
      try {
        emit(HarryPotterLoading());
        final students = await repository.getStudents();
        emit(StudentsLoaded(students));
      } catch (e) {
        emit(HarryPotterError(e.toString()));
      }
    });

    on<FetchStaff>((event, emit) async {
      try {
        emit(HarryPotterLoading());
        final staff = await repository.getStaff();
        emit(StaffLoaded(staff));
      } catch (e) {
        emit(HarryPotterError(e.toString()));
      }
    });

    on<FetchGryffindorStudents>((event, emit) async {
      try {
        emit(HarryPotterLoading());
        final gryffindorStudents = await repository.getGryffindorStudents();
        emit(GryffindorStudentsLoaded(gryffindorStudents));
      } catch (e) {
        emit(HarryPotterError(e.toString()));
      }
    });

    on<FetchSpells>((event, emit) async {
      try {
        emit(HarryPotterLoading());
        final spells = await repository.getSpells();
        emit(SpellsLoaded(spells));
      } catch (e) {
        emit(HarryPotterError(e.toString()));
      }
    });
  }
}
