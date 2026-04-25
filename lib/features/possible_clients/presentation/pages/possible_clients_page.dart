import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saidco/features/possible_clients/presentation/widgets/possible_client_list_item.dart';
import 'package:saidco/features/possible_clients/presentation/cubit/possible_clients_cubit.dart';
import 'package:saidco/features/possible_clients/presentation/cubit/possible_clients_states.dart';
import 'package:saidco/features/possible_clients/presentation/widgets/possible_clients_header.dart';

class PossibleClientsPage extends StatefulWidget {
  const PossibleClientsPage({super.key});

  @override
  State<PossibleClientsPage> createState() => _PossibleClientsPageState();
}

class _PossibleClientsPageState extends State<PossibleClientsPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    context.read<PossibleClientsCubit>().getPossibleClients();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PossibleClientsCubit, PossibleClientsState>(
      builder: (context, state) {
        if (state is PossibleClientsLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is PossibleClientsError) {
          return Center(
            child: Text(
              'حدث خطأ أثناء تحميل البيانات: ${state.message}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
          );
        }

        if (state is PossibleClientsLoaded) {
          final possibleClients = state.possibleClients;

          if (possibleClients.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 75),
                child: Text(
                  'لا يوجد بيانات لعرضها',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            );
          }

          return Column(
            children: [
              const PossibleClientsHeader(),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(bottom: 75),
                  itemCount: possibleClients.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final possibleClient = possibleClients[index];
                    return PossibleClientListItem(
                      possibleClient: possibleClient,
                    );
                  },
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
