import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckPoliticsScreen extends StatefulWidget {
  const CheckPoliticsScreen({super.key});

  @override
  State<CheckPoliticsScreen> createState() => _CheckPoliticsScreenState();
}

class _CheckPoliticsScreenState extends State<CheckPoliticsScreen> {
  bool _isAccepted = false;
  bool _isLoading = false;

  Future<String> loadAssetHtml() async {
    String htmlContent = await rootBundle.loadString(
      'assets/images/politics.html',
    );
    return htmlContent;
  }

  Future<void> _handleAccept() async {
    if (!_isAccepted) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('politicsAccepted', true);

      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao salvar a Policita. Tente novamente.'),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  final staticAnchorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Politica e Privacidade')),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: FutureBuilder<String>(
                future: loadAssetHtml(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Erro ao carregar a politica: ${snapshot.error}',
                      ),
                    );
                  } else if (snapshot.hasData) {
                    return Html(
                      anchorKey: staticAnchorKey,
                      data: snapshot.data,
                      style: {
                        "table": Style(
                          backgroundColor: const Color.fromARGB(
                            0x50,
                            0xee,
                            0xee,
                            0xee,
                          ),
                        ),
                        "th": Style(
                          padding: HtmlPaddings.all(6),
                          backgroundColor: Colors.grey,
                        ),
                        "td": Style(
                          padding: HtmlPaddings.all(6),
                          border: const Border(
                            bottom: BorderSide(color: Colors.grey),
                          ),
                        ),
                        'h5': Style(
                          maxLines: 2,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                        'flutter': Style(
                          display: Display.block,
                          fontSize: FontSize(5, Unit.em),
                        ),
                        ".second-table": Style(
                          backgroundColor: Colors.transparent,
                        ),
                        ".second-table tr td:first-child": Style(
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.end,
                        ),
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              // ignore: use_build_context_synchronously
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CheckboxListTile(
                  value: _isAccepted,
                  onChanged: (bool? value) {
                    setState(() {
                      _isAccepted = value ?? false;
                    });
                  },
                  title: const Text(
                    'Li e concordo com a Politica de Privacidade',
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _isAccepted && !_isLoading
                        ? _handleAccept
                        : null,
                    child: _isLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Confirmar e Continuar'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
