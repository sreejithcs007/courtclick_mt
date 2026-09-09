import 'package:courtclick_mt/core/utils/debouncer.dart';
import 'package:flutter/material.dart';

class CustomSearchTextField extends StatefulWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final String hintText;
  final int debounceDurationMs;

  const CustomSearchTextField({
    super.key,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.hintText = 'Search for a show, movie, genre, e.t.c.',
    this.debounceDurationMs = 400,
  });

  @override
  State<CustomSearchTextField> createState() => _CustomSearchTextFieldState();
}

class _CustomSearchTextFieldState extends State<CustomSearchTextField> {
  late final TextEditingController _controller;
  late final Debouncer _debouncer;
  bool _isExternalController = false;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _controller = widget.controller!;
      _isExternalController = true;
    } else {
      _controller = TextEditingController();
    }
    _debouncer = Debouncer(milliseconds: widget.debounceDurationMs);
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _debouncer.dispose();
    _controller.removeListener(_onTextChanged);
    if (!_isExternalController) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onTextChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  void _handleChanged(String query) {
    _debouncer.run(() {
      if (mounted) {
        widget.onChanged?.call(query);
      }
    });
  }

  void _handleClear() {
    _controller.clear();
    _debouncer.cancel();
    if (widget.onClear != null) {
      widget.onClear!();
    } else if (widget.onChanged != null) {
      widget.onChanged!('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          const Icon(
            Icons.search,
            color: Colors.grey,
            size: 22,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: _handleChanged,
              onSubmitted: (val) {
                _debouncer.cancel();
                widget.onSubmitted?.call(val);
              },
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          if (_controller.text.isNotEmpty)
            IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.grey,
                size: 20,
              ),
              onPressed: _handleClear,
            )
          else
            const Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: Icon(
                Icons.mic,
                color: Colors.grey,
                size: 22,
              ),
            ),
        ],
      ),
    );
  }
}
