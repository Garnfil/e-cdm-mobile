import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/common/widgets/appbar/appbar.dart';
import 'package:mobile/utils/constants/colors.dart';

class SchoolWorkScreen extends StatelessWidget {
  const SchoolWorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.primaryBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Appbar
            TAppBar(
              showBackArrow: true,
              actions: [
                Stack(
                  children: [
                    IconButton(
                      icon: const Icon(Iconsax
                          .notification), // Replace with your image asset
                      onPressed: () {},
                    ),
                    Positioned(
                      right: 0,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            color: TColors.black,
                            borderRadius: BorderRadius.circular(100)),
                        child: const Center(
                          child: Text(
                            '2',
                            style: TextStyle(color: TColors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyDraggableSheet extends StatefulWidget {
  final Widget child;
  const MyDraggableSheet({super.key, required this.child});

  @override
  State<MyDraggableSheet> createState() => _MyDraggableSheetState();
}

class _MyDraggableSheetState extends State<MyDraggableSheet> {
  final sheet = GlobalKey();
  final controller = DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    controller.addListener(onChanged);
  }

  void onChanged() {
    final currentSize = controller.size;
    if (currentSize <= 0.05) collapse();
  }

  void collapse() => animateSheet(getSheet.snapSizes!.first);

  void anchor() => animateSheet(getSheet.snapSizes!.last);

  void expand() => animateSheet(getSheet.maxChildSize);

  void hide() => animateSheet(getSheet.minChildSize);

  void animateSheet(double size) {
    controller.animateTo(
      size,
      duration: const Duration(milliseconds: 50),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  DraggableScrollableSheet get getSheet =>
      (sheet.currentWidget as DraggableScrollableSheet);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return DraggableScrollableSheet(
        key: sheet,
        initialChildSize: 0.4,
        maxChildSize: 0.95,
        minChildSize: 0,
        expand: true,
        snap: true,
        snapSizes: [
          60 / constraints.maxHeight,
          0.4,
        ],
        controller: controller,
        builder: (BuildContext context, ScrollController scrollController) {
          return DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.black, width: 3),
                left: BorderSide(color: Colors.black, width: 3),
                right: BorderSide(color: Colors.black, width: 3),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22),
                topRight: Radius.circular(22),
              ),
            ),
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                topButtonIndicator(),
                SliverToBoxAdapter(
                  child: widget.child,
                ),
              ],
            ),
          );
        },
      );
    });
  }

  SliverToBoxAdapter topButtonIndicator() {
    return SliverToBoxAdapter(
      child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
            Container(
                child: Center(
                    child: Wrap(children: <Widget>[
              Container(
                  width: 100,
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  height: 5,
                  decoration: const BoxDecoration(
                    color: Colors.black45,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  )),
            ]))),
          ])),
    );
  }
}
