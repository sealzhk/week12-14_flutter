import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: MyApp(),
));

class BusLine {
  String name;
  String from;
  String to;
  DateTime fromDateTime;
  DateTime toDateTime;
  String seats;
  String carNumber;
  String icon;

  BusLine({
    this.name,
    this.from,
    this.to,
    this.fromDateTime,
    this.toDateTime,
    this.seats,
    this.carNumber,
    this.icon,
  });
}

class Passengers {
  int id;
  String name;
  String phone;
  String mail;
  String price;
  String sit_num;
  String type;

  Passengers({
    this.id,
    this.name,
    this.phone,
    this.mail,
    this.price,
    this.sit_num,
    this.type,
  });
}

class NoName {
  int id;
  String name;
  String price;
  String sit_num;
  String type;

  NoName({
    this.id,
    this.name,
    this.price,
    this.sit_num,
    this.type,
});
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<BusLine> busList = [
    BusLine(
        name: 'YUTONG',
        from: 'Асыката',
        to: 'Алматы',
        fromDateTime: DateTime.parse("2020-02-06 18:39:00"),
        toDateTime: DateTime.parse("2020-02-07 06:10:00"),
        seats: '32 мест',
        carNumber: 'KZ 888 KN02',
        icon: 'asykata.jpeg'),
    BusLine(
        name: 'End2End Test',
        from: 'Город X',
        to: 'Сарыагаш',
        fromDateTime: DateTime.parse("2020-02-06 19:30:00"),
        toDateTime: DateTime.parse("2020-02-07 18:36:00"),
        seats: '53 мест',
        carNumber: 'KZ 123 ABC',
        icon: 'gorodx.jpeg'),
    BusLine(
        name: 'YUTONG',
        from: 'Сарыагаш',
        to: 'Алматы',
        fromDateTime: DateTime.parse("2020-02-06 18:39:00"),
        toDateTime: DateTime.parse("2020-02-07 06:10:00"),
        seats: '32 мест',
        carNumber: 'KZ 888 KN02',
        icon: 'third.jpeg'),
  ];


  Widget _textTemp(text, [fontSize = 18.0, weight = FontWeight.normal]) {
    return Container(
        child: Text(text,
            style: GoogleFonts.roboto(
              textStyle: Theme.of(context).textTheme.headline4,
              fontSize: fontSize,
              fontWeight: weight,
              fontStyle: FontStyle.normal,
              color: Colors.black,
            )));
  }

