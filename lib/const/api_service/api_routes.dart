class ApiRoutes {
  static const String baseUrl = 'https://9184-3-35-156-223.ngrok-free.app';

  //auth
  static const String signUp = '/api/auth/signup';
  static const String signIn = '/api/auth/signin';
  static const String refresh = '/api/auth/refresh';

  static const String passwordReset = '/api/user/password/reset';

  //user
  static const String user = '/api/user';

  static const String userAwaiters = '/api/user/awaiters';

  static const String userAdmins = '/api/user/admins';

  static const String userEmployess = '/api/user/employess';

  static const String userList = '/api/user/list';

  static const String userId = '/api/user/user_id';
  static const String userPassword = '/api/user/password';
  static const String userEmail = '/api/user/email';
  static const String userTenant = '/api/user/userTenant';
  static const String userPrivilege = '/api/user/privilege';

  //console_Log
  static const String getConsoleLog = '/api/log/console';
  static const String postConsoleLog = '/api/log/console';
  static const String deleteConsoleLog = '/api/log/console';
  static const String deleteRangeConsoleLog = '/api/log/console/range';

//work_Log
  static const String getWorkLog = '/api/log/work';
  static const String postWorkLog = '/api/log/work';
  static const String deleteWorkLog = '/api/log/work';
  static const String getWorkListLogByCreatedAt =
      '/api/log/work/list/by-created-at';

  static const String getWorkListLogByDuration =
      '/api/log/work/list/by-duration';

  //Smart_Rack
  static const String getDeviceSmartRack = '/api/device/smart-rack';
  static const String patchDeviceSmartRackNumber =
      '/api/device/smart-rack/number';

  static const String patchDeviceSmartRackLedMode =
      '/api/device/smart-rack/led/mode';

  static const String patchDeviceSmartRackLedOn =
      '/api/device/smart-rack/led/on';

  static const String patchDeviceSmartRackLedLastOperatedAt =
      '/api/device/smart-rack/led/last-operated-at';

  //Smart_Rack_irrigation
  static const String patchDeviceSmartRackIrrigationLastOperatedAt =
      '/api/device/smart-rack/irrigation/last-operated-at';

  static const String getDeviceSmartRackLedOperationTimes =
      '/api/device/smart-rack/led/operation-times';

  static const String postDeviceSmartRackLedOperationTimes =
      '/api/device/smart-rack/led/operation-times';

  static const String patchDeviceSmartRackIrrigationOn =
      '/api/device/smart-rack/irrigation/on';

  static const String patchDeviceSmartRackIrrigationMode =
      '/api/device/smart-rack/irrigation/mode';

  static const String getDeviceSmartRackIrrigationOperationTimes =
      '/api/device/smart-rack/irrigation/operation-times';

  static const String postDeviceSmartRackIrrigationOperationTimes =
      '/api/device/smart-rack/irrigation/operation-times';

  //Conveyor_Device
  static const String getDeviceConveyor = '/api/device/conveyor';
  static const String postDeviceConveyor = '/api/device/conveyor';

  static const String patchDeviceConveyorStatus = '/api/device/conveyor/status';

  static const String patchDeviceConveyorSpeed = '/api/device/conveyor/speed';

  //AGV

  static const String getDeviceAgv = '/api/device/agv';

  static const String postDeviceAgv = '/api/device/agv';
  static const String patchDeviceAgvStatus = '/api/device/agv/status';

  static const String patchDeviceAgvMode = '/api/device/agv/mode';

  static const String patchDeviceAgvBatteryLevel =
      '/api/device/agv/battery-level';

  static const String patchDeviceAgvDriveDistance =
      '/api/device/agv/drive-distance';

  //Device

  static const String deleteDevice = '/api/device';

  static const String getDevice = '/api/device';
  static const String patchDeviceName = '/api/device';
  static const String patchDeviceModelName = '/api/device/model-name';
  static const String patchDeviceTenantId = '/api/device/tenant-id';

  static const String patchDeviceEquippedAt = '/api/device/equipped-at';

  static const String patchDeviceManufacturerName =
      '/api/device/manufacturer-name';

  //Task
  static const String getTaskStatus = '/api/task';
  static const String postTaskStauts = '/api/task';
  static const String patchTaskStartedAt = '/api/task/started-at';
  static const String patchTaskEndedAt = '/api/task/ended-at';
  static const String patchTaskName = '/api/task/name';

  static const String patchTaskDescription = '/api/task/description';

  static const String patchTaskType = '/api/task/type';

  static const String patchTaskStatus = '/api/task/status';

  //Task_Devices

  static const String getTaskDevicesStatus = '/api/task/devices';
  static const String postTaskDevicesStatus = '/api/task/devices';
  static const String deleteTaskDevicesStatus = '/api/task/devices';

  //Task_workers

  static const String getTaskWorkersStatus = '/api/task/wokers';
  static const String postTaskWorkersStatus = '/api/task/wokers';
  static const String deleteTaskWorkersStatus = '/api/task/wokers';

//Cobot_Device
  static const String getDeviceCobot = '/api/device/cobot';
  static const String postDeviceCobot = '/api/device/cobot';

  static const String patchDeviceCobotStatus = '/api/device/cobot/status';

  static const String patchDeviceCobotMode = '/api/device/cobot/mode';

  //tenant
  static const String getTenant = '/api/tenant';
  static const String postTenant = '/api/tenant';

  //manufacturer
  static const String getManufacturer = '/api/manufacturer';
  static const String postManufacturer = '/api/manufacturer';
}
