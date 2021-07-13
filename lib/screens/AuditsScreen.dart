import 'package:flutter/material.dart';
import 'package:revisiones_spm/models/audit.dart';
import 'package:revisiones_spm/services/AuditService.dart';
import 'dart:async';

class AuditsScreen extends StatefulWidget {
  get title => 'Auditorías';

  @override
  _AuditsScreenState createState() => _AuditsScreenState();
}

class _AuditsScreenState extends State<AuditsScreen> {
  List<Audit> _audits;
  GlobalKey<ScaffoldState> _scaffoldKey;
  String _titleProgress;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _audits = [];
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey(); // key to get the context to show a SnackBar
    _getAudits();
  }

  // Method to update title in the AppBar Title
  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _showSnackBar(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  // add an Audit
  _addAudit() {
    _showProgress('Adding Audit...');
    Navigator.pushNamed(context, '/form_audit'); // go to FormScreen
  }

  _getAudits() {
    _showProgress('Loading Audits...');
    AuditService.getAllAudits().then((audits) {
      setState(() {
        _audits = audits;
      });
      _showProgress(widget.title); // Reset the title
      print("Length ${audits.length}");
    });
  }

  _updateAudit(Audit audit) {
    _showProgress('Updating Audit...');
    Navigator.pushNamed(context, '/form_audit_update', arguments: audit);
  }

  _deleteAudit(Audit audit) {
    _showProgress('Deleting Audit...');
    AuditService.deleteAudit(audit.id).then((result) {
      if ('success' == result) {
        _getAudits(); // Refresh after delete...
      }
    });
  }

  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_titleProgress),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getAudits();
            },
          )
        ],
      ),
      body: RefreshIndicator(
        color: Theme.of(context).primaryColor,
        displacement: 40,
        child: SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: ExpansionPanelList(
              animationDuration: Duration(milliseconds: 500),
              expansionCallback: (panelIndex, isExpanded) {
                setState(() {
                  _audits[panelIndex].isExpanded = !isExpanded;
                });
              },
              children: _audits.map<ExpansionPanel>((Audit audit) {
                List fields = [
                  audit.userName,
                  audit.dateStart,
                  audit.time,
                  audit.checklist,
                ];
                return ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return ListTile(
                        contentPadding: EdgeInsets.all(10.0),
                        title: Text(
                          audit.shipName,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        subtitle: Text(audit.id),
                        trailing: Wrap(spacing: 9, children: <Widget>[
                          IconButton(
                              onPressed: () {
                                _summaryAudit(audit);
                              },
                              icon: Icon(Icons.bar_chart)),
                          IconButton(
                              onPressed: () {
                                _updateAudit(audit);
                              },
                              icon: Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                _deleteAudit(audit);
                              },
                              icon: Icon(Icons.delete)),
                        ]),
                        leading: IconButton(
                            onPressed: () {
                              _startAudit(audit);
                            },
                            icon: Icon(Icons.play_circle_outline)));
                  },
                  body: Container(
                    height: 200,
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: ListView.builder(
                      itemCount: fields.length,
                      itemBuilder: (BuildContext context, int position) {
                        return getRow(position, fields);
                      },
                    ),
                  ),
                  isExpanded: audit.isExpanded,
                );
              }).toList(),
            ),
          ),
        ),
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2), () {
            // do something
            _getAudits();
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addAudit();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget getRow(int i, List fields) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: ListTile(
          title: Text(
            fields[i],
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
