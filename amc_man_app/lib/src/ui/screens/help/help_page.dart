import 'package:amc_man_app/src/ui/components/custom_tile.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key, this.showAppbar = true});

  final bool showAppbar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppbar ? AppBar() : null,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Spacer(),
            _HelpHeader(),
            const Spacer(),
            Expanded(flex: 25, child: _HelpBody()),
          ],
        ),
      ),
    );
  }
}

class _HelpBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 20.0),
        CustomTile(
          title: 'Email',
          leadingIcon: Icons.email,
          subTitle: kSupportEmail,
          onTap: () async {
            final Uri url = 'mailto:$kSupportEmail' as Uri;
            await launchUrl(url);
          },
          trailing: const Text(''),
        ),
        const SizedBox(height: 20.0),
        CustomTile(
          title: 'Phone',
          leadingIcon: Icons.phone,
          subTitle: '+91 $kSupportPhone',
          onTap: () async {
            final Uri url = 'tel:+91$kSupportPhone' as Uri;

            await launchUrl(url);
          },
          trailing: const Icon(Icons.arrow_forward_ios, size: 20.0),
        ),
      ],
    );
  }
}

class _HelpHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Contact Us',
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(fontSize: 54),
          ),
        ],
      ),
    );
  }
}
