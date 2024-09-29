import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tractian_challenge/utils/colors.dart';
import '../bloc/company/company_bloc.dart';
import '../bloc/company/company_event.dart';
import '../bloc/company/company_state.dart';
import '../widgets/button_unit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _refreshCompanies(BuildContext context) async {
    context.read<CompanyBloc>().add(FetchCompanies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset(
          'lib/assets/images/tractian_logo.png',
          height: 40,
        ),
        backgroundColor: backgroundTitle,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocListener<CompanyBloc, CompanyState>(
        listenWhen: (previous, current) => current is CompanyError,
        listener: (context, state) {
          if (state is CompanyError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          }
        },
        child: RefreshIndicator(
          onRefresh: () => _refreshCompanies(context),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<CompanyBloc, CompanyState>(
              builder: (context, state) {
                if (state is CompanyLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CompanyError) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Error: ${state.message}'),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<CompanyBloc>().add(FetchCompanies());
                          },
                          child: const Text('Try again'),
                        ),
                      ],
                    ),
                  );
                } else if (state is CompanyLoaded) {
                  if (state.companies.isEmpty) {
                    return const Center(child: Text('No company found!'));
                  }

                  return ListView.builder(
                    itemCount: state.companies.length,
                    itemBuilder: (context, index) {
                      final company = state.companies[index];
                      final companyName = '${company.name} Unit';

                      return UnitButton(
                        text: companyName,
                        onTap: () {
                        },
                      );
                    },
                  );
                }
                return const Center(child: Text('Something went wrong!'));
              },
            ),
          ),
        ),
      ),
    );
  }
}
