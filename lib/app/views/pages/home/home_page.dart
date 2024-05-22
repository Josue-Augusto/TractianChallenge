import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tractian_tree/app/models/assets_model.dart';
import 'package:tractian_tree/app/views/components/empty_widget.dart';
import 'package:tractian_tree/app/views/pages/home/blocs/bloc/alert_bloc.dart';
import 'package:tractian_tree/app/views/pages/home/blocs/bloc/company_bloc.dart';
import 'package:tractian_tree/app/views/pages/home/blocs/event/alert_event.dart';
import 'package:tractian_tree/app/views/pages/home/blocs/event/comapny_event.dart';
import 'package:tractian_tree/app/views/pages/home/blocs/state/alert_state.dart';
import 'package:tractian_tree/app/views/pages/home/blocs/state/company_state.dart';
import 'package:tractian_tree/app/views/pages/home/components/alert_widgets.dart';
import 'package:tractian_tree/app/views/pages/home/components/image_profile.dart';
import 'package:tractian_tree/app/views/pages/home/components/load_apert_widget.dart';
import 'package:tractian_tree/app/views/pages/home/components/load_company_widget.dart';
import 'package:tractian_tree/app/views/pages/home/components/unit_widget.dart';
import 'package:tractian_tree/app/views/pages/sensor/sensor_page.dart';
import 'package:tractian_tree/app/views/style/style.dart';
import 'package:tractian_tree/app/views/tools/context_extension.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final CompanyBloc companyBloc;
  late final AlertBloc alertBloc;
  List<AssetsModel> assetsWithAlert = [];

  @override
  void initState() {
    companyBloc = CompanyBloc();
    companyBloc.add(LoadCompanyEvent());
    alertBloc = AlertBloc();
    super.initState();
  }

  @override
  void dispose() {
    companyBloc.close();
    alertBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Home',
            style: textStyle(colors: context.colors.scrim),
          ),
          actions: const [ProfileImage()],
        ),
        body: SizedBox(
          width: context.width,
          height: context.heigth,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text('Units',
                  style: textStyle(colors: context.colors.tertiary, size: 16)),
            ),
            BlocBuilder<CompanyBloc, CompanyState>(
                bloc: companyBloc,
                builder: (_, state) {
                  if (state is CompanyInitialState ||
                      state is CompanyLoadState) {
                    return const LoadComapnyWidget();
                  }
                  if (state is CompanySuccessState) {
                    alertBloc.add(LoadAlertEvent(companies: state.companies));
                    if (state.companies.isNotEmpty) {
                      return SizedBox(
                        height: context.heigth * 0.25,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: state.companies.length,
                          itemBuilder: (context, index) {
                            return UnitWidget(
                                index: index,
                                name: state.companies[index].name,
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => SensorPage(
                                            company: state.companies[index],
                                          )));
                                });
                          },
                        ),
                      );
                    } else {
                      return const EmptyWidget(
                          message: 'Don\'t have companies to show here!');
                    }
                  }
                  if (state is CompanyErrorState) {
                    return EmptyWidget(
                      message: state.error.toString(),
                      icon: Icons.error,
                      heigth: context.heigth * 0.6,
                      width: context.width,
                    );
                  }
                  return EmptyWidget(
                    message: 'Unknown error, please try again!',
                    icon: Icons.error,
                    heigth: context.heigth * 0.6,
                    width: context.width,
                  );
                }),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text('Sensor alert',
                  style: textStyle(colors: context.colors.tertiary, size: 16)),
            ),
            BlocBuilder<AlertBloc, AlertState>(
              bloc: alertBloc,
              builder: (_, state) {
                if (state is AlertLoadState || state is AlertInitialState) {
                  return const LoadAlertWidget();
                }
                if (state is AlertSuccessState) {
                  if (state.warning.isNotEmpty) {
                    return SizedBox(
                      height: context.heigth * 0.6,
                      child: ListView.builder(
                        itemCount: state.warning.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return AlertWidget(
                              icon: state.warning[index].icon,
                              index: index,
                              name: state.warning[index].name,
                              sensorType: state.warning[index].sensorType);
                        },
                      ),
                    );
                  } else {
                    return EmptyWidget(
                      message: 'At Units don\'t have alerts!',
                      heigth: context.heigth * 0.6,
                      width: context.width,
                    );
                  }
                }
                return EmptyWidget(
                  message: 'unknown error!',
                  heigth: context.heigth * 0.6,
                  width: context.width,
                );
              },
            )
          ]),
        ),
      ),
    );
  }
}
