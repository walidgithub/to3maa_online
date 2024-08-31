import 'package:flutter/material.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_fonts.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_typography.dart';
import 'package:To3maa/zakat/presentation/shared/style/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:badges/badges.dart' as badges;

class TabBarWidget extends StatefulWidget {
  final bool activeTab;
  final String title;
  final String icon;
  final int index;
  final int badgeVal;
  final Function toggleTabs;
  const TabBarWidget({
    super.key,
    required this.activeTab,
    required this.title,
    required this.icon,
    required this.index,
    required this.badgeVal,
    required this.toggleTabs,
  });

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.toggleTabs();
      },
      child: Container(
        color: AppColors.cBackGround,
        child: RotatedBox(
          quarterTurns: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 1.h,
              ),
              RotatedBox(
                quarterTurns: 1,
                child: widget.index == 1
                    ? widget.badgeVal > 0
                        ? Center(
                            child: badges.Badge(
                              position: badges.BadgePosition.topEnd(
                                  top: -10, end: -12),
                              badgeContent: Text(
                                widget.badgeVal.toString(),
                                style: AppTypography.kBold14.copyWith(
                                    color: AppColors.cWhite,
                                    fontFamily: AppFonts.boldFontFamily),
                              ),
                              showBadge: true,
                              ignorePointer: false,
                              child: SvgPicture.asset(
                                widget.icon,
                                width: 25.w,
                              ),
                            ),
                          )
                        : SvgPicture.asset(
                            widget.icon,
                            width: 25.w,
                          )
                    : SvgPicture.asset(
                        widget.icon,
                        width: 25.w,
                      ),
              ),
              Text(
                widget.title,
                style: AppTypography.kBold16.copyWith(
                    fontFamily: AppFonts.qabasFontFamily,
                    color:
                        widget.activeTab ? AppColors.cBlack : AppColors.cGray),
              ),
              Container(
                width: 30.w,
                height: 5.h,
                decoration: BoxDecoration(
                    color: widget.activeTab
                        ? AppColors.cPrimary
                        : AppColors.cBackGround),
              )
            ],
          ),
        ),
      ),
    );
  }
}
