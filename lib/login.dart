// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'dart:developer';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:tvc_all/LoginApi/GetURLApi.dart';
import 'package:tvc_all/LoginApi/LoginApi.dart';
import 'package:tvc_all/LoginApi/Url.dart';
import 'package:tvc_all/LoginApi/constantvalues.dart';
import 'package:tvc_all/LoginApi/helperfunction.dart';
import 'package:tvc_all/LoginApi/loginmodel.dart';
import 'package:tvc_all/api/login%20api/login%20api.dart';
import 'package:tvc_all/firstpage.dart';
import 'package:tvc_all/models/login%20model/loginmodel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AudioPlayer _audioPlayer = AudioPlayer();
  late AudioCache audioCache = AudioCache();
  // late AudioPlayer _audioPlayer;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _deviceId = '';

  @override
  void initState() {
    _audioPlayer = AudioPlayer();
    log("Login Api init");
    _audioPlayer = AudioPlayer();

    // Set the release mode to keep the source after playback has completed.
    _audioPlayer.setReleaseMode(ReleaseMode.stop);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _fetchDeviceId();
      await _audioPlayer.play(AssetSource('hiiiii.mp3'));
      Logindatalist.clear();
      // loginapicall();
    });
  }

  Future<void> playasset() async {
    // setState(() {

    await _audioPlayer.play(AssetSource('hiiiii.mp3'));
    _audioPlayer.resume();
    // });
  }

  List<LoginItems> Logindatalist = [];
  loginapicall() async {
    log("binmatrix::");
    await GetLoginApi.getdata().then((value) {
      if (value.stcode == 200) {
        playasset();
        if (value.loginorder != null) {
          setState(() {
            Logindatalist = value.loginorder!.logindetails!;
          });
        }
      }
    });
  }

  Future<void> _fetchDeviceId() async {
    final deviceId = await getdeviceId();
    setState(() {
      _deviceId =
          deviceId ?? 'No Device ID'; // Set the device ID or a default message
    });
    print('Device ID: $_deviceId'); // Print the device ID in the console
  }

  static Future<String?> getdeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
    return null;
  }

  disableKeyBoard(BuildContext context) {
    FocusScopeNode focus = FocusScope.of(context);
    if (!focus.hasPrimaryFocus) {
      focus.unfocus();
    }
  }

  setURL() async {
    String? getUrl = await HelperFunctions.getHostDSP();
    String hostip = '';
    for (int i = 0; i < getUrl!.length; i++) {
      if (getUrl[i] == ":") {
        break;
      }
      // log("for ${hostip}");
      hostip = hostip + getUrl[i];
    }
    // log("for last ${hostip}");
    HelperFunctions.savehostIP(hostip);
    ConstantValues.userNamePM = await HelperFunctions.getUserName();
    Url.queryApi = "${getUrl.toString()}/api/";
  }

  bool isLoading = false;
  bool erroMsgVisble = false;
  bool settingError = false;
  void loginMethod() async {
    if (mycontroller[3].text.toString().trim().isEmpty) {
      errorMsh = "Complete the setup..!!";
    } else {
      if (formkey.currentState!.validate()) {
        disableKeyBoard(context);
        isLoading = true;
        String? Url = "";
        //Get Url Api
        print("get Url Api call:" + mycontroller[3].text.toString());
        await GetURLApi.getData(mycontroller[3].text.toString().trim())
            .then((value) async {
          if (value.stcode! >= 200 && value.stcode! <= 210) {
            if (value.url1 != null) {
              Url = value.url1;
              log("url method::" + Url.toString());
              await HelperFunctions.saveHostSP(Url!.trim());
              await HelperFunctions.saveTenetIDSharedPreference(
                  mycontroller[3].text.toString().trim());
              setState(() {
                setURL();
                errorMsh = "";
                erroMsgVisble = false;
                settingError = false;
              });
            } else {
              log("object1:" + value.exception.toString());
              erroMsgVisble = true;
              isLoading = false;
              errorMsh = value.exception.toString();
            }
          } else {
            log("object2:" + value.exception.toString());
            erroMsgVisble = true;
            isLoading = false;
            errorMsh = value.exception.toString();
          }
        });

        //
        // await getUrlApi();
        //**** */
        // log("is is is ");
        // notifyListeners();
        String? deviceid = '';
        PostLoginData postLoginData = new PostLoginData();
        deviceid = await HelperFunctions.getDeviceIDSharedPreference();

        if (deviceid == null) {
          deviceid = await getdeviceId();

          log("deviceid:::" + deviceid.toString());
        }
        postLoginData.deviceCode = deviceid;
        _deviceId = deviceid!;
        postLoginData.licenseKey =
            await HelperFunctions.getLicenseKeySharedPreference();
        postLoginData.fcmToken =
            await HelperFunctions.getFCMTokenSharedPreference();
        // log("fcmmmm: "+postLoginData.fcmToken.toString());
        postLoginData.username = mycontroller[0].text;
        postLoginData.password = mycontroller[1].text;
        ConstantValues.tenetID =
            await HelperFunctions.getTenetIDSharedPreference();

        await LoginAPi.getData(postLoginData).then((value) async {
          if (value.resCode! >= 200 && value.resCode! <= 200) {
            if (value.loginstatus!.toLowerCase().contains('success') &&
                value.data != null) {
              // DashBoardController.isLogout = false;
              isLoading = false;
              erroMsgVisble = false;
              errorMsh = '';
              ConstantValues.userNamePM = mycontroller[0].text;
              await HelperFunctions.saveUserName(mycontroller[0].text);
              await HelperFunctions.saveLicenseKeySharedPreference(
                  value.data!.licenseKey);
              await HelperFunctions.saveLogginUserCodeSharedPreference(
                  mycontroller[0].text);
              // await HelperFunctions.saveSapUrlSharedPreference(
              //     value.data!.endPointUrl);
              await HelperFunctions.saveTenetIDSharedPreference(
                  value.data!.tenantId);
              await HelperFunctions.saveUserIDSharedPreference(
                  value.data!.UserID);
              ConstantValues.UserId = value.data!.UserID;
              // ConstantValues.storeid =
              //     int.parse(value.data!.storeid.toString());
              ConstantValues.Storecode = value.data!.whsecode.toString();
              await HelperFunctions.saveUserLoggedInSharedPreference(true);
              await HelperFunctions.savePasswordSharedPreference(
                  mycontroller[1].text);

              log("message");
              // await HelperFunctions.saveuserDB(value.data!.userDB);
              await HelperFunctions.savedbUserName(value.data!.UserID);
              // await HelperFunctions.savedbPassword(value.data!.dbPassword);

              await HelperFunctions.saveUserType(value.data!.userType);
              await HelperFunctions.saveSlpCode(value.data!.slpcode);

              mycontroller[0].clear();
              mycontroller[1].clear();

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NavigationPage()),
              );
              // notifyListeners();
              // Get.offAllNamed(ConstantRoutes.download);
            } else if (value.loginstatus!.toLowerCase().contains("failed") &&
                value.data == null) {
              setState(() {
                isLoading = false;
                erroMsgVisble = true;
                errorMsh = value.loginMsg!;
              });

              // notifyListeners();
            }
          } else if (value.resCode! >= 400 && value.resCode! <= 410) {
            setState(() {
              erroMsgVisble = true;
              isLoading = false;
              errorMsh = value.excep!;
            });

            // notifyListeners();
          } else {
            if (value.excep == 'No route to host') {
              setState(() {
                isLoading = false;
                erroMsgVisble = true;
                errorMsh = 'Check your internet Connection...!!';
              });
            } else {
              setState(() {
                isLoading = false;
                erroMsgVisble = true;
                errorMsh = '${value.excep!}--${value.resCode}...!!';
              });
            }
            // notifyListeners();
          }
        });
        // Get.offAllNamed(ConstantRoutes.dashboard);
      }
    }
  }

  String? errorMsh = '';
  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  GlobalKey<FormState> formkey2 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Big Display'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text('Device ID - $_deviceId')),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Center-align the content
              children: [
                Text(
                  'Sign in',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                // Text(
                //   "${Logindatalist[i].DisplayId}",
                //   style: Theme.of(context).textTheme.headlineMedium,
                // ),
                const SizedBox(height: 20),
                Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("$errorMsh"),
                      SizedBox(
                        width: 250, // Reduce width of the input fields
                        child: TextFormField(
                          controller: mycontroller[3],
                          decoration: const InputDecoration(
                            labelText: 'Usercode',
                            labelStyle:
                                TextStyle(fontSize: 14), // Smaller text size
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 12), // Smaller padding
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 250, // Reduce width of the input fields
                        child: TextFormField(
                          controller: mycontroller[0],
                          decoration: const InputDecoration(
                            labelText: 'Username',
                            labelStyle:
                                TextStyle(fontSize: 14), // Smaller text size
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 12), // Smaller padding
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                      ),
                      // const SizedBox(height: 1),
                      SizedBox(
                        width: 250, // Reduce width of the input fields
                        child: TextFormField(
                          controller: mycontroller[1],
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            labelStyle:
                                TextStyle(fontSize: 14), // Smaller text size
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 12), // Smaller padding
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            // Perform login action
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                          GetLoginApi();
                          _fetchDeviceId();
                          loginMethod();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue, // Text color
                          shadowColor: Colors.blueAccent, // Shadow color
                          elevation: 5, // Elevation
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(30.0), // Rounded corners
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 15.0), // Padding
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 18), // Text style
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              playasset();
                            });
                          },
                          child: const Text('sound')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> playsound() async {
    // audioCache.("music/music1.mp3");
    // _audioPlayer.setSourceAsset('assets/simple-notification-152054.mp3');
    // _audioPlayer.setReleaseMode(ReleaseMode.stop);
    // log('sound played');
    // await _audioPlayer.play(AssetSource("c"));
  }
}
