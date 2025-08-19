import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mychoice/res/constants/colors.dart';
import 'package:mychoice/res/widgets/custombuttons.dart';
import 'package:mychoice/utils/toastmessages.dart';
import 'package:mychoice/view/home_screens/index_screens.dart';

class FeedbackScreen extends StatefulWidget {
  final String bookingId;
  final String service;
  final String providerName;

  const FeedbackScreen({
    super.key,
    required this.bookingId,
    required this.service,
    required this.providerName,
  });

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _controller = TextEditingController();
  int _rating = 0;
  bool _submitting = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_rating == 0) {
      Utils.flushbarErrorMessage("Please give the ratings ", context);
      return;
    }

    setState(() => _submitting = true);
    await Future.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;
    setState(() => _submitting = false);

    Utils.flushbarSuccessMessage("Thanks for your feedback", context);

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder:
            (_) => IndexScreens(pageController: PageController(initialPage: 0)),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: CircleAvatar(
            radius: 15,
            backgroundColor: Appcolor.greycolor,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios,
                color: Appcolor.blackcolor,
                size: 15,
              ),
            ),
          ),
        ),
        title: const Text(
          'Give Feedback',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerCard(),

            SizedBox(height: 16.h),

            Text(
              'Rate your experience',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: Appcolor.blackcolor,
              ),
            ),
            SizedBox(height: 8.h),

            Row(
              children: List.generate(5, (i) {
                final index = i + 1;
                return IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  iconSize: 28.sp,
                  onPressed: () => setState(() => _rating = index),
                  icon: Icon(
                    Icons.star,
                    color:
                        index <= _rating ? Colors.amber : Colors.grey.shade400,
                  ),
                );
              }),
            ),

            SizedBox(height: 16.h),

            Text(
              'Tell us more',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: Appcolor.blackcolor,
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade300),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: TextField(
                controller: _controller,
                maxLines: 5,
                minLines: 4,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Write your feedback (optional)…',
                ),
              ),
            ),

            SizedBox(height: 24.h),

            SizedBox(
              width: double.infinity,
              child: ResumeButton(
                buttonText: _submitting ? "Submitting..." : "Submit Feedback",
                onPressed: _submitting ? null : _submit,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.06),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: const Icon(Icons.cleaning_services_outlined),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Work line
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 0,
                      child: Text(
                        "Work assinged : ",
                        style: TextStyle(
                          color: Appcolor.blackcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        widget.service,
                        style: TextStyle(
                          color: Appcolor.blackcolor,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                // Vendor line
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 0,
                      child: Text(
                        "Vendor Name  : ",
                        style: TextStyle(
                          color: Appcolor.blackcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        widget.providerName,
                        style: TextStyle(
                          color: Appcolor.blackcolor,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
