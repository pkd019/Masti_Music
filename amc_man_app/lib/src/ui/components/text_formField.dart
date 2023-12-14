import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    required TextEditingController fieldController,
    required String hintText,
    required String labelText,
    required IconData prefixIcon,
    required TextInputType keyboardType,
    FocusNode? currentNode,
    String? semanticsLabel,
    FocusNode? nextNode,
    bool obscureText = false,
    Widget? suffix,
    bool enabled = true,
    TextCapitalization? textCapitalization,
    required TextInputAction textInputAction,
    this.validator,
  })  : _fieldController = fieldController,
        _hintText = hintText,
        _labelText = labelText,
        _semanticsLabel = semanticsLabel!,
        _currentNode = currentNode!,
        _nextNode = nextNode!,
        _textInputAction = textInputAction,
        _keyboardType = keyboardType,
        _obscureText = obscureText,
        _prefixIcon = prefixIcon,
        _suffix = suffix!,
        _enabled = enabled,
        _textCapitalization = textCapitalization ?? TextCapitalization.none;

  final TextEditingController _fieldController;
  final IconData _prefixIcon;
  final String _hintText;
  final String _labelText;
  final TextInputType _keyboardType;
  final bool _obscureText;
  final String Function(String?)? validator;
  final Widget _suffix;
  final TextInputAction _textInputAction;
  final FocusNode _currentNode;
  final FocusNode? _nextNode;
  final TextCapitalization _textCapitalization;
  final String _semanticsLabel;
  final bool _enabled;

  final _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4.0),
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _currentNode,
      onFieldSubmitted: (value) {
        _currentNode.unfocus();
        FocusScope.of(context).requestFocus(_nextNode);
      },
      textInputAction: _textInputAction,
      controller: _fieldController,
      keyboardType: _keyboardType,
      obscureText: _obscureText,
      validator: validator,
      textCapitalization: _textCapitalization,
      textAlignVertical: TextAlignVertical.center,
      enabled: _enabled,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
        suffixIcon: _suffix,
        hintText: _hintText,
        prefixIcon: Icon(_prefixIcon),
        labelText: _labelText,
        border: _border,
        semanticCounterText: _semanticsLabel,
      ),
    );
  }
}
