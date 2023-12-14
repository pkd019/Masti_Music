import 'dart:io';

import 'package:amc_man_app/src/constants.dart';
import 'package:amc_man_app/src/models/asset_model/asset_model.dart';
import 'package:amc_man_app/src/route.dart';
import 'package:amc_man_app/src/ui/components/show_progress.dart';
import 'package:amc_man_app/src/ui/components/text_formField.dart';
import 'package:amc_man_app/src/ui/screens/home/home_screen.dart';
import 'package:amc_man_app/src/ui/screens/map_asset/asset_condition_bloc/bloc/assetcondition_bloc.dart';
import 'package:amc_man_app/src/ui/screens/map_asset/asset_functioning_bloc/bloc/assetfunctioning_bloc.dart';
import 'package:amc_man_app/src/ui/screens/map_asset/location_bloc/bloc/location_state.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import 'bloc/assetmap_bloc.dart';
import 'image_bloc/bloc/image_bloc.dart';
import 'location_bloc/bloc/location_bloc.dart';
import 'asset_option_bloc/bloc/assetoption_bloc.dart';
import 'asset_partial_functioning_bloc/bloc/assetpartfunctioning_bloc.dart';

import '../../../models/immovable_asset_type/immovable_asset_type.dart';
import '../../components/location_widget.dart';
import '../../components/image_widget.dart';
import '../../../extensions/snack_bar.dart';
import '../../../global/globals.dart' as global;

late ImmovableAssetType arguments;

class AssetMapPage extends StatelessWidget {
  static const id = 'asset_map_page';

  const AssetMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    arguments =
        ModalRoute.of(context)!.settings.arguments as ImmovableAssetType;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AssetMapBloc()),
        BlocProvider(create: (context) => ImageBloc()),
        BlocProvider(create: (context) => LocationBloc()),
        BlocProvider(create: (context) => AssetoptionBloc()),
        BlocProvider(create: (context) => AssetfunctioningBloc()),
        BlocProvider(create: (context) => AssetconditionBloc()),
        BlocProvider(create: (context) => AssetpartfunctioningBloc()),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('Map Asset')),
        body: const AssetMapBody(),
      ),
    );
  }
}

class AssetMapBody extends StatefulWidget {
  const AssetMapBody({super.key});

  @override
  State<AssetMapBody> createState() => _AssetMapBodyState();
}

class _AssetMapBodyState extends State<AssetMapBody> {
  late Position? _locationData;
  late List<File>? _imageFiles;
  late List<String>? _assetPartFuncReason;
  late String? _assetSubClassOption;
  late String? _assetCondition;
  late String? _assetFunctioning;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode nameNode = FocusNode();
  final FocusNode descriptioNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _validateAssetData() {
    if (_locationData == null) {
      context.showSnackbar('Please capture the location of the asset');
      return false;
    } else if (_locationData!.accuracy > kLocationAccuracy) {
      context.showSnackbar(
          'Location accuracy cannot exceed $kLocationAccuracy m. Please capture the location again');
      return false;
    } else if (_imageFiles!.isEmpty) {
      context.showSnackbar('Please click a picture of the asset');
      return false;
    } else if (_assetSubClassOption == null) {
      context.showSnackbar('Please select an asset type from the list');
      return false;
    } else if (_assetCondition == null) {
      context.showSnackbar('Please select a physical condition of the asset');
      return false;
    } else if (_assetFunctioning == null) {
      context.showSnackbar(
          'Please select the current functioning condition of the asset');
      return false;
    } else if (_assetFunctioning ==
            (AssetFunctioning.partial).toString().split('.')[1] &&
        (_assetPartFuncReason!.isEmpty)) {
      context.showSnackbar(
          'Please select some reasons why the asset may be partially functioning');
      return false;
    }

    return true;
  }

