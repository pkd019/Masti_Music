import 'package:amc_man_app/src/ui/screens/map_asset/location_bloc/bloc/location_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../screens/map_asset/location_bloc/bloc/location_bloc.dart';
import '../../extensions/snack_bar.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationBloc, LocationState>(
      listener: (context, state) {
        context.showSnackbar(state.errorMessage.toString());
      },
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _LocationText(
                        data: state.location!.longitude.toString(),
                        semanticsLabel: 'Longitude',
                      ),
                      const SizedBox(height: 4.0),
                      _LocationText(
                        data: state.location!.latitude.toString(),
                        semanticsLabel: 'Latitude',
                      ),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  icon: const Icon(
                    Icons.location_pin,
                    size: 20.0,
                  ),
                  label: Text(state.infoMessage),
                  onPressed: () => BlocProvider.of<LocationBloc>(context)
                      .add(LocationRequested()),
                ),
              ],
            ),
            state.location != null
                ? Text(
                    'Accuracy: ${state.location!.accuracy.toStringAsPrecision(3)}m')
                : const SizedBox(height: 5),
          ],
        );
      },
    );
  }
}

class _LocationText extends StatelessWidget {
  const _LocationText(
      {Key? key, required this.data, required this.semanticsLabel})
      : super(key: key);

  final String data;
  final String semanticsLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            '$semanticsLabel : ',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
        ),
        Expanded(
          child: Text(
            data,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            semanticsLabel: semanticsLabel,
          ),
        ),
      ],
    );
  }
}
