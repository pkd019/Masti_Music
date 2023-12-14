import 'package:flutter/material.dart';

class HomeGridTile extends StatelessWidget {
  const HomeGridTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
  });

  final IconData icon;
  final String title;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(4.0),
        splashColor: Theme.of(context).colorScheme.secondary.withAlpha(70),
        highlightColor: Theme.of(context).colorScheme.secondary.withAlpha(40),
        enableFeedback: true,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 36.0,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(height: 18.0),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 16.0,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeGridContent {
  const HomeGridContent({
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  final String title;
  final IconData icon;
  final void Function() onPressed;
}
