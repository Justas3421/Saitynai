import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:landlords_web_app/backend/landlords_repository/landlord.dart';
import 'package:landlords_web_app/constants/colors.dart';
import 'package:landlords_web_app/frontend/landlords_screen/cubit/landlords_cubit.dart';

class LandlordsScreen extends StatelessWidget {
  const LandlordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LandlordsCubit, LandlordsState>(
      builder: (context, state) {
        if (state.status == LandlordsStatus.initial) {
          context.read<LandlordsCubit>().fetchLandlords();
        }
        switch (state.status) {
          case LandlordsStatus.initial:
            return const CircularProgressIndicator();

          case LandlordsStatus.loading:
            return const CircularProgressIndicator();
          case LandlordsStatus.success:
            return Card(
              color: LandingPageColors.cardColor.color,
              child: ListView.builder(
                itemCount: state.landlords.length,
                itemBuilder: (context, index) {
                  final landlord = state.landlords[index];
                  return ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://www.shutterstock.com/shutterstock/photos/2517663409/display_1500/stock-photo-landlord-sitting-at-a-desk-with-a-small-model-house-in-an-office-looking-at-paperwork-wondering-how-2517663409.jpg"),
                    ),
                    title: Text(landlord.name,
                        style: const TextStyle(color: Colors.white)),
                    subtitle: Text(landlord.phoneNumber,
                        style: const TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BuildingScreen(landlord: landlord),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          case LandlordsStatus.error:
            return const Text('Error');
        }
      },
    );
  }
}

class BuildingScreen extends StatelessWidget {
  final Landlord landlord;

  const BuildingScreen({super.key, required this.landlord});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${landlord.name}\'s Buildings'),
      ),
      body: Center(
        child: Text('Buildings managed by ${landlord.name}'),
      ),
    );
  }
}
