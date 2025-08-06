import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mychoice/res/components/customtextbutton.dart';
import 'package:mychoice/res/constants/colors.dart';
import 'package:intl/intl.dart';
import 'package:mychoice/res/widgets/customButton.dart';
import 'package:mychoice/res/widgets/custombottomsheet.dart';
import 'package:mychoice/res/widgets/customsearchbar.dart';
import 'package:mychoice/utils/routes/routes.dart';
import 'package:mychoice/viewmodel/location_view/location_provider.dart';
import 'package:mychoice/viewmodel/timesehedules/timesehdule_view_provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';

class TimesecduleScreen extends StatefulWidget {
  const TimesecduleScreen({super.key});

  @override
  State<TimesecduleScreen> createState() => _TimesecduleScreenState();
}

class _TimesecduleScreenState extends State<TimesecduleScreen> {
  final SearchController _searchController = SearchController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _houseNoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TimeScheduleViewProvider>(
        context,
        listen: false,
      ).fetchScheduleData();
    });
  }

  @override
  void dispose() {
    _houseNoController.dispose();
    _landmarkController.dispose();
    _addressController.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TimeScheduleViewProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Appcolor.whitecolor,
                size: 18,
              ),
            ),
            backgroundColor: Appcolor.primarycolor,
            elevation: 0,
            title: Text(
              "Book Your Slot",
              style: TextStyle(
                color: Appcolor.whitecolor,
                fontWeight: FontWeight.w700,
                fontSize: 18,
                letterSpacing: 0.5,
              ),
            ),
          ),
          body:
              provider.isLoading
                  ? Center(
                    child: CircularProgressIndicator(
                      color: Appcolor.primarycolor,
                    ),
                  )
                  : Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Appcolor.whitecolor,
                          Appcolor.greycolor.withOpacity(0.1),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              16.0,
                              16.0,
                              16.0,
                              8.0,
                            ),
                            child: Text(
                              "Choose a Date",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Appcolor.blackcolor,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          Card(
                            margin: EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            elevation: 8.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Appcolor.whitecolor,
                                borderRadius: BorderRadius.circular(16.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Appcolor.greycolor.withOpacity(0.2),
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: TableCalendar(
                                firstDay: DateTime.now(),
                                lastDay: DateTime(DateTime.now().year, 12, 31),
                                focusedDay: provider.focusedDate,
                                selectedDayPredicate:
                                    (day) =>
                                        isSameDay(provider.selectedDate, day),
                                onDaySelected: (selectedDay, focusedDay) {
                                  provider.setSelectedDate(selectedDay);
                                },
                                calendarFormat: CalendarFormat.month,
                                calendarStyle: CalendarStyle(
                                  selectedDecoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Appcolor.primarycolor,
                                        Appcolor.primarycolor.withOpacity(0.7),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  todayDecoration: BoxDecoration(
                                    color: Appcolor.primarycolor.withOpacity(
                                      0.3,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  defaultTextStyle: TextStyle(
                                    color: Appcolor.blackcolor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  weekendTextStyle: TextStyle(
                                    color: Appcolor.blackcolor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  outsideTextStyle: TextStyle(
                                    color: Appcolor.greycolor.withOpacity(0.6),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  cellMargin: EdgeInsets.all(6.0),
                                ),
                                headerStyle: HeaderStyle(
                                  formatButtonVisible: false,
                                  titleCentered: true,
                                  titleTextStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Appcolor.blackcolor,
                                  ),
                                  leftChevronIcon: Icon(
                                    Icons.chevron_left,
                                    color: Appcolor.primarycolor,
                                    size: 28,
                                  ),
                                  rightChevronIcon: Icon(
                                    Icons.chevron_right,
                                    color: Appcolor.primarycolor,
                                    size: 28,
                                  ),
                                ),
                                daysOfWeekStyle: DaysOfWeekStyle(
                                  weekdayStyle: TextStyle(
                                    color: Appcolor.blackcolor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  weekendStyle: TextStyle(
                                    color: Appcolor.blackcolor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              16.0,
                              16.0,
                              16.0,
                              8.0,
                            ),
                            child: Text(
                              "Choose a Time Slot",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Appcolor.blackcolor,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 12.0,
                                    mainAxisSpacing: 12.0,
                                    childAspectRatio: 2.8,
                                  ),
                              itemCount: provider.timeSlots.length,
                              itemBuilder: (context, index) {
                                final timeSlot = provider.timeSlots[index];
                                final formattedDate = DateFormat(
                                  'yyyy-MM-dd',
                                ).format(provider.selectedDate);
                                final isBooked =
                                    provider.bookedSlots[formattedDate]?.any(
                                      (slot) =>
                                          slot.time == timeSlot.time &&
                                          slot.isBooked,
                                    ) ??
                                    false;
                                final isSelected =
                                    provider.selectedTimeSlot == timeSlot.time;
                                return GestureDetector(
                                  onTap:
                                      isBooked
                                          ? null
                                          : () {
                                            provider.setSelectedTimeSlot(
                                              timeSlot.time,
                                            );
                                          },
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 200),
                                    decoration: BoxDecoration(
                                      gradient:
                                          isBooked
                                              ? LinearGradient(
                                                colors: [
                                                  Appcolor.greycolor,
                                                  Appcolor.greycolor
                                                      .withOpacity(0.8),
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              )
                                              : isSelected
                                              ? LinearGradient(
                                                colors: [
                                                  Appcolor.primarycolor,
                                                  Appcolor.primarycolor
                                                      .withOpacity(0.7),
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              )
                                              : LinearGradient(
                                                colors: [
                                                  Appcolor.whitecolor,
                                                  Appcolor.whitecolor
                                                      .withOpacity(0.9),
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                      border: Border.all(
                                        color:
                                            isBooked
                                                ? Appcolor.greycolor
                                                : Appcolor.primarycolor
                                                    .withOpacity(0.5),
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Appcolor.greycolor.withOpacity(
                                            0.2,
                                          ),
                                          blurRadius: 6,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        timeSlot.time,
                                        style: TextStyle(
                                          color:
                                              isBooked
                                                  ? Appcolor.whitecolor
                                                      .withOpacity(0.6)
                                                  : isSelected
                                                  ? Appcolor.whitecolor
                                                  : Appcolor.blackcolor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 80),
                        ],
                      ),
                    ),
                  ),
          floatingActionButton:
              provider.selectedTimeSlot != null
                  ? FloatingActionButton.extended(
                    onPressed: () {
                      FlexibleBottomSheet.show(
                        context: context,

                        initialHeight: 0.5,
                        minHeight: 0.0,
                        maxHeight: 0.9,
                        headerHeight: 56,
                        headerBuilder:
                            (context, offset) => Container(
                              color: Appcolor.primarycolor,
                              padding: EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'set your  location',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                        bodyBuilder: (context, offset) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 20.dg,
                              horizontal: 20.sp,
                            ),
                            child: Consumer<LocationProvider>(
                              builder: (context, locationprovider, child) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SearchTextField(
                                      controller: _searchController,
                                    ),
                                    SizedBox(height: 20.sp),

                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon: Image.asset(
                                            "assets/icons/pin.png",
                                            height: 30,
                                            width: 30,
                                          ),
                                        ),
                                        SizedBox(width: 5.sp),
                                        GestureDetector(
                                          onTap: () async {
                                            await locationprovider.getposition(
                                              context,
                                            );
                                            if (locationprovider.address !=
                                                null) {
                                              _addressController.text =
                                                  locationprovider.address!;
                                            }
                                          },
                                          child: Text(
                                            "Use your current location",
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Appcolor.primarycolor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20.sp),

                                    InputForm(
                                      readonly: true,
                                      
                                      title: "Address",
                                      controller: _addressController,
                                    ),
                                    SizedBox(height: 16.sp),
                                    InputForm(
                                      title: "House/FlatNo",
                                      controller: _houseNoController,
                                    ),
                                    SizedBox(height: 16.sp),
                                    InputForm(
                                      title: "Landmark",
                                      controller: _landmarkController,
                                    ),
                                    SizedBox(height: 16.sp,),
                                   Custombutton(buttonText: "continue",onPressed: () {
                                     Navigator.pushNamed(context, RouteName.mencartscreen);
                                   },)
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Booked: ${DateFormat('MMM d, yyyy').format(provider.selectedDate)} at ${provider.selectedTimeSlot}",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          backgroundColor: Appcolor.primarycolor,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      );
                    },
                    backgroundColor: Appcolor.primarycolor,
                    label: Text(
                      "Confirm Booking",
                      style: TextStyle(
                        color: Appcolor.whitecolor,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    icon: Icon(Icons.check_circle, color: Appcolor.whitecolor),
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  )
                  : null,
        );
      },
    );
  }
}
