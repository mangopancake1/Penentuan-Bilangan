part of 'pages.dart';

class PenentuanBilangan extends StatefulWidget {
  @override
  _PenentuanBilangan createState() => _PenentuanBilangan();
}

class _PenentuanBilangan extends State<PenentuanBilangan> {
  final TextEditingController inputController = TextEditingController();
  String hasil = "";
  String? _inputError;

  void cekBilangan() {
    String inputText = inputController.text.trim();

    if (inputText.isEmpty) {
      setState(() {
        _inputError = "Kolom ini tidak boleh kosong";
        hasil = "";
      });
      _showErrorSnackBar("Input tidak boleh kosong!");
      return;
    }

    bool isPrima(BigInt angka) {
      if (angka < BigInt.from(2)) return false;
      if (angka == BigInt.two) return true;
      if (angka.isEven) return false;
      for (BigInt i = BigInt.from(3); i * i <= angka; i += BigInt.two) {
        if (angka % i == BigInt.zero) return false;
      }
      return true;
    }

    String cekPositifNegatif(BigInt angka) {
      if (angka > BigInt.zero) return "Positif";
      if (angka < BigInt.zero) return "Negatif";
      return "Nol";
    }

    List<String> angkaList = inputText.split(RegExp(r'[ ,]+'));
    List<String> hasilList = [];
    bool hasError = false;

    for (var angkaStr in angkaList) {
      BigInt? angka = BigInt.tryParse(angkaStr);
      if (angka != null) {
        String jenis = angka.isEven ? "Genap" : "Ganjil";
        String nilai = cekPositifNegatif(angka);
        String prima = isPrima(angka) ? "Prima" : "Bukan Prima";

        hasilList.add("$angka → $jenis | $nilai | $prima");
      } else {
        hasError = true;
      }
    }

    if (hasError) {
      setState(() {
        _inputError = "Masukkan angka yang valid";
        hasil = "";
      });
      _showErrorSnackBar("Input tidak valid!");
    } else {
      setState(() {
        _inputError = null;
        hasil = hasilList.join("\n");
      });
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cek Bilangan'),
        backgroundColor: secondaryColor,
      ),
      drawer: const CustomDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF333A73),
              Color(0xFF333A73),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    controller: inputController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Masukkan bilangan",
                      errorText: _inputError,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: cekBilangan,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFBA834),
                  foregroundColor: Color(0xFFFFFFFF),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ),
                child: Text("Cek Bilangan", style: TextStyle(fontSize: 18)),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    hasil,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
