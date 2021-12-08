import 'package:demo/commons/app_colors.dart';
import 'package:demo/commons/app_images.dart';
import 'package:demo/commons/app_shadow.dart';
import 'package:demo/commons/app_text_styles.dart';
import 'package:demo/models/entities/current_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'detail_weather_cubit.dart';

class DetailWeatherPage extends StatefulWidget {
  final CurrentEntity currentWeather;
  final Color colorBackGround;
  final List<CurrentEntity> listWeatherFuture;

  const DetailWeatherPage({
    Key? key,
    required this.currentWeather,
    required this.colorBackGround,
    required this.listWeatherFuture,
  }) : super(key: key);

  @override
  _DetailWeatherPageState createState() => _DetailWeatherPageState();
}

class _DetailWeatherPageState extends State<DetailWeatherPage> {
  late DetailWeatherCubit _cubit;

  @override
  void initState() {
    _cubit = DetailWeatherCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocProvider.value(
        value: _cubit,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                margin: const EdgeInsets.only(top: 22),
                decoration: BoxDecoration(
                  color: widget.colorBackGround,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(55),
                    topRight: Radius.circular(55),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              widget.currentWeather.dateTime,
                              style: AppTextStyle.textWhiteS14W500.copyWith(
                                fontSize: 40,
                              ),
                            ),
                            const SizedBox(height: 17),
                            Image.network(
                              'https://openweathermap.org/img/wn/${widget.currentWeather.weather?[0].icon ?? ''}@2x.png',
                              height: 80,
                              width: 80,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "${widget.currentWeather.temp}°",
                              style: AppTextStyle.textWhiteS14W500.copyWith(fontSize: 50),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "${widget.currentWeather.humidity}°",
                                  style: AppTextStyle.textWhiteS12W500.copyWith(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 30,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  "${widget.currentWeather.feelsLike}°",
                                  style: AppTextStyle.textWhiteS12W500.copyWith(
                                    fontSize: 30,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    BlocBuilder<DetailWeatherCubit, DetailWeatherState>(
                        buildWhen: (prev, current) =>
                            prev.indexSelected != current.indexSelected || prev.checkSelected != current.checkSelected,
                        builder: (context, state) {
                          return Container(
                            height: 231,
                            margin: const EdgeInsets.fromLTRB(20, 0, 20, 23),
                            color: Colors.transparent,
                            child: Column(
                              children: [
                                const Spacer(),
                                Container(
                                  height: (state.checkSelected ?? false) ? 213 : 147,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          child: ListView.separated(
                                            padding: const EdgeInsets.symmetric(horizontal: 30),
                                            physics: const NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            itemCount: widget.listWeatherFuture.length,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  _cubit.changeIndex(index);
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                    vertical:
                                                        state.indexSelected == index && state.checkSelected == true
                                                            ? 8
                                                            : 0,
                                                  ),
                                                  width: (MediaQuery.of(context).size.width - 40 - 60 - 16 * 4) / 5,
                                                  decoration: BoxDecoration(
                                                    color: (state.indexSelected == index && state.checkSelected == true)
                                                        ? AppColors.bgLightPink
                                                        : Colors.white,
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: <Widget>[
                                                        Text(
                                                          widget.listWeatherFuture[index].hour,
                                                          style: AppTextStyle.textSecondaryS12,
                                                        ),
                                                        const SizedBox(height: 8),
                                                        Image.network(
                                                          'https://openweathermap.org/img/wn/${widget.listWeatherFuture[index].weather?[0].icon ?? ''}@2x.png',
                                                          height: 27,
                                                          width: 27,
                                                        ),
                                                        const SizedBox(height: 8),
                                                        Text(
                                                          "${widget.listWeatherFuture[index].temp}°",
                                                          style: AppTextStyle.textSecondaryS12,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            separatorBuilder: (context, index) => const SizedBox(width: 16),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: state.checkSelected ?? false,
                                        child: Divider(
                                          color: AppColors.greenColor,
                                          height: 1,
                                        ),
                                      ),
                                      Visibility(
                                        visible: state.checkSelected ?? false,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(vertical: 18),
                                          child: Center(
                                            child: Text(
                                              "Carry Umbrella",
                                              style: AppTextStyle.textSecondaryS14W500,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        })
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 44,
                      width: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: AppShadow.iconCloseShadow,
                      ),
                      child: Icon(
                        Icons.close,
                        color: AppColors.redColor,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
