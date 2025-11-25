import 'package:flutter/material.dart';
import 'package:connect_flutter_plugin/connect_flutter_plugin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Wrap the app with Connect widget for auto instrumentation
  runApp(Connect(child: BancoEstadoApp()));
}

class BancoEstadoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BancoEstado Empresas',
      home: WelcomeScreen(),

      /// Add Connect logging observer to track navigation events
      navigatorObservers: [Connect.loggingNavigatorObserver],
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    // Manually log the screen name for Welcome Screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      PluginConnect.logScreenLayout('Pantalla de Bienvenida');
    });
  }

  void _showLoginDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      routeSettings: RouteSettings(name: 'Login - Clave de Internet'),
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: LoginBottomSheet(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2E3942),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo - using dollar sign instead of image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  '\$',
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E3942),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('Hola Juanjo Gonzalez',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _showLoginDialog(context),
              child: Text('Ingresar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text('¿Problemas con su Clave de internet?',
                style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}

class LoginBottomSheet extends StatefulWidget {
  @override
  State<LoginBottomSheet> createState() => _LoginBottomSheetState();
}

class _LoginBottomSheetState extends State<LoginBottomSheet> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Manually log the screen name for Login Bottom Sheet
    WidgetsBinding.instance.addPostFrameCallback((_) {
      PluginConnect.logScreenLayout('Login - Clave de Internet');
    });
  }

  void _navigateToHome() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.lock_outline),
              Spacer(),
              IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context))
            ],
          ),
          Text('Ingrese su Clave de Internet'),
          TextField(controller: _controller, obscureText: true),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _navigateToHome,
            child: Text('Aceptar'),
          )
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Manually log the screen name for Home Screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      PluginConnect.logScreenLayout('Pantalla Principal');
    });
  }

  void _showBottomWidget(BuildContext context, String title) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      routeSettings: RouteSettings(name: 'BottomSheet - $title'),
      builder: (buildContext) => BottomSheetWidget(title: title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2E3942),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hola, Juanjo Gonzalez', style: TextStyle(fontSize: 16)),
            Text('Celula Mercury', style: TextStyle(fontSize: 12)),
          ],
        ),
        actions: [
          CircleAvatar(child: Text('JG')),
          SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: _ShortcutButton(
                title: 'Autorizar Transferencias',
                onTap: () =>
                    _showBottomWidget(context, 'Autorizar Transferencias'),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: _ShortcutButton(
                title: 'Realizar Transferencias',
                onTap: () =>
                    _showBottomWidget(context, 'Realizar Transferencias'),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: _ShortcutButton(
                title: 'Consultar transferencias',
                onTap: () =>
                    _showBottomWidget(context, 'Consultar transferencias'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          final titles = ['Inicio', 'Transferir', 'Seguridad', '+Servicios'];
          _showBottomWidget(context, titles[index]);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.send), label: 'Transferir'),
          BottomNavigationBarItem(icon: Icon(Icons.lock), label: 'Seguridad'),
          BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz), label: '+Servicios'),
        ],
      ),
    );
  }
}

class _ShortcutButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _ShortcutButton({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.monetization_on, size: 40, color: Color(0xFF2E3942)),
            SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomSheetWidget extends StatefulWidget {
  final String title;

  const BottomSheetWidget({Key? key, required this.title}) : super(key: key);

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  @override
  void initState() {
    super.initState();
    // Manually log the screen name for Bottom Sheet with dynamic title
    WidgetsBinding.instance.addPostFrameCallback((_) {
      PluginConnect.logScreenLayout('BottomSheet - ${widget.title}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
