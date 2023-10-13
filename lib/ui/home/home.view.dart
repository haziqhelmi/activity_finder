import 'package:activity_finder/constant/enum/activity_type.enum.dart';
import 'package:activity_finder/constant/enum/view_state.enum.dart';
import 'package:activity_finder/constant/extension/widget.extension.dart';
import 'package:activity_finder/core/model/activity.model.dart';
import 'package:activity_finder/core/model/sheet_item.dart';
import 'package:activity_finder/ui/home/home.controller.dart';
import 'package:activity_finder/ui/shared/theme_style.dart';
import 'package:activity_finder/ui/shared/widgets/activity_card.dart';
import 'package:activity_finder/ui/shared/widgets/button.dart';
import 'package:activity_finder/ui/shared/widgets/drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    Future.microtask(() => ref.read(homeController.notifier).init());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ViewState state = ref.watch(homeController);

    return Scaffold(
      body: _buildBody(state).safeArea(),
      bottomNavigationBar: _buildBottomNav(state),
    );
  }

  Widget _buildBody(ViewState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(),
        _buildSubtitle(),
        _buildStats(),
        Divider().paddingOnly(bottom: 16),
        _buildListView(state),
      ],
    ).paddingAll(24);
  }

  Text _buildTitle() {
    return Text('Activity Finder', style: ThemeStyle.headline);
  }

  Widget _buildSubtitle() {
    return Text(
      'Bored? Find something to do!',
      style: ThemeStyle.subHeading,
    ).paddingOnly(bottom: 24);
  }

  Widget _buildStats() {
    return Row(
      children: [
        Container(
          height: 100,
          decoration: BoxDecoration(
            color: Color(0xFFF1C502),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12)),
          ),
          margin: EdgeInsets.only(right: 12),
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('History',
                  style: ThemeStyle.body1.copyWith(color: Colors.black),
                  overflow: TextOverflow.fade),
              Text(
                  'Total: ${ref.read(homeController.notifier).activities.length}',
                  style: ThemeStyle.caption.copyWith(color: Colors.black),
                  overflow: TextOverflow.fade)
            ],
          ),
        ).expanded(flex: 1),
        Container(
          height: 100,
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Color.fromARGB(12, 255, 255, 255),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text('Previous Activity:',
                  style: ThemeStyle.caption, overflow: TextOverflow.fade),
              Text('Surprise your significant other with something considerate',
                  textAlign: TextAlign.right,
                  style: ThemeStyle.body1,
                  overflow: TextOverflow.fade),
            ],
          ),
        ).expanded(flex: 2),
      ],
    ).paddingOnly(bottom: 16);
  }

  Widget _buildListView(ViewState state) {
    return ListView(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      children: [
        _buildDropDown(),
        _buildContent(state),
      ],
    ).expanded();
  }

  Widget _buildDropDown() {
    return DropDown(
      title: 'Filter Type',
      controller: ref.read(homeController.notifier).dropdownController,
      items: ActivityType.values
          .map((e) => SheetItem(title: e.getName, metadata: e))
          .toList(),
      onItemPressed: (item) {
        ref.read(homeController.notifier).onTypeSelected(item as ActivityType);
      },
    ).paddingOnly(bottom: 24);
  }

  Widget _buildContent(ViewState state) {
    final Activity? currActivity =
        ref.read(homeController.notifier).currActivity;

    if (state == ViewState.loading) {
      return Container(
        padding: EdgeInsets.all(24),
        margin: EdgeInsets.only(bottom: 24),
        width: double.infinity,
        height: 250,
        decoration: BoxDecoration(
          color: Color.fromARGB(12, 255, 255, 255),
          borderRadius: BorderRadius.circular(16),
        ),
        child: CircularProgressIndicator(
          color: Color(0xFFF1C502),
        ).sizedBox(width: 32, height: 32).center(),
      );
    } else {
      return ActivityCard(activity: currActivity).paddingOnly(bottom: 24);
    }
  }

  Widget _buildBottomNav(ViewState state) {
    return Button(
      buttonText: 'Search',
      icon: Icons.search_rounded,
      onPressed: state == ViewState.loading
          ? null
          : () => ref.read(homeController.notifier).onSearchPressed(),
    ).paddingOnly(left: 24, right: 24, bottom: 24).safeArea();
  }
}
