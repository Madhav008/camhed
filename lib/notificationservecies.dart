import 'package:dio/dio.dart';

class NotificationServices {
  void sendDoctorProfileNotification() async {
    try {
      var response =
          await Dio().post('https://onesignal.com/api/v1/notifications',
              options: Options(headers: {
                "Content-Type": "application/json;charset=utf-8",
                "Authorization":
                    "Basic Y2Q2NjgwMmMtZjI0My00MDcwLTk1ZDYtNjM1MTVmYjZkMGVl"
              }),
              data: {
            'app_id': "5d44a640-c2bb-46bc-8ddf-85c9fe35af10",
            'included_segments': ["Admin"],
            'contents': {'en': "New Doctor Request Is There"},
            'data': {'id': "bar"}
          });
    } catch (e) {
      print(e);
    }
  }

  void sendDoctorStatusNotification(String docNotId) async {
    try {
      var response =
          await Dio().post('https://onesignal.com/api/v1/notifications',
              options: Options(headers: {
                "Content-Type": "application/json;charset=utf-8",
                "Authorization":
                    "Basic Y2Q2NjgwMmMtZjI0My00MDcwLTk1ZDYtNjM1MTVmYjZkMGVl"
              }),
              data: {
            'app_id': "5d44a640-c2bb-46bc-8ddf-85c9fe35af10",
            'include_external_user_ids': [docNotId],
            'contents': {'en': "Check Your Request Progress"},
            'data': {'foo': "bar"}
          });
    } catch (e) {
      print(e);
    }
  }
}
