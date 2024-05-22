import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tractian_tree/app/models/companies_model.dart';
import 'package:tractian_tree/app/views/pages/sensor/blocs/bloc/tree_bloc.dart';
import 'package:tractian_tree/app/views/pages/sensor/blocs/event/tree_event.dart';
import 'package:tractian_tree/app/views/pages/sensor/blocs/state/tree_state.dart';
import 'package:tractian_tree/app/views/pages/sensor/components/build_tree.dart';
import 'package:tractian_tree/app/views/style/style.dart';
import 'package:tractian_tree/app/views/tools/context_extension.dart';

class SensorPage extends StatefulWidget {
  final CompanyModel company;
  const SensorPage({super.key, required this.company});

  @override
  State<SensorPage> createState() => _SensorPageState();
}

class _SensorPageState extends State<SensorPage> {
  late final TreeBloc treeBloc;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    treeBloc = TreeBloc();
    treeBloc.add(AllAssetsTreeEvent(company: widget.company));
    super.initState();
  }

  @override
  void dispose() {
    treeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    searchController.addListener(() {
      if (searchController.text.isEmpty) {
        treeBloc.add(AllAssetsTreeEvent(company: widget.company));
      }
    });
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: SizedBox(
              width: context.width * 0.9,
              child: TextField(
                maxLength: 20,
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: 'Search',
                  counterText: '',
                  prefixIcon: Icon(Icons.search),
                  contentPadding: EdgeInsets.all(20.0),
                ),
                onSubmitted: (value) {
                  treeBloc.add(
                      SearchTreeEvent(company: widget.company, query: value));
                },
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            actions: const [],
          ),
          body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          style: buttonStyle(),
                          onPressed: () {
                            treeBloc
                                .add(EnergyTreeEvent(company: widget.company));
                          },
                          child: const Row(
                            children: [
                              Icon(
                                Icons.bolt,
                                color: Colors.amber,
                              ),
                              SizedBox(width: 6.0),
                              Text('Powers Sensor'),
                            ],
                          )),
                      ElevatedButton(
                          style: buttonStyle(),
                          onPressed: () {
                            treeBloc.add(
                                CriticalTreeEvent(company: widget.company));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.warning_amber_rounded,
                                  color: context.colors.error),
                              const SizedBox(width: 6.0),
                              const Text('Critical Sensor'),
                            ],
                          )),
                      ElevatedButton(
                          style: buttonStyle(),
                          onPressed: () {
                            treeBloc.add(
                                AllAssetsTreeEvent(company: widget.company));
                          },
                          child: const Row(
                            children: [
                              Icon(
                                Icons.clear_all_rounded,
                              ),
                              SizedBox(width: 6.0),
                              Text('All Sensor'),
                            ],
                          )),
                    ],
                  ),
                  BlocBuilder<TreeBloc, TreeState>(
                      bloc: treeBloc,
                      builder: (_, state) {
                        if (state is TreeEnergySuccessState) {
                          return BuildTree(data: state.company!, padding: 0);
                        }
                        if (state is TreeCriticalSuccessState) {
                          return BuildTree(data: state.company!, padding: 0);
                        }
                        if (state is TreeSearchResultState) {
                          return BuildTree(data: state.company!, padding: 0);
                        }
                        if (state is TreeSuccessState) {
                          return BuildTree(data: widget.company, padding: 0);
                        }
                        return Container();
                      }),
                ],
              ))),
    );
  }
}