  Widget cardTemplate(bus) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: new InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PassengerInfo()));
            },
        child: Column(children: <Widget>[
          Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset(
                            'assets/${bus.icon}',
                            fit: BoxFit.fitHeight,
                            width: 130,
                            height: 200,
                          )),
                      SizedBox(height: 5),
                      _textTemp(bus.name, 20.0),
                      SizedBox(height: 5),
                      _textTemp(bus.carNumber, 18.0),
                      SizedBox(height: 5),
                      _textTemp(bus.seats, 18.0)
                    ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          _textTemp(bus.from + ' -', 24.0),
                          _textTemp(bus.to, 24.0),
                          SizedBox(height: 15),
                          _textTemp('Отправление', 20.0, FontWeight.bold),
                          SizedBox(height: 5),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _textTemp(
                                    'Дата  -  ' +
                                        DateFormat('dd.MM.yyyy E')
                                            .format(bus.fromDateTime),
                                    18.0),
                                SizedBox(height: 5),
                                _textTemp(
                                    'Время  -  ' +
                                        DateFormat('HH:mm')
                                            .format(bus.fromDateTime),
                                    18.0)
                              ]),
                          SizedBox(height: 15),
                          _textTemp('Прибытие', 20.0, FontWeight.bold),
                          SizedBox(height: 5),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _textTemp(
                                    'Дата  -  ' +
                                        DateFormat('dd.MM.yyyy E')
                                            .format(bus.toDateTime),
                                    18.0),
                                SizedBox(height: 5),
                                _textTemp(
                                    'Время  -  ' +
                                        DateFormat('HH:mm')
                                            .format(bus.toDateTime),
                                    18.0)
                              ])
                        ])
                  ])),
          FlatButton(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              onPressed: () {
                Widget cancelButton = FlatButton(
                    child: Text("НЕТ",
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                            fontSize: 18.0)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    });
                Widget continueButton = FlatButton(
                    child: Text("ДА",
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                            fontSize: 18.0)),
                    onPressed: () => setState(() {
                      busList.remove(bus);
                      Navigator.of(context).pop();
                    }));

                AlertDialog alert = AlertDialog(
                    content: Text("Вы хотите удалить этот рейс?",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 21.0)),
                    actions: [cancelButton, continueButton]);
                showDialog(context: context, builder: (context) => alert);
              },
              color: Colors.white,
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.green),
                      borderRadius: BorderRadius.circular(7)),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: _textTemp('Удалить рейс')))
        ])));
  }

  Widget _listTile(text, icon) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ListTile(
          leading:
          new IconTheme(data: new IconThemeData(size: 40), child: icon),
          title: Text(text,
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 24,
                  fontWeight: FontWeight.w600)),
          onTap: () => {
            Navigator.pop(context)
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
            toolbarHeight: 65.0,
            title: Align(
                alignment: Alignment.bottomLeft,
                child: Text('Расписание',
                    style: TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 25.0))),
            centerTitle: true,
            backgroundColor: Colors.green),
        body: ListView(
          children: busList.map((bus) => cardTemplate(bus)).toList(),
        ),
        floatingActionButton: FlatButton(
            onPressed: () {},
            child: Container(
                margin: EdgeInsets.fromLTRB(0, 00, 0, 50),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.symmetric(vertical: 17, horizontal: 105),
                child: Text('Добавить рейс',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w400)))),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        drawer: new Drawer(
            child: ListView(padding: EdgeInsets.zero, children: <Widget>[
              DrawerHeader(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(50, 10, 0, 0),
                            child: Text('Test Company',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w500))),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                            child: Text('Alua Zhakiyeva',
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 36,
                                    fontWeight: FontWeight.w800)))
                      ]),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.black87, width: 2)))),
              _listTile('Продажа билетов', Icon(Icons.credit_card)),
              _listTile('Список администраторов', Icon(Icons.people)),
              _listTile(
                'Автобусы',
                Icon(Icons.departure_board),
              ),
              _listTile('Статистика', Icon(Icons.equalizer)),
              _listTile('Пассажиры', Icon(Icons.airline_seat_recline_extra)),
              _listTile('Расписание', Icon(Icons.date_range)),
              _listTile('История', Icon(Icons.library_books)),
              _listTile('Настройки', Icon(Icons.settings)),
            ])));
  }
}

class PassengerInfo extends StatefulWidget {
  @override
  State<PassengerInfo> createState() => new PassengerInfoState();
}

class PassengerInfoState extends State<PassengerInfo> {
  List<Passengers> passList = [
    Passengers(
        id: 1,
        name: 'Aislu',
        phone: '87785667788',
        mail: 'aislu@gmail.com',
        price: '2000',
        sit_num: '0A верхний',
        type: 'offline'
    ),
    Passengers(
        id: 2,
        name: 'Aida',
        phone: '87776665544',
        mail: 'aida@gmail.com',
        price: '2000',
        sit_num: '0B верхний',
        type: 'offline'
    ),
    Passengers(
        id: 3,
        name: 'Bagdat',
        phone: '87575736221',
        mail: 'bagdat@gmail.com',
        price: '2500',
        sit_num: '1 нижний',
        type: 'online'
    ),
    Passengers(
        id: 4,
        name: 'Nazym',
        phone: '83746372812',
        mail: 'nazym@gmail.com',
        price: '2500',
        sit_num: '1 верхний',
        type: 'online'
    ),
  ];

