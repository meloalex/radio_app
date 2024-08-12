import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:radio_station/home/cubit/radio_station_list_cubit.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 14),
        child: BlocBuilder<RadioStationListCubit, RadioStationListState>(
          builder: (context, state) {
            if (state is RadioStationListLoaded) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    switchInCurve: Curves.easeInOut,
                    switchOutCurve: Curves.easeInOut,
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      final slideAnimation = Tween<Offset>(
                        begin: const Offset(-1.0, 0.0),
                        end: Offset.zero,
                      ).animate(animation);

                      final fadeAnimation = Tween<double>(
                        begin: 0.0,
                        end: 1.0,
                      ).animate(animation);

                      return SlideTransition(
                        position: slideAnimation,
                        child: FadeTransition(
                          opacity: fadeAnimation,
                          child: child,
                        ),
                      );
                    },
                    child: state.countrySelected != null
                        ? IconButton(
                            key: const ValueKey('back_arrow'),
                            icon: Icon(
                              Icons.arrow_back,
                              color: Theme.of(context).primaryColor,
                              size: 32,
                            ),
                            onPressed: () {
                              context.read<RadioStationListCubit>().selectCountry(null);
                            },
                          )
                        : const SizedBox.shrink(),
                  ),
                  const SizedBox(width: 8),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    switchInCurve: Curves.easeInOut,
                    switchOutCurve: Curves.easeInOut,
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      final slideAnimation = Tween<Offset>(
                        begin: const Offset(0.0, 1.0),
                        end: Offset.zero,
                      ).animate(animation);

                      final fadeAnimation = Tween<double>(
                        begin: 0.0,
                        end: 1.0,
                      ).animate(animation);

                      return SlideTransition(
                        position: slideAnimation,
                        child: FadeTransition(
                          opacity: fadeAnimation,
                          child: child,
                        ),
                      );
                    },
                    child: Row(
                      key: ValueKey<String>(state.countrySelected == null ? 'Country' : 'Station'),
                      children: [
                        Text(
                          'Choose',
                          style: GoogleFonts.poppins(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          state.countrySelected == null ? 'Country' : 'Station',
                          style: GoogleFonts.poppins(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryColor.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            return Container();
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
