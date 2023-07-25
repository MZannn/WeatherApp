import 'package:flutter/material.dart';

import 'package:weather_app/blocs/cubit/home_cubit.dart';
import 'package:weather_app/function/date_formatting.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final List<Tab> tab = [
      const Tab(
        text: "Hari Ini",
      ),
      const Tab(
        text: "Besok",
      ),
    ];
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HomeLoaded) {
            return Container(
              padding: const EdgeInsets.only(top: 30),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  transform: GradientRotation(0.5),
                  colors: [
                    Color(0xFF6B56FD),
                    Color(0XFF59A0F1),
                    Color(0xFF8977FD),
                  ],
                ),
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          if (state is HomeLoaded) {
                            return DropdownButton<String>(
                              underline: const SizedBox(),
                              elevation: 0,
                              icon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Colors.white,
                              ),
                              selectedItemBuilder: (context) {
                                return state.listLocation.map((String value) {
                                  return Text(value,
                                      style: textTheme.titleMedium);
                                }).toList();
                              },
                              value: state.locationModel.kecamatan,
                              items: state.listLocation.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: textTheme.bodyMedium!
                                        .copyWith(color: Colors.black),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                int index = state.listLocation.indexOf(value!);
                                context.read<HomeCubit>().changeLocation(index);
                              },
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                      BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          if (state is HomeLoaded) {
                            return Text(
                              "Kota ${state.locationModel.kecamatan}",
                              style: textTheme.bodyMedium,
                            );
                          }
                          return const Text("Kota ");
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BlocBuilder<HomeCubit, HomeState>(
                            builder: (context, state) {
                              if (state is HomeLoaded) {
                                return Text(
                                  "${state.listWeatherModel[3].tempC}",
                                  style: textTheme.titleLarge,
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Text(
                              "\u00B0",
                              style: textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                      BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          if (state is HomeLoaded) {
                            return Text(
                              formatDate(DateTime.now().toString(),
                                  "EEEE, dd MMMM HH:mm"),
                              style: textTheme.bodySmall,
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                      BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          if (state is HomeLoaded) {
                            var now = DateTime.now();
                            return Text(
                              "${state.listWeatherModel[now.isAfter(
                                DateTime(now.year, now.month, now.day, 0, 0),
                              ) ? 0 : now.isAfter(
                                  DateTime(now.year, now.month, now.day, 6, 0),
                                ) ? 1 : now.isAfter(
                                  DateTime(now.year, now.month, now.day, 12, 0),
                                ) ? 2 : 3].cuaca}",
                              style: textTheme.bodyMedium!.copyWith(
                                fontSize: 18,
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                      BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          if (state is HomeLoaded) {
                            var now = DateTime.now();
                            int i = now.isAfter(
                              DateTime(now.year, now.month, now.day, 0, 0),
                            )
                                ? 0
                                : now.isAfter(
                                    DateTime(
                                        now.year, now.month, now.day, 6, 0),
                                  )
                                    ? 1
                                    : now.isAfter(
                                        DateTime(now.year, now.month, now.day,
                                            12, 0),
                                      )
                                        ? 2
                                        : 3;

                            return Image.asset(
                                "assets/images/${state.listWeatherModel[i].cuaca == "Cerah Berawan" ? 'partly_cloudly' : state.listWeatherModel[i].cuaca == "Cerah" ? 'sunny' : state.listWeatherModel[i].cuaca == "Berawan" ? 'cloudly' : state.listWeatherModel[i].cuaca == "Hujan Petir" ? 'stormy' : 'cloudly'}.png");
                          }
                          return const SizedBox();
                        },
                      ),
                      BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          if (state is HomeLoaded) {
                            // print(state.position.longitude);
                          }
                          return DefaultTabController(
                            length: tab.length,
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 134,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/awan.png"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: MediaQuery.of(context).size.width /
                                          1.7,
                                      child: TabBar(
                                        dividerColor: Colors.black54,
                                        tabs: tab,
                                        indicatorSize:
                                            TabBarIndicatorSize.label,
                                        indicatorColor: Colors.black,
                                        labelColor: Colors.black,
                                        unselectedLabelColor: Colors.black45,
                                        labelStyle:
                                            textTheme.titleMedium!.copyWith(
                                          fontSize: 13,
                                        ),
                                        unselectedLabelStyle:
                                            textTheme.titleMedium!.copyWith(
                                          fontSize: 13,
                                          color: Colors.black45,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  color: Colors.white,
                                  height:
                                      MediaQuery.of(context).size.height / 2.7,
                                  child: TabBarView(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: [
                                      BlocBuilder<HomeCubit, HomeState>(
                                        builder: (context, state) {
                                          if (state is HomeLoaded) {
                                            return ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 20,
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(
                                                        height: 36,
                                                      ),
                                                      Text(
                                                        formatDate(
                                                            state
                                                                .listWeatherModel[
                                                                    index]
                                                                .jamCuaca!,
                                                            'EEEE, HH:mm'),
                                                        style: textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 24,
                                                      ),
                                                      Image.asset(
                                                          "assets/images/${state.listWeatherModel[index].cuaca == "Cerah Berawan" ? 'partly_cloudly' : state.listWeatherModel[index].cuaca == "Cerah" ? 'sunny' : state.listWeatherModel[index].cuaca == "Berawan" ? 'cloudly' : state.listWeatherModel[index].cuaca == "Hujan Petir" ? 'stormy' : 'cloudly'}.png"),
                                                      const SizedBox(
                                                        height: 12,
                                                      ),
                                                      Text(
                                                        state
                                                            .listWeatherModel[
                                                                index]
                                                            .cuaca!,
                                                        style: textTheme
                                                            .bodySmall!
                                                            .copyWith(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Text(
                                                        "${state.listWeatherModel[index].tempC!} \u00B0",
                                                        style: textTheme
                                                            .titleMedium!
                                                            .copyWith(
                                                          color: Colors.black,
                                                          fontSize: 24,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                              itemCount: 4,
                                            );
                                          }
                                          return const SizedBox();
                                        },
                                      ),
                                      BlocBuilder<HomeCubit, HomeState>(
                                        builder: (context, state) {
                                          if (state is HomeLoaded) {
                                            return ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 20,
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(
                                                        height: 36,
                                                      ),
                                                      Text(
                                                        formatDate(
                                                            state
                                                                .listWeatherModel[
                                                                    index + 4]
                                                                .jamCuaca!,
                                                            'EEEE, HH:mm'),
                                                        style: textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 24,
                                                      ),
                                                      Image.asset(
                                                          "assets/images/${state.listWeatherModel[index + 4].cuaca == "Cerah Berawan" ? 'partly_cloudly' : state.listWeatherModel[index + 4].cuaca == "Cerah" ? 'sunny' : state.listWeatherModel[index + 4].cuaca == "Berawan" ? 'cloudly' : state.listWeatherModel[index + 4].cuaca == "Hujan Petir" ? 'stormy' : 'cloudly'}.png"),
                                                      const SizedBox(
                                                        height: 12,
                                                      ),
                                                      Text(
                                                        state
                                                            .listWeatherModel[
                                                                index + 4]
                                                            .cuaca!,
                                                        style: textTheme
                                                            .bodySmall!
                                                            .copyWith(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Text(
                                                        "${state.listWeatherModel[index + 4].tempC!} \u00B0",
                                                        style: textTheme
                                                            .titleMedium!
                                                            .copyWith(
                                                          color: Colors.black,
                                                          fontSize: 24,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                              itemCount: 4,
                                            );
                                          }
                                          return const SizedBox();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
