import 'package:demo/commons/app_colors.dart';
import 'package:demo/commons/app_images.dart';
import 'package:demo/commons/app_text_styles.dart';
import 'package:demo/models/entities/current_entity.dart';
import 'package:demo/services/weather_repository.dart';
import 'package:demo/ui/components/behavior_custom.dart';
import 'package:demo/ui/pages/home/detail_weather/detail_weather_page.dart';
import 'package:demo/ui/pages/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController textController;
  late HomeCubit _cubit;

  List<String> listDay = ["Today", "Tomorrow", "Next Week"];

  @override
  void initState() {
    final repository = RepositoryProvider.of<IWeatherRepository>(context);
    textController = TextEditingController();
    _cubit = HomeCubit(repository: repository);
    super.initState();
    _cubit.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider.value(
        value: _cubit,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    Icon(Icons.menu),
                    Text(
                      "Hà Nội",
                      style: AppTextStyle.textSecondaryS14W500,
                    ),
                    Icon(Icons.search)
                  ],
                ),
              ),
              const SizedBox(height: 16),
              BlocBuilder<HomeCubit, HomeState>(
                buildWhen: (prev, current) => prev.indexSelected != current.indexSelected,
                builder: (context, state) {
                  return Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 36,
                      padding: const EdgeInsets.symmetric(horizontal: 59),
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: listDay.length,
                        separatorBuilder: (context, index) => const SizedBox(width: 5),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              _cubit.changeIndex(index);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                              decoration: BoxDecoration(
                                  color: index == state.indexSelected
                                      ? AppColors.cardColor.withOpacity(0.1)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(19)),
                              child: Center(
                                child: Text(
                                  listDay[index],
                                  style: state.indexSelected == index
                                      ? AppTextStyle.textPrimaryS14W500
                                      : AppTextStyle.textSecondaryS14W500,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),
              BlocBuilder<HomeCubit, HomeState>(
                buildWhen: (prev, current) => prev.loadStatus != current.loadStatus,
                builder: (context, state) {
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(39),
                        color: AppColors.primaryColor,
                        image: const DecorationImage(
                          image: AssetImage(
                            AppImages.imgCardHome,
                          ),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "${state.weatherCurrent?.main?.temp ?? 0}°",
                              style: AppTextStyle.textWhiteS80Bold,
                            ),
                            Text(
                              state.weatherCurrent?.weather![0].description ?? '',
                              style: AppTextStyle.textWhiteS14W500.copyWith(fontSize: 18),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "Humidity",
                              style: AppTextStyle.textWhiteS14W500,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "${state.weatherCurrent?.main?.humidity ?? 0}°",
                              style: AppTextStyle.textWhiteS14W500.copyWith(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Next 48 hours",
                  style: AppTextStyle.textSecondaryS16Bold,
                ),
              ),
              const SizedBox(height: 16),
              BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
                return SizedBox(
                  height: 230,
                  child: ScrollConfiguration(
                    behavior: BehaviorCustom(),
                    child: ListView.separated(
                      itemCount: state.weatherByDay?.hourly?.length ?? 0,
                      scrollDirection: Axis.horizontal,
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.only(left: 20),
                      separatorBuilder: (context, index) => const SizedBox(width: 20),
                      itemBuilder: (context, index) {
                        final weather = state.weatherByDay?.hourly?[index];
                        final List<CurrentEntity>? listWeather =
                            state.weatherByDay?.hourly?.sublist(index + 1, index + 6);
                        return InkWell(
                          onTap: () async {
                            await showModalBottomSheet(
                              context: context,
                              useRootNavigator: true,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (BuildContext context) => DetailWeatherPage(
                                currentWeather: weather!,
                                colorBackGround: colorBackground(index),
                                listWeatherFuture: listWeather ?? [],
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: 176,
                                width: 128,
                                decoration: BoxDecoration(
                                  color: colorBackground(index),
                                  borderRadius: BorderRadius.circular(23),
                                  boxShadow: [
                                    BoxShadow(
                                      color: colorShadow(index),
                                      blurRadius: 8,
                                      offset: const Offset(0, 16),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.only(top: 17),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      weather?.dateTime ?? '',
                                      style: AppTextStyle.textWhiteS14W500,
                                    ),
                                    const SizedBox(height: 17),
                                    Image.network(
                                      'https://openweathermap.org/img/wn/${weather?.weather?[0].icon ?? ''}@2x.png',
                                      height: 45,
                                      width: 45,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "${weather?.temp ?? 0}°",
                                      style: AppTextStyle.textWhiteS14W500.copyWith(fontSize: 20),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "${weather?.humidity ?? 0}°",
                                          style: AppTextStyle.textWhiteS12W500.copyWith(
                                            color: Colors.white.withOpacity(0.5),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Text(
                                          "${weather?.feelsLike ?? 0}°",
                                          style: AppTextStyle.textWhiteS12W500,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  Color colorBackground(int index) {
    if (index % 2 == 0) {
      return AppColors.greenColor;
    } else if (index % 3 == 0) {
      return AppColors.orangeColor;
    } else if (index % 5 == 0) {
      return AppColors.redColor;
    } else if (index % 7 == 0) {
      return AppColors.yellowColor;
    } else {
      return AppColors.purpleColor;
    }
  }

  Color colorShadow(int index) {
    if (index % 2 == 0) {
      return AppColors.greenColor.withOpacity(0.2);
    } else if (index % 3 == 0) {
      return AppColors.orangeColor.withOpacity(0.2);
    } else if (index % 5 == 0) {
      return AppColors.redColor.withOpacity(0.2);
    } else if (index % 7 == 0) {
      return AppColors.yellowColor.withOpacity(0.2);
    } else {
      return AppColors.purpleColor.withOpacity(0.2);
    }
  }
}
