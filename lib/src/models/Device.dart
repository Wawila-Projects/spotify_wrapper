import 'package:spotify_wrapper/src/StaticClasses/EnumUtils.dart';
import 'package:spotify_wrapper/src/models/Types.dart';

class Device {
  ///The device ID. This may be `null`.
  String id;

  ///If this device is the currently active device.
  bool isActive;

  ///If this device is currently in a private session.
  bool isPrivateSession;

  ///Whether controlling this device is restricted. At present if this 
  ///is [true] then no Web API commands will be accepted by this device.
  bool isRestricted;

  ///The name of the device.
  String name;

  ///Device type, such as [Computer], [Smartphone] or [Speaker].
  DeviceType type;
  
  ///The current volume in percent. This may be [null].
  int volumePercent;

  Device(this.id, this.isActive, this.isPrivateSession, this.isRestricted, 
         this.name, this.type, this.volumePercent);

  factory Device.fromJSON(Map<String, dynamic> json) {
    final type = EnumUtils.enumFromString<DeviceType>(json['type']);
    return Device(json['id'], json['is_active'], json['is_private_session'], 
        json['is_restricted'], json['name'], type, json['volume_percent']);
  }
}