  void _onUploadButtonPressed() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_validateAssetData()) return;

    BlocProvider.of<AssetMapBloc>(context).add(UploadAsset(
      assetClass: arguments.classType,
      assetSubClass: arguments.subClassType,
      assetSubClassOption: _assetSubClassOption!,
      location: AssetLocation(
        latitude: _locationData!.latitude,
        longitude: _locationData!.longitude,
        altitude: _locationData!.altitude,
        heading: _locationData!.heading,
      ),
      name: _nameController.text,
      description: _descriptionController.text,
      functioning: _assetFunctioning!,
      physicalCondition: _assetCondition!,
      assetPartFuncReason: _assetPartFuncReason!,
      assetLocalFilePath: _imageFiles!.map((e) => e.path).toList(),
      context: context,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AssetMapBloc, AssetmapState>(
      listener: (context, state) {
        if (state is AssetmapFailure) {
          context.showSnackbar(state.message);
        } else if (state is AssetmapSuccess) {
          context.showSnackbar('Asset Mapped Succesfully');
          Navigator.of(context).pushAndRemoveUntil(
            newRoute(const HomeScreen()),
            (route) => false,
          );
        } else if (state is AssetmapInProgress) {
          showProgress(context);
        }
      },
      child: BlocListener<LocationBloc, LocationState>(
        listener: (context, state) {
          _locationData = state.location!;
        },
        child: BlocListener<ImageBloc, ImageState>(
          listener: (context, state) {
            _imageFiles = state.imageFiles!;
          },
          child: BlocListener<AssetoptionBloc, AssetoptionState>(
            listener: (context, state) {
              _assetSubClassOption = state.newValue;
            },
            child: BlocListener<AssetfunctioningBloc, AssetfunctioningState>(
              listener: (context, state) {
                _assetFunctioning = state.newValue;
                setState(() {});
              },
              child: BlocListener<AssetconditionBloc, AssetconditionState>(
                listener: (context, state) {
                  _assetCondition = state.newValue;
                },
                child: BlocListener<AssetpartfunctioningBloc,
                    AssetpartfunctioningState>(
                  listener: (context, state) {
                    _assetPartFuncReason = state.newValues;
                  },
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Container(
                          margin: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              const LocationWidget(),
                              const SizedBox(height: 24.0),
                              const ImageWidget(),
                              const SizedBox(height: 24.0),
                              const AssetOptionWidget(),
                              _AssetNameWidget(
                                nameController: _nameController,
                                currentNode: nameNode,
                                nextNode: descriptioNode,
                              ),
                              _AssetDescriptionWidget(
                                descriptionController: _descriptionController,
                                currentNode: descriptioNode,
                              ),
                              const AssetConditionWidget(),
                              const AssetFunctioningWidget(),
                              _assetFunctioning ==
                                      (AssetFunctioning.partial)
                                          .toString()
                                          .split('.')[1]
                                  ? _PartialFunctioningReasonWidget()
                                  : Container(),
                              const SizedBox(height: 24.0),
                              _UploadAssetButton(
                                  onPressed: _onUploadButtonPressed),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AssetOptionWidget extends StatelessWidget {
  const AssetOptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssetoptionBloc, AssetoptionState>(
      builder: (context, state) {
        final optionList =
            global.assetHelper.getOptionsFromSubClass(arguments.subClassType);
        return AssetMapListElement(
          title: 'Asset Type',
          children: optionList
              .map((e) => AssetMapRadioListTile(
                    value: e,
                    groupValue: state.newValue,
                    onChanged: (value) =>
                        BlocProvider.of<AssetoptionBloc>(context).add(
                      AssetoptionEvent(newValue: value!),
                    ),
                  ))
              .toList(),
        );
      },
    );
  }
}

class AssetFunctioningWidget extends StatelessWidget {
  const AssetFunctioningWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssetfunctioningBloc, AssetfunctioningState>(
      builder: (context, state) {
        final assetFunctioningList = AssetFunctioning.values
            .map(
              (e) => e.toString().split('.')[1],
            )
            .toList();
        return AssetMapListElement(
          title: 'Is the asset functioning?',
          children: assetFunctioningList
              .map((e) => AssetMapRadioListTile(
                    value: e,
                    groupValue: state.newValue,
                    onChanged: (value) =>
                        BlocProvider.of<AssetfunctioningBloc>(context).add(
                      AssetfunctioningEvent(newValue: value!),
                    ),
                  ))
              .toList(),
        );
      },
    );
  }
}

class AssetConditionWidget extends StatelessWidget {
  const AssetConditionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssetconditionBloc, AssetconditionState>(
      builder: (context, state) {
        final assetConditionList = PhysicalCondition.values
            .map(
              (e) => e.toString().split('.')[1],
            )
            .toList();
        return AssetMapListElement(
          title: 'Physical condition of the asset',
          children: assetConditionList
              .map((e) => AssetMapRadioListTile(
                    value: e,
                    groupValue: state.newValue,
                    onChanged: (value) =>
                        BlocProvider.of<AssetconditionBloc>(context).add(
                      AssetconditionEvent(newValue: value!),
                    ),
                  ))
              .toList(),
        );
      },
    );
  }
}

class AssetMapListElement extends StatelessWidget {
  const AssetMapListElement(
      {super.key, required this.title, required this.children});

  final String title;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpandablePanel(
        header: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        expanded: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
        theme: ExpandableThemeData(
          headerAlignment: ExpandablePanelHeaderAlignment.center,
          iconColor: Theme.of(context).iconTheme.color,
        ),
        collapsed: const Text(''),
      ),
    );
  }
}

class AssetMapRadioListTile extends StatelessWidget {
  final String value;
  final String groupValue;
  final void Function(String?)? onChanged;
  const AssetMapRadioListTile({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: RadioListTile(
        value: value,
        isThreeLine: false,
        contentPadding: const EdgeInsets.all(0.0),
        title: Text(value),
        dense: true,
        groupValue: groupValue,
        selected: value == groupValue,
        onChanged: onChanged,
      ),
    );
  }
}

class AssetMapCheckBoxListTile extends StatelessWidget {
  const AssetMapCheckBoxListTile({
    super.key,
    required this.title,
    required this.valueList,
    required this.onChanged,
  });

  final void Function(bool?)? onChanged;
  final String title;
  final List<String> valueList;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CheckboxListTile(
        isThreeLine: false,
        dense: true,
        onChanged: onChanged,
        title: Text(title),
        value: valueList.contains(title),
        selected: valueList.contains(title),
        contentPadding: const EdgeInsets.all(0.0),
      ),
    );
  }
}

class _AssetNameWidget extends StatelessWidget {
  const _AssetNameWidget({
    required this.nameController,
    required this.currentNode,
    required this.nextNode,
  });
  final TextEditingController nameController;
  final FocusNode currentNode;
  final FocusNode nextNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomTextFormField(
        fieldController: nameController,
        hintText: 'Enter the name of the asset',
        labelText: 'Name',
        prefixIcon: Icons.business,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        validator: (text) => text!.isEmpty ? 'This field cannot be empty' : '',
        currentNode: currentNode,
        nextNode: nextNode,
        semanticsLabel: 'Asset Name',
      ),
    );
  }
}

class _AssetDescriptionWidget extends StatelessWidget {
  const _AssetDescriptionWidget({
    required this.descriptionController,
    required this.currentNode,
  });

  final TextEditingController descriptionController;
  final FocusNode currentNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomTextFormField(
        fieldController: descriptionController,
        hintText: 'Enter the description of the asset',
        labelText: 'Description',
        prefixIcon: Icons.description,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        validator: (text) => text!.isEmpty ? 'This field cannot be empty' : '',
        currentNode: currentNode,
        semanticsLabel: 'Asset Name',
      ),
    );
  }
}

class _PartialFunctioningReasonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssetpartfunctioningBloc, AssetpartfunctioningState>(
      builder: (context, state) {
        final reasonList = assetPartFunctionReason;
        return AssetMapListElement(
          title: 'If functioning Partial',
          children: reasonList
              .map(
                (e) => AssetMapCheckBoxListTile(
                  title: e,
                  valueList: state.newValues,
                  onChanged: (isSelected) {
                    final tempList = state.newValues;
                    if (isSelected!) {
                      tempList.add(e);
                    } else {
                      tempList.remove(e);
                    }
                    BlocProvider.of<AssetpartfunctioningBloc>(context).add(
                      AssetpartfunctioningEvent(newValues: tempList),
                    );
                  },
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _UploadAssetButton extends StatelessWidget {
  const _UploadAssetButton({
    required this.onPressed,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.upload_file),
      label: const Text('Send'),
      onPressed: onPressed,
      style: ButtonStyle(
        enableFeedback: true,
        minimumSize: MaterialStateProperty.all<Size>(
          const Size(400, 42),
        ),
      ),
    );
  }
}
