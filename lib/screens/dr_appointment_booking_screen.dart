import 'package:flutter/material.dart';
import 'package:med_tech_app/model/dr_model.dart';
import 'package:med_tech_app/utils/colors_util.dart';

class DrAppointmentBookingScreen extends StatefulWidget {
  final DrModel currDr;
  const DrAppointmentBookingScreen({super.key, required this.currDr});

  @override
  State<DrAppointmentBookingScreen> createState() => _DrAppointmentBookingScreenState();
}

class _DrAppointmentBookingScreenState extends State<DrAppointmentBookingScreen> {
  String _selectedDate = "";
  List<String> dateOptions = List.generate(3, (index) {
    final date = DateTime.now().add(Duration(days: index));
    return "${date.day}/${date.month}/${date.year}";
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Dr Appoinment"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: buttonColor2,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                image: DecorationImage(image: AssetImage("assets/images/doctor-with-his-arms-crossed-white-background.png"),
                fit: BoxFit.contain),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Column(
                      children: [
                        Text(widget.currDr.doctorName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                        Text("Rating: ⭐${widget.currDr.doctorRatings}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
                        Text("Specialization: ${widget.currDr.doctorSpecialization}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
                        const SizedBox(height: 12,),
                        Text("${widget.currDr.doctorName} is a renowned specialist in ${widget.currDr.doctorSpecialization} with a strong record of successful treatments. Book your appointment today to get expert guidance and care.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                        ),
                        Text("Date: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
                        SizedBox(
                          height: 50,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: dateOptions.length,
                            itemBuilder: (context, index) {
                              final selectedDate = dateOptions[index];
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedDate = selectedDate;
                                    });
                                  },
                                  child: Chip(
                                    label: Text(selectedDate),
                                    labelStyle: const TextStyle(
                                      fontSize: 14,
                                    ),
                                    backgroundColor: selectedDate.compareTo(_selectedDate) == 0 ? buttonColor2
                                    : const Color.fromARGB(255, 227, 234, 241),
                                    side: const BorderSide(
                                      color: Color.fromRGBO(245, 247, 249, 1),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                              );
                            }),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Fee: ${widget.currDr.doctorFees}", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                          InkWell(
                            onTap: () {
                              // book appointment
                            },
                            child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white,),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: const Row(
                        children: [
                          Text(
                            "Book Now",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}