import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

class DeviceInfo {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  static Map<String, dynamic> readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId,
      'systemFeatures': build.systemFeatures,
    };
  }

  static Map<String, dynamic> readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  static Map<String, dynamic> readLinuxDeviceInfo(LinuxDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'version': data.version,
      'id': data.id,
      'idLike': data.idLike,
      'versionCodename': data.versionCodename,
      'versionId': data.versionId,
      'prettyName': data.prettyName,
      'buildId': data.buildId,
      'variant': data.variant,
      'variantId': data.variantId,
      'machineId': data.machineId,
    };
  }

  // static Map<String, dynamic> readWebBrowserInfo(WebBrowserInfo data) {
  //   return <String, dynamic>{
  //     'browserName': describeEnum(data.browserName),
  //     'appCodeName': data.appCodeName,
  //     'appName': data.appName,
  //     'appVersion': data.appVersion,
  //     'deviceMemory': data.deviceMemory,
  //     'language': data.language,
  //     'languages': data.languages,
  //     'platform': data.platform,
  //     'product': data.product,
  //     'productSub': data.productSub,
  //     'userAgent': data.userAgent,
  //     'vendor': data.vendor,
  //     'vendorSub': data.vendorSub,
  //     'hardwareConcurrency': data.hardwareConcurrency,
  //     'maxTouchPoints': data.maxTouchPoints,
  //   };
  // }

  static Map<String, dynamic> readMacOsDeviceInfo(MacOsDeviceInfo data) {
    return <String, dynamic>{
      'computerName': data.computerName,
      'hostName': data.hostName,
      'arch': data.arch,
      'model': data.model,
      'kernelVersion': data.kernelVersion,
      'osRelease': data.osRelease,
      'activeCPUs': data.activeCPUs,
      'memorySize': data.memorySize,
      'cpuFrequency': data.cpuFrequency,
      'systemGUID': data.systemGUID,
    };
  }

  // static Map<String, dynamic> readWindowsDeviceInfo(WindowsDeviceInfo data) {
  //   return <String, dynamic>{
  //     'numberOfCores': data.numberOfCores,
  //     'computerName': data.computerName,
  //     'systemMemoryInMegabytes': data.systemMemoryInMegabytes,
  //   };
  // }
}
