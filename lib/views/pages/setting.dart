part of _view;

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final brightnessProvider = context.read<BrightnessProvider>();
    // final localeProvider = context.read<LocalizationProvider>();
    // print('build setting page');
    // print(RouteData.of(context).path);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: ListView(
        children: [
          StatefulValueBuilder<bool>(
            initialValue: brightnessProvider.brightnessForTheme != Brightness.light,
            builder: (context, stateValue, setValue) {
              return SwitchListTile(
                value: stateValue ?? false,
                title: const Text('Brightness'),
                onChanged: (value) {
                  if (value) {
                    brightnessProvider.setToDark();
                    setValue(true);
                  } else {
                    brightnessProvider.setToLight();
                    setValue(false);
                  }
                },
              );
            }
          ),
          // ListTile(
          //   title: const Text('Language'),
          //   onTap: () {
              
          //   },
          // )
        ],
      ),
    );
  }
}