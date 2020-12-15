import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:geolocator/geolocator.dart';

class whatsapplink extends StatefulWidget {
  @override
  _whatsapplinkState createState() => _whatsapplinkState();
}

class _whatsapplinkState extends State<whatsapplink> {
  final TextEditingController number = TextEditingController();
  final TextEditingController txt = TextEditingController();
  // countrycode this is the default code number modifcode try to eleminate the the plus
  String countrycode = "966";
  String modifcode;
  String locat;
  String txtlocation = "Dear, This is my location \n عزيزي هذا هو موقعي \n";

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    number.dispose();
    super.dispose();
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
          Icon(Icons.sms),
        ],
      ),
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
                  /* RaisedButton(
                    color: Colors.green,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Share Location",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.location_on,
                          color: Colors.white,
                        )
                      ],
                    ),
                    onPressed: () async {
                      Position position = await Geolocator.getCurrentPosition(
                          desiredAccuracy: LocationAccuracy.best);
                      print(position);
                      print(position.longitude);
                      print(position.latitude);
                      print(
                          "https://www.google.com.sa/maps/@${position.latitude},${position.longitude}");
                      // locat = "https://www.google.com.sa/maps/@${position.latitude},${position.longitude}";
                      // locat =
                      // "https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}";
                      locat =
                          "https://maps.google.com/?q=${position.latitude},${position.longitude}";
                      print("}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}");
                      print(locat);
                      print(
                          "https://wa.me/$countrycode${number.text}?text=${txt.text}$locat");
                      await launch(
                          "https://wa.me/$countrycode${number.text}?text=$txtlocation$locat");
                    },
                  ), */

                  /* RaisedButton(
                    color: Colors.green,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Chat with ${number.text}",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.sms,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    onPressed: () async {
                      if (await canLaunch("http://www.google.com")) {
                        // await launch("http://api.whatsapp.com/send?phone= ${number.text}");
                        modifcode = countrycode.replaceAll(
                                new RegExp(r'[^\w\s]+'), '') +
                            number.text;
                        print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
                        print(modifcode);
                        await launch(
                            "https://wa.me/$countrycode${number.text}?text=${txt.text}");
                        print("------------@@@@@--------------");
                        print(number.text);
                        print(countrycode);
                        print(
                            "https://wa.me/$countrycode${number.text}?text=${txt.text}");
                        print(countrycode.replaceAll(
                            new RegExp(r'[^\w\s]+'), ''));
                      }
                    },
                  ), */
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*  CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 50,
                        child: Icon(
                          Icons.mail_rounded,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 50,
                        child: Icon(
                          Icons.map_rounded,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),*/
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
                          Position position =
                              await Geolocator.getCurrentPosition(
                                  desiredAccuracy: LocationAccuracy.best);
                          locat =
                              "https://maps.google.com/?q=${position.latitude},${position.longitude}";
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
}
