import 'package:alertaday/src/model/notification_model.dart';
import 'package:alertaday/src/model/notification_new_model.dart'; // Import necessário
import 'package:alertaday/src/service/notification_service.dart';
import 'package:flutter/material.dart';

class AlertListPage extends StatefulWidget {
  const AlertListPage({super.key});

  @override
  State<AlertListPage> createState() => _AlertListPageState();
}

class _AlertListPageState extends State<AlertListPage> {
  // 1. O serviço
  final NotificationService _alertService = NotificationService();
  late Future<List<NotificationModel>> _futureAlerts;

  @override
  void initState() {
    super.initState();
    _futureAlerts = _alertService.getAlerts();
  }

  // --- NOVO MÉTODO PARA CHAMAR O POST ---
  Future<void> _fetchAlertsViaPost() async {
    try {
      // ⚠️ Assumindo que você ajustou o NotificationService para ter o método postAlerts
      final List<NotificationNewModel> newAlerts = await _alertService.postAlerts(); 
      
      // Aqui você precisará decidir o que fazer com a lista
      // Se a sua tela original só mostrava 'NotificationModel', 
      // você pode precisar de uma lógica de conversão ou mudar o tipo de lista.
      // Por enquanto, faremos o print para debugging:
      print('Notificações recebidas via POST: ${newAlerts.length}');

      // Se a intenção do botão POST é APENAS recarregar a lista exibida (que usa GET),
      // você deve chamar a função GET novamente:
      _refreshAlerts();

      // Você pode mostrar um feedback visual
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Alertas recarregados via POST (chamada simulada).')),
        );
      }

    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao tentar chamar POST: $e')),
        );
      }
      print('Erro ao chamar POST: $e');
    }
  }

  // Método auxiliar para recarregar a lista (usado no RefreshIndicator e no POST)
  void _refreshAlerts() {
    setState(() {
      _futureAlerts = _alertService.getAlerts(); // Ainda usando o GET para recarregar a UI
    });
  }
  // ----------------------------------------

  Color _severityColor(String severity) {
    // ... (Método inalterado)
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
    // ... (Método inalterado)
    if (dt == null) return '-';
    final local = dt.toLocal().toString();
    return local.split('.').first;
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
              _refreshAlerts(); // Usando o novo método de recarga
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
                        // ⚠️ Note: Se você mudou para NotificationNewModel,
                        // o campo 'message' pode não existir. Se a lista 
                        // ainda é NotificationModel, está OK.
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
      // --- NOVO WIDGET: FloatingActionButton ---
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchAlertsViaPost, // Chama o método POST ao ser pressionado
        child: const Icon(Icons.refresh),
        tooltip: 'Recarregar Alertas (via POST)',
      ),
    );
  }
}