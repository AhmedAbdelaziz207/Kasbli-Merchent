import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum LoadingIndicatorPosition { top, bottom, both }

class LazyLoadingList<T> extends StatefulWidget {
  final List<T> items;
  final bool isLoading;
  final bool hasMoreItems;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Widget? loadingIndicator;
  final Widget? emptyListWidget;
  final EdgeInsetsGeometry? padding;
  final double loadingTriggerThreshold;
  final VoidCallback? onLoadMore;
  final LoadingIndicatorPosition loadingIndicatorPosition;
  final Widget? separator;
  final Axis scrollDirection;
  final ScrollController? scrollController;
  final Widget? header;
  final Widget? footer;

  const LazyLoadingList({
    super.key,
    required this.items,
    required this.isLoading,
    required this.hasMoreItems,
    required this.itemBuilder,
    this.loadingIndicator,
    this.emptyListWidget,
    this.padding,
    this.loadingTriggerThreshold = 0.8,
    this.onLoadMore,
    this.loadingIndicatorPosition = LoadingIndicatorPosition.bottom,
    this.separator,
    this.scrollDirection = Axis.vertical,
    this.scrollController,
    this.header,
    this.footer,
  });

  @override
  State<LazyLoadingList<T>> createState() => _LazyLoadingListState<T>();
}

class _LazyLoadingListState<T> extends State<LazyLoadingList<T>> {
  late ScrollController _scrollController;
  bool _shouldLoadMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    if (widget.scrollController == null) {
      _scrollController.dispose();
    } else {
      _scrollController.removeListener(_scrollListener);
    }
    super.dispose();
  }

  void _scrollListener() {
    if (!_shouldLoadMore &&
        !widget.isLoading &&
        widget.hasMoreItems &&
        _scrollController.position.pixels >=
            widget.loadingTriggerThreshold *
                _scrollController.position.maxScrollExtent) {
      setState(() {
        _shouldLoadMore = true;
      });

      // Delay the loading to avoid multiple loading triggers
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_shouldLoadMore && widget.onLoadMore != null) {
          widget.onLoadMore!();
        }
        setState(() {
          _shouldLoadMore = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return widget.isLoading
          ? _buildLoadingIndicator()
          : widget.emptyListWidget ?? const SizedBox.shrink();
    }

    return _buildListView();
  }

  Widget _buildListView() {
    final itemCount = _calculateItemCount();

    return ListView.separated(
      controller: _scrollController,
      scrollDirection: widget.scrollDirection,
      padding: widget.padding,
      itemCount: itemCount,
      separatorBuilder: (context, index) {
        if (widget.separator != null) {
          // Don't show separator after loading indicators or headers
          if (_isLoadingIndicator(index) ||
              _isHeader(index) ||
              _isLoadingIndicator(index - 1)) {
            return const SizedBox.shrink();
          }
          return widget.separator!;
        }
        return const SizedBox.shrink();
      },
      itemBuilder: (context, index) {
        // Header
        if (_isHeader(index)) {
          return widget.header!;
        }

        // Top loading indicator
        if (_isTopLoadingIndicator(index)) {
          return _buildLoadingIndicator();
        }

        // Footer
        if (_isFooter(index)) {
          return widget.footer!;
        }

        // Bottom loading indicator
        if (_isBottomLoadingIndicator(index)) {
          return _buildLoadingIndicator();
        }

        // Calculate the real index in the items list
        final itemIndex = _calculateItemIndex(index);

        if (itemIndex < widget.items.length) {
          return widget.itemBuilder(
            context,
            widget.items[itemIndex],
            itemIndex,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return widget.loadingIndicator ??
        SizedBox(
          height: 60.h,
          child: Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
              strokeWidth: 2.w,
            ),
          ),
        );
  }

  bool _isLoadingIndicator(int index) {
    return _isTopLoadingIndicator(index) || _isBottomLoadingIndicator(index);
  }

  bool _isTopLoadingIndicator(int index) {
    final hasHeader = widget.header != null;
    return (widget.loadingIndicatorPosition == LoadingIndicatorPosition.top ||
            widget.loadingIndicatorPosition == LoadingIndicatorPosition.both) &&
        widget.isLoading &&
        ((hasHeader && index == 1) || (!hasHeader && index == 0));
  }

  bool _isBottomLoadingIndicator(int index) {
    final hasFooter = widget.footer != null;
    final itemCount = _calculateItemCount();
    return (widget.loadingIndicatorPosition ==
                LoadingIndicatorPosition.bottom ||
            widget.loadingIndicatorPosition == LoadingIndicatorPosition.both) &&
        (widget.isLoading || _shouldLoadMore) &&
        ((hasFooter && index == itemCount - 2) ||
            (!hasFooter && index == itemCount - 1));
  }

  bool _isHeader(int index) {
    return widget.header != null && index == 0;
  }

  bool _isFooter(int index) {
    final itemCount = _calculateItemCount();
    return widget.footer != null && index == itemCount - 1;
  }

  int _calculateItemCount() {
    int count = widget.items.length;

    // Add space for header if present
    if (widget.header != null) {
      count += 1;
    }

    // Add space for footer if present
    if (widget.footer != null) {
      count += 1;
    }

    // Add space for top loading indicator if needed
    if ((widget.loadingIndicatorPosition == LoadingIndicatorPosition.top ||
            widget.loadingIndicatorPosition == LoadingIndicatorPosition.both) &&
        widget.isLoading) {
      count += 1;
    }

    // Add space for bottom loading indicator if needed
    if ((widget.loadingIndicatorPosition == LoadingIndicatorPosition.bottom ||
            widget.loadingIndicatorPosition == LoadingIndicatorPosition.both) &&
        (widget.isLoading || _shouldLoadMore)) {
      count += 1;
    }

    return count;
  }

  int _calculateItemIndex(int index) {
    int offset = 0;

    // Adjust for header
    if (widget.header != null && index > 0) {
      offset += 1;
    }

    // Adjust for top loading indicator
    if ((widget.loadingIndicatorPosition == LoadingIndicatorPosition.top ||
            widget.loadingIndicatorPosition == LoadingIndicatorPosition.both) &&
        widget.isLoading &&
        index > 0) {
      offset += 1;
    }

    return index - offset;
  }
}
