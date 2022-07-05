
import 'package:flutter/material.dart';

import '../../data/local/cache_helper.dart';
import '../../data/local/local_data.dart';
import '../../main.dart';
import '../styles/colors.dart';

class ChangeLangButton extends StatefulWidget {
  const ChangeLangButton({Key? key}) : super(key: key);

  @override
  State<ChangeLangButton> createState() => _ChangeLangButtonState();
}

class _ChangeLangButtonState extends State<ChangeLangButton> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
          ),
          width: MediaQuery.of(context).size.width*0.30,
          height: 53,
          padding: const EdgeInsets.only(top: 16.0, right: 16.0),
          child: ElevatedButton(
            child:  Text(
              lang == "ar" ? "english" : "عربي",
              style: const TextStyle(color: AppColor.blue , fontSize: 18.0),
            ),
            onPressed: () {
              if (lang == "ar") {
                lang = "en";
                CacheHelper.saveDataSharedPreference(key: 'lang', value: "en");
                MyHomePageApp.setLocale(context, const Locale.fromSubtags(languageCode: 'en'));
              } else {
                lang = "ar";
                CacheHelper.saveDataSharedPreference(key: 'lang', value: "ar");
                MyHomePageApp.setLocale(context, const Locale.fromSubtags(languageCode: 'ar'));
              }


              setState(() {

              });

            },
            style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all(AppColor.white),
            ),
          ),
        ),
      ),
    );
  }
}
