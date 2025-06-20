import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/services/api.dart';
import '../../../data/models/models.dart';
import 'dart:convert';

class CertificatTabView extends StatefulWidget {
  const CertificatTabView({Key? key}) : super(key: key);

  @override
  State<CertificatTabView> createState() => _CertificatTabViewState();
}

class _CertificatTabViewState extends State<CertificatTabView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<dynamic> certificats = [];
  List<dynamic> inscrits = [];
  bool loadingCertificats = true;
  bool loadingInscrits = true;
  String? errorCertificats;
  String? errorInscrits;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchCertificats();
    fetchInscrits();
  }

  Future<void> fetchCertificats() async {
    setState(() {
      loadingCertificats = true;
      errorCertificats = null;
    });
    final box = GetStorage();
    final userId = box.read('userId');
    if (userId == null) return;
    try {
      final response = await ApiService.getCertificats(userId);
      if (response.statusCode == 200) {
        certificats = jsonDecode(response.body);
      } else {
        errorCertificats = 'Erreur lors du chargement des certificats';
      }
    } catch (e) {
      errorCertificats = 'Erreur de connexion';
    }
    setState(() {
      loadingCertificats = false;
    });
  }

  Future<void> fetchInscrits() async {
    setState(() {
      loadingInscrits = true;
      errorInscrits = null;
    });
    try {
      // Pour l'exemple, on prend la première formation du user
      final box = GetStorage();
      final userId = box.read('userId');
      final certs = certificats;
      if (certs.isNotEmpty) {
        final formationId = certs.first['idFormation'];
        final response = await ApiService.getInscrits(formationId);
        if (response.statusCode == 200) {
          inscrits = jsonDecode(response.body);
        } else {
          errorInscrits = 'Erreur lors du chargement des inscrits';
        }
      }
    } catch (e) {
      errorInscrits = 'Erreur de connexion';
    }
    setState(() {
      loadingInscrits = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Mes certificats'),
            Tab(text: 'Inscrits formation'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // Tab 1 : Certificats
              loadingCertificats
                  ? const Center(child: CircularProgressIndicator())
                  : errorCertificats != null
                  ? Center(child: Text(errorCertificats!))
                  : certificats.isEmpty
                  ? const Center(child: Text('Aucun certificat.'))
                  : ListView.builder(
                      itemCount: certificats.length,
                      itemBuilder: (context, index) {
                        final cert = certificats[index];
                        return ListTile(
                          title: Text('Formation : ${cert['idFormation']}'),
                          subtitle: Text('Score : ${cert['score'] ?? 'N/A'}'),
                        );
                      },
                    ),
              // Tab 2 : Inscrits
              loadingInscrits
                  ? const Center(child: CircularProgressIndicator())
                  : errorInscrits != null
                  ? Center(child: Text(errorInscrits!))
                  : inscrits.isEmpty
                  ? const Center(child: Text('Aucun inscrit.'))
                  : ListView.builder(
                      itemCount: inscrits.length,
                      itemBuilder: (context, index) {
                        final inscrit = inscrits[index];
                        return ListTile(
                          title: Text(
                            inscrit['nom'] ?? inscrit['email'] ?? 'Utilisateur',
                          ),
                          subtitle: Text('ID : ${inscrit['id']}'),
                        );
                      },
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
