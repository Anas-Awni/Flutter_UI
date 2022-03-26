import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marquee/marquee.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'form_field.dart';
import 'my_color.dart';
import 'p_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? decision = prefs.getBool('x');

  Widget _screen =
      (decision == false || decision == null) ? const PView() : const MyApp();

  runApp(_screen);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: ThemeData(canvasColor: Colors.white),
      darkTheme: ThemeData(canvasColor: Colors.black),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String str = 'Flutter Demo';

  int _currentIndex = 0;
  List imgList = [
    'images/s1.jpg',
    'images/s2.jpg',
    'images/s3.jpg',
  ];

  ThemeMode tm = ThemeMode.light;
  bool _swVal = false;

  int _radioValue = 0;
  String result = '';
  Color resultColor = Colors.green;

  bool js = false;
  bool cSharp = false;
  bool python = false;

  String get txt {
    String str = 'You Selected:\n';
    if (js == true) str += 'Javascript\n';
    if (cSharp == true) str += 'C#\n';
    if (python == true)
      str += 'Python\n';
    else
      str += 'None\n';

    return str;
  }

  String? _selectedLetter;
  final List<String> _letterList = ['A', 'B', 'C', 'D', 'E', 'F', 'G'];

  double _value = 0.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: tm,
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 1),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.account_circle),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.account_circle),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.account_circle),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.account_circle),
            ),
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Colors.deepPurpleAccent,
                Colors.pink,
                Colors.deepPurpleAccent,
              ],
            )),
          ),
          centerTitle: true,
          title: Text(
            str,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: buildDismisible(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => buildSnackBar(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  //Lesson #1 Toast
  void buildToast(BuildContext ctx) {
    showToast(
      'Pink/Amber',
      backgroundColor: Colors.amber,
      textStyle: const TextStyle(color: Colors.pink),
      context: ctx,
      animation: StyledToastAnimation.scale,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.center,
      animDuration: const Duration(seconds: 1),
      duration: const Duration(seconds: 4),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
    );
  }

  //Lesson #3 AlertDialog
  void buildDialog(BuildContext ctx) {
    final AlertDialog alert = AlertDialog(
      title: const Text('Dialog Title'),
      content: SizedBox(
        height: 150,
        child: Column(
          children: [
            const Divider(color: Colors.black),
            const Text(
                'Dialog Text Appear Here You Can type AnyThing You Want!'),
            const SizedBox(height: 7),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                child: const Text('Close !',
                    style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
      context: ctx,
      builder: (_) => alert,
      barrierDismissible: false,
      barrierColor: Colors.red.withOpacity(0.3),
    );
  }

  //Lesson #4 SnackBar
  void buildSnackBar(BuildContext ctx) {
    final sBar = SnackBar(
      action: SnackBarAction(
        textColor: Colors.black,
        label: 'Undo!',
        onPressed: () {
          setState(() {
            str = 'Flutter Demo';
          });
        },
      ),
      content: const Text('SnackBar Text'),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    );
    ScaffoldMessenger.of(ctx).showSnackBar(sBar);
  }

  //Lesson #5 Flushbar
  void buildFlushBar(BuildContext ctx) {
    Flushbar(
      duration: const Duration(seconds: 2),
      flushbarPosition: FlushbarPosition.TOP,
      mainButton: TextButton(
        child: const Text('Close!'),
        onPressed: () {
          Navigator.of(ctx).pop();
        },
      ),
      icon: const Icon(Icons.info, color: Colors.white),
      backgroundColor: Colors.amber,
      title: 'This Is The Title',
      messageText: const Text('This Is The Message',
          style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold)),
    ).show(ctx);
  }

  // Lesson #6 Overflow softWrap SelectableText
  Widget someTextProperty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const SelectableText(
          "I'm A Copiable Text Select Me And See What Gonna Happen!",
          showCursor: true,
          cursorColor: Colors.green,
          cursorWidth: 10,
          toolbarOptions: ToolbarOptions(
            copy: true,
            selectAll: true,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 200,
          height: 40,
          color: Colors.green,
          child: const Text(
            'This Is A Clipped Text,This Is A Clipped Text,This Is A Clipped Text,This Is A Clipped Text',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            overflow: TextOverflow.clip,
            softWrap: false,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 200,
          height: 40,
          color: Colors.green,
          child: const Text(
            'This Is A Ellipsis Text,This Is A Ellipsis Text,This Is A Ellipsis Text,This Is A Ellipsis Text',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 200,
          height: 40,
          color: Colors.green,
          child: const Text(
            'This Is A Faded Text,This Is A Faded Text,This Is A Faded Text,This Is A Faded Text',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            overflow: TextOverflow.fade,
            softWrap: false,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 200,
          height: 40,
          color: Colors.green,
          child: const Text(
            'This Is A Visible Text,This Is A Visible Text,This Is A Visible Text,This Is A Visible Text',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            overflow: TextOverflow.visible,
            softWrap: false,
          ),
        ),
      ],
    );
  }

  //Lesson #7, 8 Image Slider (Carousel)
  Widget buildCarousel() {
    Widget buildContainer(index) {
      return Container(
        width: 10,
        height: 10,
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentIndex == index ? Colors.redAccent : Colors.green,
        ),
      );
    }

    return ListView(
      children: [
        const SizedBox(height: 30),
        const Text(
          'Slider 1: Initial Page Index 0\n\n',
          textAlign: TextAlign.center,
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: 186,
            initialPage: 0,
            autoPlay: true,
            onPageChanged: (index, _) {
              setState(() {
                _currentIndex = index;
              });
            },
            autoPlayInterval: const Duration(seconds: 3),
            enableInfiniteScroll: true,
            enlargeCenterPage: true,
          ),
          items: imgList.map((imageUrl) {
            return SizedBox(
              width: double.infinity,
              //margin: EdgeInsets.symmetric(horizontal: 10),
              child: Image.asset(imageUrl, fit: BoxFit.fill),
            );
          }).toList(),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildContainer(0),
            buildContainer(1),
            buildContainer(2),
          ],
        ),
        const SizedBox(height: 30),
        const Text(
          'Slider 2: Initial Page Index 1\n\n',
          textAlign: TextAlign.center,
        ),
        CarouselSlider.builder(
          itemCount: imgList.length,
          itemBuilder: (ctx, int index, _) {
            return SizedBox(
              width: double.infinity,
              //margin: EdgeInsets.symmetric(horizontal: 10),
              child: Image.asset(imgList[index], fit: BoxFit.fill),
            );
          },
          options: CarouselOptions(
            height: 186,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 2),
            enlargeCenterPage: true,
            scrollDirection: Axis.vertical,
            //reverse: true,
            pauseAutoPlayOnTouch: false,
            enableInfiniteScroll: false,
            initialPage: 0,
          ),
        ),
      ],
    );
  }

  //Lesson #9 Radio Button
  Widget buildRadio(BuildContext ctx) {
    Widget buildRow(int value) {
      myDialog() {
        var ad = AlertDialog(
          content: SizedBox(
            height: 100,
            child: Column(
              children: [
                Text(result, style: TextStyle(color: resultColor)),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Text('Answer Is:4'),
                ),
              ],
            ),
          ),
        );
        showDialog(context: ctx, builder: (BuildContext context) => ad);
      }

      return Row(
        children: [
          Radio(
            value: value,
            groupValue: _radioValue,
            onChanged: (value) {
              setState(() {
                _radioValue = int.parse(value.toString());
                result = value == 4 ? 'Correct Answer!' : 'Wrong Answer!';
                resultColor = value == 4 ? Colors.green : Colors.redAccent;
                myDialog();
              });
            },
          ),
          Text('$value'),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text(
            ' Guess The Answer : 2+2=?',
            style: TextStyle(
              color: Colors.lightBlue,
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
          buildRow(3),
          buildRow(4),
          buildRow(5),
        ],
      ),
    );
  }

  //Lesson #10 RadioListTile
  Widget buildRadioListTile(int val, String txt, String subTxt) {
    return RadioListTile<int>(
      value: val,
      groupValue: _radioValue,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (int? value3) {
        setState(() {
          _radioValue = value3!;
        });
      },
      title: Text(txt),
      subtitle: Text(subTxt, style: const TextStyle(color: Colors.white)),
    );
  }

  //Lesson #11 Checkbox
  Widget buildCheckbox(BuildContext ctx) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          const Text('Select All The Programing Languages You Know:'),
          Row(
            children: [
              Checkbox(
                value: js,
                onChanged: (value) {
                  setState(() {
                    js = value!;
                  });
                },
              ),
              const Text('JS'),
            ],
          ),
          CheckboxListTile(
            value: cSharp,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {
              setState(() {
                cSharp = value!;
              });
            },
            title: const Text('C#'),
          ),
          Row(
            children: [
              Checkbox(
                value: python,
                onChanged: (value) {
                  setState(() {
                    python = value!;
                  });
                },
              ),
              const Text('Python'),
            ],
          ),
          ElevatedButton(
            child: const Text('Apply!'),
            onPressed: () {
              var ad = AlertDialog(
                title: const Text('Thank You For Applying!'),
                content: Text(txt),
              );
              showDialog(context: ctx, builder: (_) => ad);
            },
          )
        ],
      ),
    );
  }

  //Lesson #12 Switch (ThemeMode)
  Widget buildSwitch() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(40),
            child: Text('Light'),
          ),
          Switch(
            value: _swVal,
            onChanged: (bool value) {
              setState(() {
                _swVal = value;

                if (_swVal == false)
                  tm = ThemeMode.light;
                else
                  tm = ThemeMode.dark;
              });
            },
            // activeColor: Colors.white,
            // activeTrackColor: Colors.white,
            inactiveThumbColor: Colors.blue,
          ),
          const Padding(
            padding: EdgeInsets.all(40),
            child: Text('Dark'),
          ),
        ],
      ),
    );
  }

  //Lesson #13 DropdownButton (Combo Box)
  Widget buildDropdownButton() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Select a Letter!'),
          const SizedBox(width: 10),
          DropdownButton(
            hint: const Text('A!!!'),
            value: _selectedLetter,
            items: _letterList.map((String item) {
              return DropdownMenuItem(
                child: Text(item),
                value: item,
              );
            }).toList(),
            onChanged: (newVal) {
              setState(() {
                _selectedLetter = newVal.toString();
              });
            },
          ),
        ],
      ),
    );
  }

  //Lesson #14 ExpansionTile
  Widget buildExpansionTile(BuildContext ctx) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: ExpansionTile(
            backgroundColor: Colors.blueGrey,
            leading: const Icon(Icons.perm_identity),
            title: const Text('Account'),
            children: [
              const Divider(color: Colors.grey),
              Card(
                color: Colors.grey,
                child: ListTile(
                  leading: const Icon(Icons.add),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  title: const Text('Sign Up!'),
                  subtitle: const Text('Where You Can Register An Account'),
                  onTap: () => buildSnackBar(ctx),
                ),
              ),
              Card(
                color: Colors.grey,
                child: ListTile(
                  leading: const Icon(Icons.account_circle),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  title: const Text('Sign In!'),
                  subtitle: const Text('Where You Can Login With Your Account'),
                  onTap: () => buildSnackBar(ctx),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: ExpansionTile(
            backgroundColor: Colors.blueGrey,
            leading: const Icon(Icons.message),
            title: const Text('MoreInfo'),
            children: [
              const Divider(color: Colors.grey),
              Card(
                color: Colors.grey,
                child: ListTile(
                  leading: const Icon(Icons.phone),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  title: const Text('Contact'),
                  subtitle: const Text('Where You Can Call Us'),
                  onTap: () => buildSnackBar(ctx),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //Lesson #15 Marquee
  Widget buildMarquee() {
    return Marquee(
      text: 'Some sample text that takes some space.',
      style: const TextStyle(fontWeight: FontWeight.bold),
      scrollAxis: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      blankSpace: 20.0,
      velocity: 100.0,
      pauseAfterRound: const Duration(seconds: 1),
      startPadding: 10.0,
      accelerationDuration: const Duration(seconds: 1),
      accelerationCurve: Curves.linear,
      decelerationDuration: const Duration(milliseconds: 500),
      decelerationCurve: Curves.easeOut,
    );
  }

  //Lesson #16 ImagePicker
  Widget buildImagePicker(BuildContext ctx) {
    File? _selectedImage;
    Future getImage(ImageSource src) async {
      final XFile? pickedFile = await ImagePicker().pickImage(source: src);

      if (pickedFile != null) {
        print('Image selected.');
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
        return _selectedImage;
      } else {
        print('No image selected.');
      }
    }

    Builder buildDialogItem(
        BuildContext context, String text, IconData icon, ImageSource src) {
      return Builder(
        builder: (innerContext) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            leading: Icon(icon, color: Colors.white),
            title: Text(text),
            onTap: () async {
              getImage(src);
              Navigator.of(innerContext).pop();
            },
          ),
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.indigo),
            ),
            child: const Text('Choose Image'),
            onPressed: () {
              var ad = AlertDialog(
                title: const Text('Choose Picture from:'),
                content: SizedBox(
                  height: 150,
                  child: Column(
                    children: [
                      const Divider(color: Colors.black),
                      buildDialogItem(ctx, 'Camera', Icons.add_a_photo_outlined,
                          ImageSource.camera),
                      const SizedBox(height: 10),
                      buildDialogItem(ctx, 'Gallery', Icons.image_outlined,
                          ImageSource.gallery),
                    ],
                  ),
                ),
              );
              showDialog(
                  context: ctx,
                  builder: (BuildContext context) {
                    return ad;
                  });
            },
          ),
        ),
        _selectedImage == null ? const Center() : Image.file(_selectedImage!),
      ],
    );
  }

  //Lesson #17 ColorPicker
  Color currentColor = Colors.teal;
  void changeColor(Color color) => setState(() => currentColor = color);
  final List<Color> _defaultColors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
    Colors.black,
  ];
  Widget buildColorPicker(BuildContext ctx) {
    return Center(
      child: ElevatedButton(
        child: const Text('Change my color'),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(currentColor),
        ),
        onPressed: () {
          showDialog(
            context: ctx,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Select a color'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SingleChildScrollView(
                      child: BlockPicker(
                        onColorChanged: changeColor,
                        pickerColor: currentColor,
                        availableColors: _defaultColors,
                      ),
                    ),
                    ElevatedButton(
                      child: const Text('Close'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  //Lesson #18 PercentIndicator
  final li = List<String>.generate(20, (index) => 'Item Num ${index + 1}');
  Widget buildDismisible() {
    return ListView.builder(
      itemCount: li.length,
      itemBuilder: (BuildContext context, int index) {
        final item = li[index];
        return Dismissible(
          key: Key(item),
          onDismissed: (DismissDirection dir) {
            setState(() => li.removeAt(index));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                action: SnackBarAction(
                  label: 'Undo!',
                  onPressed: () => setState(() => li.insert(index, item)),
                ),
                content: Text(
                  dir == DismissDirection.startToEnd
                      ? '$item  Deleted'
                      : '$item Liked',
                ),
              ),
            );
          },
          confirmDismiss: (DismissDirection direction) async {
            if (direction == DismissDirection.startToEnd)
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Delete Confirmation'),
                    content: Text('Are you sure you want to delete $item?'),
                    actions: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                        ),
                        onPressed: () {
                          setState(() => li.removeAt(index));
                          Navigator.of(context).pop(true);
                        },
                        child: const Text('Delete'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Cancel'),
                      ),
                    ],
                  );
                },
              );
            else
              return true;
          },
          child: ListTile(title: Center(child: Text(item))),
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                SizedBox(width: 20),
                Icon(Icons.delete, color: Colors.white),
                Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          secondaryBackground: Container(
            color: Colors.green,
            alignment: Alignment.centerRight,
            child: const Icon(Icons.thumb_up),
          ),
        );
      },
    );
  }

  //Lesson #19 PercentIndicator
  Widget buildPercentIndicator() {
    return Center(
      child: ListView(
        children: <Widget>[
          CircularPercentIndicator(
            radius: 100.0,
            lineWidth: 10.0,
            percent: 0.8,
            header: const Text('Icon header'),
            center: const Icon(
              Icons.person_pin,
              size: 50.0,
              color: Colors.blue,
            ),
            backgroundColor: Colors.grey,
            progressColor: Colors.blue,
          ),
          const SizedBox(height: 10),
          CircularPercentIndicator(
            radius: 120.0,
            lineWidth: 13.0,
            animation: true,
            percent: 0.7,
            center: const Text(
              '70.0%',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            footer: const Text(
              'Sales this week',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
            ),
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: Colors.purple,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: LinearPercentIndicator(
              width: 140.0,
              lineHeight: 14.0,
              percent: 0.5,
              center: const Text(
                '50.0%',
                style: TextStyle(fontSize: 12.0),
              ),
              trailing: const Icon(Icons.mood),
              linearStrokeCap: LinearStrokeCap.roundAll,
              backgroundColor: Colors.grey,
              progressColor: Colors.blue,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: LinearPercentIndicator(
              width: 170.0,
              animation: true,
              animationDuration: 1000,
              lineHeight: 20.0,
              leading: const Text('left content'),
              trailing: const Text('right content'),
              percent: 0.2,
              center: const Text('20.0%'),
              linearStrokeCap: LinearStrokeCap.butt,
              progressColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  //Lesson #20 ListWheelScrollView
  Widget buildListWheel() {
    const List<String> nameList = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    List<Color> colorList =
        List.generate(nameList.length, (index) => Colors.primaries[index]);

    int _i = 0;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: ListWheelScrollView(
        itemExtent: 100,
        children: [
          ...nameList.map((String name) {
            return Container(
              decoration: BoxDecoration(
                color: colorList[_i++],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.red),
              ),
              width: double.infinity,
              child: Text(
                name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                textAlign: TextAlign.center,
              ),
            );
          })
        ],
      ),
    );
  }

  //Lesson #21 PercentIndicator
  Widget buildInteractiveViewer() {
    return Center(
      child: SizedBox(
        height: 400,
        width: double.infinity,
        child: InteractiveViewer(
          boundaryMargin: const EdgeInsets.all(42),
          panEnabled: true,
          scaleEnabled: true,
          constrained: false,
          minScale: 0.3,
          maxScale: 4,
          child: Image.asset('images/q4.jpg', fit: BoxFit.cover),
        ),
      ),
    );
  }
}
