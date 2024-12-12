import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:landlords_web_app/backend/landlords_repository/landlord.dart';
import 'package:landlords_web_app/constants/colors.dart';
import 'package:landlords_web_app/frontend/building_screen/building_screen.dart';
import 'package:landlords_web_app/frontend/landlords_screen/cubit/landlords_cubit.dart';
import 'package:landlords_web_app/frontend/login_screen/widgets/landing_background.dart';
import 'package:intl/intl.dart';

class ProperyManagementScreen extends StatelessWidget {
  const ProperyManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LandlordsCubit, LandlordsState>(
      builder: (context, state) {
        final theme = Theme.of(context);
        if (state.status == LandlordsStatus.initial) {
          context.read<LandlordsCubit>().fetchLandlords();
        }
        switch (state.status) {
          case LandlordsStatus.initial:
            return const Center(child: CircularProgressIndicator());

          case LandlordsStatus.loading:
            return const Center(child: CircularProgressIndicator());

          case LandlordsStatus.success:
            return Scaffold(
              backgroundColor: Colors.black,
              body: Stack(
                children: [
                  const LandingBackground(
                    title: "Property Management",
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 70),
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.landlords.length,
                        padding: const EdgeInsets.all(16),
                        itemBuilder: (context, index) {
                          final landlord = state.landlords[index];
                          return Card(
                            color: LandingPageColors.cardColor.color,
                            elevation: 8,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(
                                  16.0), // Add padding for spacing
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: const CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        "https://images.pexels.com/photos/7641824/pexels-photo-7641824.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                                      ),
                                      radius: 36, // Larger size for the avatar
                                    ),
                                    title: Text(
                                      landlord.name,
                                      style: theme.textTheme.headlineSmall!
                                          .copyWith(
                                        color: ColorSeed.darkPrimaryText.color,
                                        fontWeight: FontWeight
                                            .bold, // Make the name more prominent
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          landlord.phoneNumber,
                                          style: theme.textTheme.bodyMedium!
                                              .copyWith(
                                            color:
                                                ColorSeed.darkPrimaryText.color,
                                          ),
                                        ),
                                        const SizedBox(
                                            height:
                                                4), // Add some spacing between lines
                                        Text(
                                          'Joined At: ${DateFormat.yMMMMd().format(landlord.createdAt)}',
                                          style: theme.textTheme.bodyMedium!
                                              .copyWith(
                                            color: ColorSeed
                                                .darkSecondaryText.color,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                      height:
                                          12), // Spacing between details and button
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .push(_createRoute(landlord));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.amber,
                                      ),
                                      child: const Text(
                                        'See Buildings',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );

          case LandlordsStatus.error:
            return const Center(
              child: Text(
                'Failed to load landlords',
                style: TextStyle(color: Colors.red),
              ),
            );
        }
      },
    );
  }

  Route _createRoute(Landlord landlord) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          BuildingScreen(landlord: landlord),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0); // Change to come from the bottom
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        var scaleTween =
            Tween<double>(begin: 0.8, end: 1.0).chain(CurveTween(curve: curve));
        var scaleAnimation = animation.drive(scaleTween);

        var fadeTween =
            Tween<double>(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));
        var fadeAnimation = animation.drive(fadeTween);

        return SlideTransition(
          position: offsetAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: FadeTransition(
              opacity: fadeAnimation,
              child: child,
            ),
          ),
        );
      },
    );
  }
}
