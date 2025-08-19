import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mychoice/res/constants/colors.dart';
import 'package:mychoice/utils/routes/routes.dart';
import 'package:mychoice/viewmodel/control_pest_control_view/contro_pest_provider.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CleaningPestControlscreen extends StatefulWidget {
  const CleaningPestControlscreen({super.key});

  @override
  State<CleaningPestControlscreen> createState() =>
      _CleaningPestControlscreenState();
}

class _CleaningPestControlscreenState extends State<CleaningPestControlscreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider =
          Provider.of<ControPestProvider>(
            context,
            listen: false,
          ).getControPest();
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 790));
    return Scaffold(
      backgroundColor: Appcolor.whitecolor,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Cleaning Control",
          style: TextStyle(
            color: Appcolor.blackcolor,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: CircleAvatar(
            radius: 15,
            backgroundColor: Appcolor.greycolor,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Appcolor.blackcolor,
                size: 15,
              ),
            ),
          ),
        ),
      ),
      body: Skeletonizer(
        enabled: Provider.of<ControPestProvider>(context).islaoding,
        child: Consumer<ControPestProvider>(
          builder: (context, controlprovider, child) {
            if (controlprovider.islaoding) {
              return Center(
                child: CircularProgressIndicator(color: Appcolor.primarycolor),
              );
            }
            return ListView.builder(
              itemCount: controlprovider.items.length,
              itemBuilder: (BuildContext context, int index) {
                final pest = controlprovider.items[index];
                return Controlpestcontrol(
                  title: pest.title,
                  subtitle: pest.subtitle,
                  image: pest.image,
                  ontap: () {
                    Navigator.pushNamed(
                      context,
                      RouteName.cleaningpestcontrodescriptionscreen,
                      arguments: pest.id,
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class Controlpestcontrol extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final VoidCallback ontap;
  final String? description;
  final int? price;
  final String? place;
  final int? time;

  const Controlpestcontrol({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.ontap,
    this.description,
    this.price,
    this.place,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: 100.h,
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Appcolor.greycolor)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(
                      image.isNotEmpty
                          ? image
                          : 'https://via.placeholder.com/30',
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Appcolor.blackcolor,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Appcolor.blackcolor,
                      ),
                    ),
                  ],
                ),
              ),
              CircleAvatar(
                radius: 20,
                backgroundColor: Appcolor.blackcolor.withOpacity(0.1),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Appcolor.blackcolor,
                  size: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
