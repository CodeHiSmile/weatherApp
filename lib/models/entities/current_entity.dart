import 'package:demo/models/entities/weather_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../helper/datetime_formatter.dart';

part 'current_entity.g.dart';

@JsonSerializable()
class CurrentEntity {
  CurrentEntity({
    this.dt,
    this.sunrise,
    this.sunset,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.uvi,
    this.clouds,
    this.visibility,
    this.windSpeed,
    this.windDeg,
    this.windGust,
    this.weather,
    this.pop,
  });

  @JsonKey()
  int? dt;
  @JsonKey()
  double? sunrise;
  @JsonKey()
  double? sunset;
  @JsonKey()
  double? temp;
  @JsonKey(name: 'feels_like')
  double? feelsLike;
  @JsonKey()
  double? pressure;
  @JsonKey()
  double? humidity;
  @JsonKey()
  double? dewPoint;
  @JsonKey()
  double? uvi;
  @JsonKey()
  double? clouds;
  @JsonKey()
  double? visibility;
  @JsonKey()
  double? windSpeed;
  @JsonKey()
  double? windDeg;
  @JsonKey()
  double? windGust;
  @JsonKey()
  List<WeatherEntity>? weather;
  @JsonKey()
  double? pop;

  factory CurrentEntity.fromJson(Map<String, dynamic> json) => _$CurrentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentEntityToJson(this);

  String get dateTime {
    return DateTime.fromMillisecondsSinceEpoch(dt! * 1000).toStringWith(DateTimeFormater.dateTimeHour);
  }

  String get hour {
    return DateTime.fromMillisecondsSinceEpoch(dt! * 1000).toStringWith(DateTimeFormater.dateTime);
  }
}
