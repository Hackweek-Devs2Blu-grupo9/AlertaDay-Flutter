import 'package:alertaday/src/model/notification_model.dart';
import 'package:alertaday/src/service/notification_service.dart';
import 'package:flutter/material.dart';


class AlertListPage extends StatefulWidget {
  const AlertListPage({super.key});

  @override
  State<AlertListPage> createState() => _AlertListPageState();
}

class _AlertListPageState extends State<AlertListPage> {
  final NotificationService _alertService = NotificationService();
  late Future<List<NotificationModel>> _futureAlerts;

  @override
  void initState() {
    super.initState();
    _futureAlerts = _alertService.getAlerts();
  }

  Color _severityColor(String severity) {
    switch (severity.toUpperCase()) {
      case 'CRITICA':
        return Colors.red;
      case 'ALTA':
        return Colors.orange;
      case 'MEDIA':
        return Colors.amber;
      case 'BAIXA':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime? dt) {
    if (dt == null) return '-';
    // Simples: yyyy-MM-dd HH:mm
    final local = dt.toLocal().toString();
    return local.split('.').first; // corta milissegundos
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alertas'),
      ),
      body: FutureBuilder<List<NotificationModel>>(
        future: _futureAlerts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar alerts:\n${snapshot.error}'),
            );
          }

          final alerts = snapshot.data ?? [];

          if (alerts.isEmpty) {
            return const Center(child: Text('Nenhum alerta encontrado'));
          }

          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                _futureAlerts = _alertService.getAlerts();
              });
            },
            child: ListView.builder(
              itemCount: alerts.length,
              itemBuilder: (context, index) {
                final alert = alerts[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _severityColor(alert.severity),
                      child: Text(
                        alert.severity[0].toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      alert.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          alert.message,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Criado em: ${_formatDate(alert.createdAt)}',
                          style: const TextStyle(fontSize: 12),
                        ),
                        if (alert.region != null && alert.region!.isNotEmpty)
                          Text(
                            'Região: ${alert.region}',
                            style: const TextStyle(fontSize: 12),
                          ),
                      ],
                    ),
                    
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        //},
      //),
    //);
  }
}
