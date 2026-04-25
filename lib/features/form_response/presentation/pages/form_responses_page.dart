import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saidco/core/enums/filtering_enums.dart';
import 'package:saidco/core/utils/date_helper.dart';
import 'package:saidco/features/form_response/presentation/cubit/form_response_cubit.dart';
import 'package:saidco/features/form_response/presentation/cubit/form_response_state.dart';
import 'package:saidco/features/form_response/presentation/widgets/filter_toggle_buttons.dart';
import 'package:saidco/features/form_response/presentation/widgets/form_response_list_item.dart';
import 'package:saidco/features/form_response/presentation/widgets/form_responses_header.dart';

class FormResponsesPage extends StatefulWidget {
  const FormResponsesPage({super.key});

  @override
  State<FormResponsesPage> createState() => _FormResponsesPageState();
}

class _FormResponsesPageState extends State<FormResponsesPage> {
  @override
  void initState() {
    super.initState();
    context.read<FormResponseCubit>().getFormResponses();
  }

  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return DateHelper.formatShortDate(date);
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FilterStatus filterStatus = FilterStatus.all;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormResponseCubit, FormResponseState>(
      builder: (context, state) {
        if (state is FormResponseLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is FormResponseError) {
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

        if (state is FormResponseLoaded) {
          final responses = state.responses;

          if (responses.isEmpty) {
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
              FilterToggleButtons(
                onPressed: (index) {
                  setState(() {
                    if (index == 0) {
                      filterStatus = FilterStatus.all;
                      context.read<FormResponseCubit>().getFormResponses();
                    }
                    if (index == 1) {
                      filterStatus = FilterStatus.notContacted;
                      context.read<FormResponseCubit>().getFormResponses(
                        filterStatus: FilterStatus.notContacted.name,
                      );
                    }
                  });
                },
                isSelected: [
                  filterStatus == FilterStatus.all,
                  filterStatus == FilterStatus.notContacted,
                ],
              ),

              const FormResponsesHeader(),

              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(bottom: 75),
                  itemCount: responses.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final response = responses[index];

                    return FormResponseListItem(response: response);
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
