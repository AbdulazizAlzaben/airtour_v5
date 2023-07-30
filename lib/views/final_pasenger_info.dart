import 'package:AirTours/services/cloud/firestore_booking.dart';
import 'package:AirTours/services/cloud/firestore_ticket.dart';
import 'package:AirTours/views/ticket.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:AirTours/views/One-Way/Var.dart';

import '../services/cloud/cloud_booking.dart';

class Enterinfo extends StatefulWidget {
  final String id;
  final double totalprice;
  final String flightClass;
  const Enterinfo(
      {super.key,
      required this.id,
      required this.totalprice,
      required this.flightClass});

  @override
  State<Enterinfo> createState() => _EnterinfoState();
}

class _EnterinfoState extends State<Enterinfo> {
  List<Ticket> tickets = [];
  Ticket? temp;
  final formKey = GlobalKey<FormState>();
  String _selectedTitle = "Mr";
  List<String> _titles = [
    "Mr",
    "Ms",
  ];
  int adultCount = 1;
  TextEditingController fName = TextEditingController();
  TextEditingController mName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController ssn = TextEditingController();
  DateTime dateTime = DateTime(2023, 2, 1);

  String? valueFirstName;
  String? valueLastName;
  String? valueMidleName;
  int? ssn1;
  DateTime? birthD;
  late final TicketFirestore _ticketService;
  late final BookingFirestore _bookingService;
  CloudBooking? ok;

  @override
  void initState() {
    super.initState();
    _bookingService = BookingFirestore();
    _ticketService = TicketFirestore();
    birthD = dateTime;
  }

  Future<String> createBooking() async {
    ok = await _bookingService.createNewBooking(
        bookingClass: widget.flightClass,
        bookingPrice: widget.totalprice,
        departureFlight: widget.id,
        returnFlight: 'none');
    final bookingRef = ok!.documentId;
    return bookingRef;
  }

  void toNext(List<Ticket> alltickets) async {
    final tmp = await createBooking();
    print(tmp);
    print(alltickets);

    alltickets.forEach((ticket) async {
      await _ticketService.createNewTicket(
          firstName: ticket.firstName,
          middleName: ticket.middleName,
          checkInStatus: ticket.checkInStatus,
          bagQuantity: ticket.bagQuantity,
          mealType: ticket.mealType,
          lastName: ticket.lastName,
          ticketPrice: ticket.ticketPrice,
          bookingReference: tmp,
          ticketUserId: '1',
          birthDate: ticket.birthDate,
          flightReference: widget.id,
          ticketClass: widget.flightClass);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  " Adult $adultCount",
                  style: const TextStyle(fontSize: 30),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(blurRadius: 2, offset: Offset(0, 0))
                              ],
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: DropdownButtonFormField<String>(
                              value: _selectedTitle,
                              items: _titles.map((String title) {
                                return DropdownMenuItem<String>(
                                  value: title,
                                  child: Text(
                                    title,
                                    style: const TextStyle(),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedTitle = newValue!;
                                });
                              },
                              decoration: const InputDecoration(
                                border:
                                    InputBorder.none, // sets the border to none
                                hintText: 'Select an option',
                              ),
                            ),
                          )),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(blurRadius: 2, offset: Offset(0, 0))
                              ],
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: TextFormField(
                              controller: fName,
                              decoration: const InputDecoration(
                                labelText: "First name",
                                //hintText: "First name",
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "You did not enter your firs name";
                                }
                                if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                                  return 'Please enter a valid name';
                                }
                              },
                            ),
                          )),
                    ),
                  ],
                ),
                Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(blurRadius: 2, offset: Offset(0, 0))
                        ],
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        controller: mName,
                        decoration: const InputDecoration(
                          labelText: "Midle name",
                          //hintText: "Midle name",
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "You did not enter your firs name";
                          }
                          if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                            return 'Please enter a valid name';
                          }
                        },
                      ),
                    )),
                Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(blurRadius: 2, offset: Offset(0, 0))
                        ],
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        controller: lName,
                        decoration: const InputDecoration(
                          labelText: "Last name",
                          //hintText: "Last name",
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "You did not enter your first name";
                          }
                          if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                            return 'Please enter a valid name';
                          }
                          //return null;
                        },
                      ),
                    )),
                Row(
                  children: [
                    Expanded(
                      //flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(blurRadius: 2, offset: Offset(0, 0))
                                ],
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                controller: ssn,
                                decoration: const InputDecoration(
                                  labelText: " SSN",
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your ID number';
                                  }
                                  if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                                    return 'Please enter a valid ID number (10 digits)';
                                  }
                                  int sum = 0;
                                  for (int i = 0; i < 9; i++) {
                                    int digit = int.parse(value[i]);
                                    if (i % 2 == 0) {
                                      digit *= 2;
                                      if (digit > 9) {
                                        digit -= 9;
                                      }
                                    }
                                    sum += digit;
                                  }
                                  //لاتنسى تشيل الكومنت
                                  // int checkDigit = (sum * 9) % 10;
                                  // if (checkDigit != int.parse(value[9])) {
                                  //   return 'Invalid ID number';
                                  // }
                                  return null;
                                },
                              ),
                            )),
                      ),
                    ),
                    Expanded(
                      //flex: 3,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {});
                        },
                        child: Container(
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(blurRadius: 2, offset: Offset(0, 0))
                                ],
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            child: TextButton(
                                child: Text(
                                  "${monthNames[dateTime.month - 1]} ${dateTime.day} ${dateTime.year}",
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 17),
                                ),
                                onPressed: () {
                                  showCupertinoModalPopup(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.4,
                                          color: Colors.white,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("Done")),
                                              Expanded(
                                                  child: CupertinoDatePicker(
                                                initialDateTime: dateTime,
                                                mode: CupertinoDatePickerMode
                                                    .date,
                                                onDateTimeChanged: (data) {
                                                  setState(() {
                                                    dateTime = data;
                                                    birthD = dateTime;
                                                  });
                                                },
                                              ))
                                            ],
                                          ),
                                        );
                                      });
                                })),
                      ),
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (formKey.currentState!.validate()) {
                        for (adultCount; adultCount < count;) {
                          adultCount++;
                          temp = Ticket(
                              firstName: fName.text,
                              middleName: mName.text,
                              checkInStatus: false,
                              bagQuantity: 1,
                              mealType: 1,
                              lastName: lName.text,
                              ticketPrice: widget.totalprice,
                              birthDate: birthD!,
                              flightReference: widget.id,
                              ticketClass: widget.flightClass,
                              ticketUserId: '1');
                          tickets.add(temp!);
                          fName.clear();
                          mName.clear();
                          lName.clear();
                          ssn.clear();
                          return;
                        }
                        if (adultCount == count) {
                          temp = Ticket(
                              firstName: fName.text,
                              middleName: mName.text,
                              checkInStatus: false,
                              bagQuantity: 1,
                              mealType: 1,
                              lastName: lName.text,
                              ticketPrice: widget.totalprice,
                              birthDate: birthD!,
                              flightReference: widget.id,
                              ticketClass: widget.flightClass,
                              ticketUserId: '1');
                          tickets.add(temp!);
                          toNext(tickets);
                        }
                      }
                    });
                  },
                  child: Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(blurRadius: 2, offset: Offset(0, 0))
                          ],
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue),
                      child: Center(
                          child: Text(
                        adultCount == count ? "Confirm" : "Next Passenger",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}