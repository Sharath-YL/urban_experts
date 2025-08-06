

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSilverAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget backgroundwidget;
  final Widget bodypart;
  final List<Widget>? actions;
  final Widget? bottomitem;
  final double? height;
  final Widget title;
  final double? toolbarheight;
  final bool leading;
  final bool centerTitle;
  final Color? appbarcolor;
  final double? borderradius;
  CustomSilverAppBar({
    super.key,
    required this.backgroundwidget,
    required this.bodypart,
    required this.title,
    this.actions = null,
    this.bottomitem = null,
    this.toolbarheight = 50,
    this.leading = true,
    this.height = 210,
    this.appbarcolor = const Color(0xffFCFAFA),
    this.borderradius = 28.0,
    this.centerTitle = false,
  });

  @override
  State<CustomSilverAppBar> createState() => _CustomSilverAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(210.h);
}

class _CustomSilverAppBarState extends State<CustomSilverAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleBottomBar(bool show) {
    if (show) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final colorscheme = Theme.of(context).colorScheme;

    return Scaffold(
        body: NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollUpdateNotification) {
          if (notification.metrics.axis == Axis.vertical) {
            if (notification.metrics.pixels > 100.h) {
              if (notification.metrics.pixels <
                  notification.metrics.maxScrollExtent) {
                _toggleBottomBar(true);
              }
            } else {
              _toggleBottomBar(false);
            }
          }
        }
        return true;
      },
      child: Stack(
        children: [
          CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              SliverAppBar(
                toolbarHeight: widget.toolbarheight!.h,
                pinned: true,
                centerTitle: widget.centerTitle,
                floating: false,
                automaticallyImplyLeading: false,
                actions: widget.actions,
                leading: widget.leading
                    ? InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 10.h),
                          child: Icon(Icons.arrow_back_ios,
                              size: 20.sp,
                              color: colorscheme.onPrimaryContainer),
                        ),
                      )
                    : null,
                expandedHeight: widget.height ?? widget.preferredSize.height,
                backgroundColor: colorscheme.surface,
                surfaceTintColor: colorscheme.surface,
                foregroundColor: colorscheme.surface,
                shape: RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(widget.borderradius!),
                      bottomRight: Radius.circular(widget.borderradius!)),
                ),
                flexibleSpace: LayoutBuilder(builder: (context, constraints) {
                  double top = constraints.biggest.height;
                  return FlexibleSpaceBar(
                    centerTitle: widget.centerTitle,
                    title:
                        top - 100 < widget.toolbarheight! ? widget.title : null,
                    collapseMode: CollapseMode.parallax,
                    background: widget.backgroundwidget,
                  );
                }),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: widget.bottomitem != null ? 60.h : 10.h),
                  child: widget.bodypart,
                ),
              ),
            ],
          ),
          if (widget.bottomitem != null)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SlideTransition(
                position: _offsetAnimation,
                child: widget.bottomitem,
              ),
            ),
        ],
      ),
    ));
  }
}
