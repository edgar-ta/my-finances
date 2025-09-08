import 'package:flutter/material.dart';
import 'package:my_finances/components/drawer_item/drawer_item_entry.dart';

class DrawerItem extends StatefulWidget {
  final DrawerItemEntry entry;
  final bool isSelected;
  final List<String> selectedSubroute;
  final void Function(String subroute) navigateTo;

  const DrawerItem({
    super.key,
    required this.entry,
    required this.isSelected,
    required this.selectedSubroute,
    required this.navigateTo,
  });

  @override
  State<DrawerItem> createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
    if (_animation.status != AnimationStatus.completed) {
      _controller.forward();
    } else {
      _controller.animateBack(0, duration: Duration(milliseconds: 200));
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasSubroutes = widget.entry.subroutes.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: widget.entry.icon != null ? Icon(widget.entry.icon) : null,
          title: Text(widget.entry.title),
          tileColor:
              widget.isSelected
                  ? Colors.blueAccent[200]
                  : Theme.of(context).colorScheme.surfaceContainerLow,
          trailing:
              hasSubroutes
                  ? IconButton(
                    icon: Icon(
                      _isExpanded ? Icons.expand_less : Icons.expand_more,
                    ),
                    onPressed: _toggleMenu,
                  )
                  : null,
          onTap:
              widget.entry.navigatable
                  ? () => widget.navigateTo(widget.entry.route)
                  : _toggleMenu,
        ),
        SizeTransition(
          sizeFactor: _animation,
          axis: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              children:
                  widget.entry.subroutes.map((subroute) {
                    return DrawerItem(
                      entry: subroute,
                      isSelected:
                          widget.selectedSubroute.first == subroute.route,
                      selectedSubroute:
                          widget.selectedSubroute.skip(1).toList(),
                      navigateTo:
                          (String subroute) => widget.navigateTo(
                            "${widget.entry.route}/$subroute",
                          ),
                    );
                  }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
