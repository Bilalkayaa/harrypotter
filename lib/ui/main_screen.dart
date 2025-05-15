import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:harrypotter/data/models/gryffindor_model.dart';
import 'package:harrypotter/ui/bloc/harry_potter_bloc.dart';
import 'package:harrypotter/ui/bloc/harry_potter_event.dart';
import 'package:harrypotter/ui/bloc/harry_potter_state.dart';

import '../data/models/student_model.dart';
import '../data/models/staff_model.dart';

import '../data/models/spells_model.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    context.read<HarryPotterBloc>().add(FetchStudents());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.surface,
            Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.3),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'Harry Potter',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<HarryPotterBloc, HarryPotterState>(
          builder: (context, state) {
            if (state is HarryPotterLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              );
            } else if (state is HarryPotterError) {
              return Center(child: Text(state.message));
            } else if (state is StudentsLoaded) {
              return _buildStudentList(state.students);
            } else if (state is StaffLoaded) {
              return _buildStaffList(state.staff);
            } else if (state is GryffindorStudentsLoaded) {
              return _buildGryffindorList(state.gryffindorStudents);
            } else if (state is SpellsLoaded) {
              return _buildSpellsList(state.spells);
            }
            return Center(
              child: Text(
                'Select a category',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            );
          },
        ),
        bottomNavigationBar: Container(
          height: 90,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.surface,
                Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.3),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            child: TabBar(
              controller: _tabController,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              labelPadding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              tabs: const [
                Tab(icon: Icon(Icons.school, size: 24), text: 'Students'),
                Tab(icon: Icon(Icons.people, size: 24), text: 'Staff'),
                Tab(icon: Icon(Icons.shield, size: 24), text: 'Gryffindor'),
                Tab(icon: Icon(Icons.auto_fix_high, size: 24), text: 'Spells'),
              ],
              onTap: (index) {
                switch (index) {
                  case 0:
                    context.read<HarryPotterBloc>().add(FetchStudents());
                    break;
                  case 1:
                    context.read<HarryPotterBloc>().add(FetchStaff());
                    break;
                  case 2:
                    context.read<HarryPotterBloc>().add(
                      FetchGryffindorStudents(),
                    );
                    break;
                  case 3:
                    context.read<HarryPotterBloc>().add(FetchSpells());
                    break;
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStudentList(List<Student> students) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: students.length,
      itemBuilder: (context, index) {
        final student = students[index];
        return _buildCharacterCard(
          name: student.name ?? '',
          house: student.house ?? '',
          species: student.species ?? '',
          patronus: student.patronus ?? '',
          image: student.image ?? '',
        );
      },
    );
  }

  Widget _buildStaffList(List<Staff> staff) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: staff.length,
      itemBuilder: (context, index) {
        final staffMember = staff[index];
        return _buildCharacterCard(
          name: staffMember.name ?? '',
          house: staffMember.house ?? '',
          species: staffMember.species ?? '',
          patronus: staffMember.patronus ?? '',
          image: staffMember.image ?? '',
        );
      },
    );
  }

  Widget _buildGryffindorList(List<Gryffindor> students) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: students.length,
      itemBuilder: (context, index) {
        final student = students[index];
        return _buildCharacterCard(
          name: student.name ?? '',
          house: student.house ?? '',
          species: student.species ?? '',
          patronus: student.patronus ?? '',
          image: student.image ?? '',
        );
      },
    );
  }

  Widget _buildCharacterCard({
    required String name,
    required String house,
    required String species,
    required String patronus,
    required String image,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.secondary.withValues(alpha: 0.3),
            ],
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child:
                  image.isNotEmpty
                      ? CachedNetworkImage(
                        imageUrl: image,
                        fit: BoxFit.cover,
                        placeholder:
                            (context, url) => Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                        errorWidget:
                            (context, url, error) => Icon(
                              Icons.person,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      )
                      : Icon(
                        Icons.person,
                        color: Theme.of(context).colorScheme.primary,
                        size: 30,
                      ),
            ),
          ),
          title: Text(
            name,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              if (house.isNotEmpty)
                Text(
                  'House: $house',
                  style: const TextStyle(color: Colors.white70),
                ),
              if (species.isNotEmpty)
                Text(
                  'Species: $species',
                  style: const TextStyle(color: Colors.white70),
                ),
              if (patronus.isNotEmpty)
                Text(
                  'Patronus: $patronus',
                  style: const TextStyle(color: Colors.white70),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpellsList(List<Spells> spells) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: spells.length,
      itemBuilder: (context, index) {
        final spell = spells[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.surface,
                  Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.3),
                ],
              ),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Icon(
                Icons.auto_fix_high,
                color: Theme.of(context).colorScheme.primary,
                size: 30,
              ),
              title: Text(
                spell.name ?? '',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  spell.description ?? '',
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
