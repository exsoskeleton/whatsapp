import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:url_launcher/url_launcher.dart';



class trailtwo extends StatefulWidget {
  @override
  _trailtwoState createState() => _trailtwoState();
}

class _trailtwoState extends State<trailtwo> {
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _location ;
  //-----------------------------------------
  final TextEditingController number = TextEditingController();
  final TextEditingController txt = TextEditingController();
  // countrycode this is the default code number modifcode try to eleminate the the plus
  String countrycode = "966";
  String modifcode;
  String locat;
  String txtlocation = "Dear, This is my location \n عزيزي هذا هو موقعي \n";
//-------------------------------------------------------------------------
  //------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    number.dispose();
    txt.dispose();
    super.dispose();
  }
  //------------------------------------------



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLocationServicesInDevice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          "Send to Any Number",
          textAlign: TextAlign.start,
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        // leading: Image.asset('assets/images/whatsappicon.png',fit: BoxFit.contain,height: 32,),
        actions: [
          FlatButton.icon(
              onPressed: (){
                SystemNavigator.pop();
           },
            label: Text(""),
            icon: Icon (Icons.exit_to_app_sharp,color:Colors.white),
          ),
         // Icon(Icons.sms),
          Padding(padding: EdgeInsets.all(5),),

        ],
      ),

     // body: Center(),
//---------------------------------
      body: ListView(
        children: [
          Padding(
              padding: EdgeInsets.all(50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                      ),

                      //====================
                      Center(
                        child: CountryListPick(
                          appBar: AppBar(
                            backgroundColor: Colors.green,
                            title: Text('إختر الدولة'),
                          ),
                          // if you need custome picker use this
                          // pickerBuilder: (context, CountryCode countryCode) {
                          //   return Row(
                          //     children: [
                          //       Image.asset(
                          //         countryCode.flagUri,
                          //         package: 'country_list_pick',
                          //       ),
                          //       Text(countryCode.code),
                          //       Text(countryCode.dialCode),
                          //     ],
                          //   );
                          // },
                          theme: CountryTheme(
                            isShowFlag: true,
                            isShowTitle: false,
                            isShowCode: true,
                            isDownIcon: true,
                            showEnglishName: true,
                          ),
                          initialSelection: '+966',
                          onChanged: (CountryCode code) {
                            print("-------------------------------------");
                            print(code.name);
                            print(code.code);
                            print(code.dialCode);
                            print(code.flagUri);
                            countrycode = code.dialCode;
                            print("---------------");
                          },
                        ),
                      ),
                      //=============
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          controller: number,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 100,
                    child: SingleChildScrollView(
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: TextStyle(
                          color: Colors.green[700],
                          fontSize: 15,
                        ),
                        decoration: InputDecoration(
                          hintText: "Input your massage",
                          contentPadding: EdgeInsets.all(20),
                        ),
                        controller: txt,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () async => {
                          if (await canLaunch("http://www.google.com"))
                            {
                              modifcode = countrycode.replaceAll(
                                  new RegExp(r'[^\w\s]+'), '') +
                                  number.text
                            },
                          await launch(
                              "https://wa.me/$countrycode${number.text}?text=${txt.text}")
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 50,
                          child: Icon(
                            Icons.mail_rounded,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {


                          await launch(
                              "https://wa.me/$countrycode${number.text}?text=$txtlocation$locat");
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 50,
                          child: Icon(
                            Icons.map_rounded,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ],
      ),
    );
  }
//---------------------------------






  Future<void> checkLocationServicesInDevice() async {

    Location location = new Location();
    _serviceEnabled = await location.serviceEnabled();
    if(_serviceEnabled){
      print("GPS enabled");
      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.granted)
        {
          print("Start tracking-------- 1");
        //  _location = await location.getLocation();
         // print(_location.longitude.toString() + "  " + _location.latitude.toString());
          location.onLocationChanged.listen((LocationData currentLocation) {
            // Use current location
            print(currentLocation.longitude.toString() + "  " + currentLocation.latitude.toString());
            //-------------------------------------
            locat =
            "https://maps.google.com/?q=${currentLocation.latitude},${currentLocation.longitude}";

            //-------------------------------------
          });

        }else {
        _permissionGranted = await location.requestPermission();
        if(_permissionGranted== PermissionStatus.granted)
          {
            print("Start Tracking");

          }else {
         // SystemNavigator.pop();
          _showMyDialog();
          _location = await location.getLocation();
           locat =
          "https://maps.google.com/?q=${_location.latitude},${_location.longitude}";
        }

      }

    }else {
      _serviceEnabled = await location.requestService();
      if (_serviceEnabled)
      {
        print("start tracking--------2");
      }else {
        //SystemNavigator.pop();
        _showMyDialog();
        _location = await location.getLocation();
        locat =
        "https://maps.google.com/?q=${_location.latitude},${_location.longitude}";

      }
    }
  }

  //------------alert massage--------------
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('The App could not get your actual location'),
                Text('We will use most recent location'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
//-----------------------------------------
}
