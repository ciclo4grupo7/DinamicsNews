import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dynamics_news/data/services/work_pool.dart';
import 'package:dynamics_news/domain/models/wanews.dart';
import 'package:dynamics_news/domain/use_cases/controllers/connectivity.dart';
import 'widgets/wanews_card.dart';

class WNewsScreen extends StatefulWidget {
  // WNewsScreen empty constructor
  const WNewsScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<WNewsScreen> {
  late WorkPoolService service;
  late Future<List<WANews>> futureJobs;
  late ConnectivityController connectivityController;

  @override
  void initState() {
    super.initState();
    service = WorkPoolService();
    futureJobs = service.fecthData();
    connectivityController = Get.find<ConnectivityController>();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<WANews>>(
      future: futureJobs,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final items = snapshot.data!;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              WANews job = items[index];
              return WANewsCard(
                title: job.title,
                content: job.description,
                arch: job.category,
                level: job.experience,
                payment: job.payment,
                onApply: () => {},
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
