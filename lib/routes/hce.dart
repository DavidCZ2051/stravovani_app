// packages
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:nfc_host_card_emulation/nfc_host_card_emulation.dart';
// files
import 'package:stravovani_app/widgets/drawer.dart';

class HceScreen extends StatefulWidget {
  const HceScreen({super.key});

  @override
  State<HceScreen> createState() => _HceScreenState();
}

class _HceScreenState extends State<HceScreen> {
  bool enabled = false; // move to globals.dart

  void showNfcDisabledBanner() {
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: const Row(
          children: [
            Icon(Icons.warning),
            SizedBox(width: 8),
            Text("Tato funkce vyžaduje zapnuté NFC."),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            },
            child: const Text("Zavřít"),
          ),
          TextButton(
            onPressed: () {
              // TODO: Open NFC settings
            },
            child: const Text("Otevřít nastavení"),
          ),
        ],
      ),
    );
  }

  void showNfcNotSupportedDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("NFC není podporováno"),
          content: const Text(
            "Tato funkce funguje pouze na zařízeních s Androidem a s podporou NFC.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<void> enableHce() async {
    final nfcState = await NfcHce.checkDeviceNfcState();

    if (nfcState == NfcState.notSupported) {
      return showNfcDisabledBanner();
    } else if (nfcState == NfcState.disabled) {
      return showNfcDisabledBanner();
    }

    // await getAuthMediumId();

    await NfcHce.init(
      aid: Uint8List.fromList([0x73, 0x2A, 0x77, 0xFD, 0xDA, 0x11, 0x21]),
      listenOnlyConfiguredPorts: true,
      permanentApduResponses: true,
    );

    await NfcHce.addApduResponse(
      52,
      [], // here will be the user's authMediumId
    );
  }

  Future<void> disableHce() async {
    await NfcHce.removeApduResponse(52);

    setState(() {
      enabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text("Mobilní karta"),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              "Mobilní karta umožňuje \"pípnout si\" mobilním telefonem. Tato funkce funguje pouze na zařízeních s Androidem a s podporou NFC. Pokud zapnuta, stačí přiložit zařízení ke čtečce.",
              style: TextStyle(fontSize: 16),
            ),
          ),
          SwitchListTile(
            value: enabled,
            onChanged: (value) async {
              if (value) {
                await enableHce();
              } else {
                await disableHce();
              }
            },
            title: const Text("Zapnout mobilní kartu"),
          ),
        ],
      ),
    );
  }
}
