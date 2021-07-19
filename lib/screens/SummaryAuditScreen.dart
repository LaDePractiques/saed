import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:revisiones_spm/models/answer.dart';
import 'package:revisiones_spm/models/audit.dart';
import 'package:revisiones_spm/services/AuditService.dart';

class SummaryAuditScreen extends StatefulWidget {
  get title => 'Resumen';
  final String auditId;

  const SummaryAuditScreen(this.auditId, {Key key}) : super(key: key);

  @override
  _SummaryAuditScreen createState() => _SummaryAuditScreen(auditId);
}

class _SummaryAuditScreen extends State<SummaryAuditScreen> {
  List<ChartAudit> _answers;
  GlobalKey<ScaffoldState> _scaffoldKey;
  String _titleProgress;
  ScrollController _scrollController = ScrollController();
  String auditId;
  List<charts.Series<ChartAudit, String>> _seriesList;
  _SummaryAuditScreen(this.auditId);

  @override
  void initState() {
    super.initState();
    _answers = [];
    _seriesList = [];
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey(); // key to get the context to show a SnackBar
    _generateData(auditId);
    //_seriesList = _getData();
  }

  _generateData(String auditId) {
    AuditService.getdata(auditId).then((answers) {
      print("Length ${answers.length}");
      setState(() {
        _answers = answers;
        return [
          new charts.Series(
            domainFn: (ChartAudit data, _) => data.answer,
            measureFn: (ChartAudit data, _) => int.parse(data.total),
            id: 'Auditoría',
            data: _answers,
            labelAccessorFn: (ChartAudit row, _) => '${row.answer}',
          ),
        ];
      });
    });
  }

  _getData() {
    _seriesList.add(
      charts.Series(
        domainFn: (ChartAudit data, _) => data.answer,
        measureFn: (ChartAudit data, _) => int.parse(data.total),
        id: 'Auditoría',
        data: _answers,
        labelAccessorFn: (ChartAudit row, _) => '${row.answer}',
      ),
    );
    return _seriesList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(_titleProgress),
        ),
        body: Center(
          child: SafeArea(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: charts.PieChart(
                _generateData(auditId),
                animate: true,
                animationDuration: Duration(seconds: 5),
                defaultRenderer: new charts.ArcRendererConfig(
                  arcWidth: 100,
                  arcRendererDecorators: [
                    new charts.ArcLabelDecorator(
                        labelPosition: charts.ArcLabelPosition.inside)
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
