import 'package:flutter/material.dart';
import 'certificat_tab_view.dart';

class CertificatView extends StatelessWidget {
  const CertificatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Certificats')),
      body: const CertificatTabView(),
    );
  }
}
