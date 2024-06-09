import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Container(
                height: 100,
                color: Colors.white,
                child: PageView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) => Column(
                    children: [
                      Text('$index'),
                      Text('$index'),
                      Text('$index'),
                    ],
                  ),
                ),
              ),
            ),
            Text('hello'),
          ],
        ),
      ),
    );
  }
}


class CustomContainer extends StatefulWidget {
  final List<Column> data;
  //final double height;
  final IconData icon;
  final VoidCallback onPressButton;
  final String buttonText;
  final bool cancel, loading;

  const CustomContainer({
    super.key,
    required this.data,
    required this.icon,
    required this.onPressButton,
    required this.buttonText,
    //required this.height,
    required this.cancel,
    required this.loading,
  });

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  final PageController _pageController = PageController(initialPage: 0);

  int _activePage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: RoundedDiagonalPathClipper(),
            child: Container(
              //height: widget.height,
              padding: const EdgeInsets.fromLTRB(30.0, 130, 30, 35),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _activePage = page;
                  });
                },
                itemCount: widget.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return widget.data[index];
                },
              ),
            ),
          ),
          if (widget.data.length > 1)
            SizedBox(
              //height: widget.height - 40,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      widget.data.length,
                      (index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: InkWell(
                              onTap: () {
                                _pageController.animateToPage(index,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeIn);
                              },
                              child: CircleAvatar(
                                radius: 7,
                                backgroundColor: _activePage == index
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.grey,
                              ),
                            ),
                          )),
                ),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 40.0,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Icon(
                  widget.icon,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
          SizedBox(
            //height: widget.height + 20,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.cancel)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0)),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('إلغاء',
                          style: Theme.of(context).textTheme.titleSmall),
                    ),
                  if (widget.cancel) const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0)),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: widget.onPressButton,
                    child: widget.loading == true
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ))
                        : Text(widget.buttonText,
                            style: Theme.of(context).textTheme.titleSmall),
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
