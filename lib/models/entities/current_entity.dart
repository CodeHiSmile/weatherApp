import 'package:demo/models/entities/weather_entity.dart';
import 'package:json_annotation/json_annotation.dart';

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
  int? sunrise;
  @JsonKey()
  int? sunset;
  @JsonKey()
  double? temp;
  @JsonKey()
  double? feelsLike;
  @JsonKey()
  int? pressure;
  @JsonKey()
  int? humidity;
  @JsonKey()
  double? dewPoint;
  @JsonKey()
  double? uvi;
  @JsonKey()
  int? clouds;
  @JsonKey()
  int? visibility;
  @JsonKey()
  double? windSpeed;
  @JsonKey()
  int? windDeg;
  @JsonKey()
  double? windGust;
  @JsonKey()
  List<WeatherEntity>? weather;
  @JsonKey()
  int? pop;

  factory CurrentEntity.fromJson(Map<String, dynamic> json) => _$CurrentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentEntityToJson(this);
}