  List<NoName> noName = [
    NoName(
        id: 5,
        name: 'Нет имени',
        price: '3000',
        sit_num: '0А нижний',
        type: 'no type',
    ),
    NoName(
        id: 6,
        name: 'Нет имени',
        price: '3000',
        sit_num: '0В нижний',
        type: 'no type',
    ),
    NoName(
        id: 7,
        name: 'Нет имени',
        price: '3000',
        sit_num: '0С нижний',
        type: 'no type',
    ),
    NoName(
        id: 8,
        name: 'Нет имени',
        price: '3000',
        sit_num: '0С верхний',
        type: 'no type',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Пассажиры'),
        ),
          //children: passList.map((bus) => cardTemplate(bus)).toList(),
        body: ListView(children: <Widget>[
          DataTable(
            showCheckboxColumn: false,
            columns: [
              DataColumn(label: Text('Имя', style: TextStyle(fontSize: 20))),
              DataColumn(label: Text('Место', style: TextStyle(fontSize: 20))),
              DataColumn(label: Text('Тип', style: TextStyle(fontSize: 20))),
            ],
            rows: [
              for (Passengers i in passList)
              DataRow(
                  onSelectChanged: (value) {
                    _detailedInfo(context, i);
                  },
                  cells: [
                    DataCell(Text(i.name)),
                    DataCell(Text(i.sit_num)),
                    DataCell(Text(i.type,
                        style: TextStyle(
                            color: Colors.white,
                            background: Paint()
                              ..strokeWidth = 24.0
                              ..color = Colors.green
                              ..style = PaintingStyle.stroke
                              ..strokeJoin = StrokeJoin.round
                        ))),
                  ]),
            ],
          ),
          Center(
              child: Text(
                'Свободные места',
                style: TextStyle(fontSize: 20),
              )),
          DataTable(
            columns: [
              DataColumn(label: Text('', style: TextStyle(fontSize: 20))),
              DataColumn(label: Text('', style: TextStyle(fontSize: 20))),
              DataColumn(label: Text('', style: TextStyle(fontSize: 20))),
            ],
            rows: [
              for (NoName i in noName)
              DataRow(cells: [
                DataCell(Text(i.name)),
                DataCell(Text(i.sit_num)),
                DataCell(Text(i.type,
                    style: TextStyle(
                        color: Colors.white,
                        background: Paint()
                          ..strokeWidth = 24.0
                          ..color = Colors.green
                          ..style = PaintingStyle.stroke
                          ..strokeJoin = StrokeJoin.round
                    ))),

              ]),

            ],
          ),
        ]));
  }

  void _detailedInfo(context, Passengers pass) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container (
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      "Информация о пассажире",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        border:
                        Border(bottom: BorderSide(color: Colors.black))),
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: pass.name,
                          hintStyle: TextStyle(color: Colors.black)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        border:
                        Border(bottom: BorderSide(color: Colors.black))),
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: pass.phone,
                          hintStyle: TextStyle(color: Colors.black)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        border:
                        Border(bottom: BorderSide(color: Colors.black))),
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: pass.mail,
                          hintStyle: TextStyle(color: Colors.green)),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white),
                            child: Center(
                              child: Text(
                                "Место",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                      SizedBox(
                        width: 30,
                      ),
                      Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white),
                            child: Center(
                              child: Text(
                                "Цена",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white),
                            child: Center(
                              child: Text(
                                pass.sit_num,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                      SizedBox(
                        width: 30,
                      ),
                      Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white),
                            child: Center(
                              child: Text(
                                pass.price,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(top: 5),
                            height: 37,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.green),
                            child: Center(
                              child: Text(
                                "изменить",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                      SizedBox(
                        width: 37,
                      ),
                      Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(top: 5),
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.green),
                            child: Center(
                              child: Text(
                                "отправить чек",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                    ],
                  ),
                  Center(
                    child: Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(top: 5),
                          height: 37,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.green),
                          child: FlatButton(
                          onPressed: (){
                              Widget cancelButton = FlatButton(
                              child: Text("НЕТ",
                              style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0)),
                              onPressed: () {
                              Navigator.of(context).pop();
                              });
                              Widget continueButton = FlatButton(
                                  child: Text("ДА",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18.0)),
                                  onPressed: () => setState(() {
                                    passList.remove(pass);
                                    Navigator.of(context).pop();
                                  }));

                              AlertDialog alert = AlertDialog(
                              content: Text("Вы хотите отменить покупку билета?",
                              style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 21.0)),
                              actions: [cancelButton, continueButton]);
                              showDialog(context: context, builder: (context) => alert);
                              },
                            child: Text(
                              "отменить покупку билета",
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        )),
                  )
                ],
              ));
        });
  }
}