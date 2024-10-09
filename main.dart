import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Para formatear las fechas
import 'package:shared_preferences/shared_preferences.dart';
import 'package:another_flushbar/flushbar.dart';

// Función para validar correos electrónicos
bool validateEmail(String email) {
  RegExp regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  return regex.hasMatch(email);
}

// Función para validar contraseñas
bool validatePassword(String password) {
  RegExp regex = RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
  return regex.hasMatch(password);
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dream Trip',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
      routes: {
  '/register': (context) => const RegisterPage(),
  '/login': (context) => const LoginPage(),
  '/search-results': (context) => const SearchResultsPage(),
  '/profile': (context) => const ProfilePage(),
  '/destinationDetail': (context) => const DestinationDetailPage(title: '', description: '', imagePath: ''), // Esto puede eliminarse
},
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.flight),
            SizedBox(width: 8),
            Text('DREAM TRIP'),
          ],
        ),
        actions: [
  TextButton(
    onPressed: () {
      Navigator.pushNamed(context, '/login');
    },
    child: const Text('Iniciar sesión', style: TextStyle(color: Colors.white)),
  ),
  TextButton(
    onPressed: () {
      Navigator.pushNamed(context, '/register');
    },
    child: const Text('Registrarse', style: TextStyle(color: Colors.white)),
  ),
  IconButton(
    icon: const Icon(Icons.person), // Ícono de perfil
    onPressed: () {
      Navigator.pushNamed(context, '/profile'); // Navegar a la página de perfil
    },
  ),
],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SearchForm(),
              const SizedBox(height: 24),
              const Text(
                'Destinos populares',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 4,  // Ajusta la cantidad de columnas
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 0.9,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: const [
                  DestinationCard(
                    title: 'Tokio-Japón',
                    description: 'Tokio es la enorme y rica capital de Japón, rebosante de cultura, comercio y personas.',
                    imagePath: 'assets/images/tokyo.jpg',
                  ),
                  DestinationCard(
                    title: 'Paris-Francia',
                    description: 'Descubre la rica historia y los impresionantes paisajes de este destino.',
                    imagePath: 'assets/images/paris.jpg',
                  ),
                  DestinationCard(
                    title: 'Cartagena-Colombia',
                    description: 'Experimenta la emoción de la aventura y la belleza de la naturaleza en este destino.',
                    imagePath: 'assets/images/cartagena.jpeg',
                  ),
                  DestinationCard(
                    title: 'Roma-Italia',
                    description: 'Sumérgete en la vibrante cultura y las modernas comodidades de este destino.',
                    imagePath: 'assets/images/roma.jpg',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '© 2023 VIAJE SOÑADO. Todos los derechos reservados.',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class PassengerInfoPage extends StatelessWidget {
  const PassengerInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información del Pasajero'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Ingrese los detalles del pasajero:', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(labelText: 'Apellido'),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(labelText: 'Número de identificación'),
            ),
            const SizedBox(height: 16),
            const Text('Método de Pago:', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(labelText: 'Número de tarjeta'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(labelText: 'Fecha de expiración (MM/AA)'),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Aquí puedes implementar el método para procesar el pago
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Información guardada con éxito')),
                  );
                  Navigator.pop(context); // Regresar a la pantalla anterior
                },
                child: const Text('Registrar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _profileImage = 'assets/images/default_profile.png'; // Imagen por defecto
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Cargar datos del usuario al inicio
  }

  void _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _nameController.text = prefs.getString('userName') ?? 'Nombre';
    _emailController.text = prefs.getString('userEmail') ?? 'email@ejemplo.com';
    // Cargar imagen de perfil si se ha configurado
    _profileImage = prefs.getString('profileImage') ?? 'assets/images/default_profile.png';
    setState(() {});
  }

  void _saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', _nameController.text);
    await prefs.setString('userEmail', _emailController.text);
    await prefs.setString('profileImage', _profileImage); // Guardar imagen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Datos guardados exitosamente.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                // Aquí puedes implementar la funcionalidad para seleccionar una nueva imagen
              },
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(_profileImage),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Correo electrónico'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveUserData,
              child: const Text('Guardar Cambios'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Aquí puedes implementar la funcionalidad de compartir el enlace
              },
              child: const Text('Compartir enlace de referido'),
            ),
          ],
        ),
      ),
    );
  }
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  List<String> _registeredUsers = [];
  List<String> _registeredPasswords = [];
  bool _isLoading = false; // Control de carga
  bool _isPasswordVisible = false; // Estado para mostrar/ocultar contraseña

  void _register() async {
    setState(() {
      _isLoading = true; // Muestra el indicador de carga
    });

    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      print('Validando email...');
      // Validación de email
      if (!validateEmail(email)) {
        _showError(context, 'Por favor, introduce un correo electrónico válido.');
        setState(() {
          _isLoading = false;
        });
        return;
      }

      print('Validando contraseña...');
      // Validación de contraseña
      if (!validatePassword(password)) {
        _showError(context, 'La contraseña debe tener al menos 8 caracteres, una mayúscula y un carácter especial.');
        setState(() {
          _isLoading = false;
        });
        return;
      }

      print('Obteniendo SharedPreferences...');
      SharedPreferences prefs = await SharedPreferences.getInstance();

      print('Cargando usuarios registrados...');
      _registeredUsers = prefs.getStringList('registeredUsers') ?? [];
      _registeredPasswords = prefs.getStringList('registeredPasswords') ?? [];

      print('Verificando si el usuario ya existe...');
      if (_registeredUsers.contains(email)) {
        _showError(context, 'El usuario ya está registrado.');
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Añadir nuevo usuario
      print('Registrando usuario...');
      _registeredUsers.add(email);
      _registeredPasswords.add(password);

      // Guardar en SharedPreferences
      print('Guardando en SharedPreferences...');
      await prefs.setStringList('registeredUsers', _registeredUsers);
      await prefs.setStringList('registeredPasswords', _registeredPasswords);

      print('Registro exitoso.');
      // Notificación de registro exitoso con SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('¡Registro exitoso! Tu cuenta ha sido creada correctamente.'),
          duration: Duration(seconds: 3),
        ),
      );

      // Reemplazar la pantalla de registro con la pantalla de inicio
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } catch (e) {
      _showError(context, 'Ocurrió un error durante el registro: $e');
      print('Error en el registro: $e');
    } finally {
      setState(() {
        _isLoading = false; // Oculta el indicador de carga
        print('Estado de carga terminado.');
      });
    }
  }

  // Método _showError
  void _showError(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrarse'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Crear una cuenta',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible, // Contraseña oculta o visible
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible; // Cambiar visibilidad
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            _isLoading
                ? Center(child: CircularProgressIndicator()) // Indicador de carga
                : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _register,
                      child: const Text('Registrarse'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.blueAccent, // Color azul en el botón
                        textStyle: const TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Bordes redondeados
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

// Página de inicio de sesión
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false; // Control de carga
  bool _isPasswordVisible = false; // Estado para mostrar/ocultar contraseña

  void _login() async {
  setState(() {
    _isLoading = true; // Muestra el indicador de carga
  });

  final email = _emailController.text;
  final password = _passwordController.text;

  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? registeredUsers = prefs.getStringList('registeredUsers');
    List<String>? registeredPasswords = prefs.getStringList('registeredPasswords');

    if (registeredUsers == null || registeredPasswords == null) {
      _showError(context, 'No se han encontrado usuarios registrados.');
      return;
    }

    // Verificar si el usuario existe y la contraseña es correcta
    final int userIndex = registeredUsers.indexOf(email);
    if (userIndex == -1 || registeredPasswords[userIndex] != password) {
      _showError(context, 'Usuario o contraseña incorrectos.');
      return;
    }

    // Guardar estado de sesión
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('email', email);

    // Notificación de inicio de sesión exitoso
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('¡Inicio de sesión exitoso! Bienvenido, ${email.split('@')[0]}'),
        duration: Duration(seconds: 3),
      ),
    );

    // Redirigir a la página de inicio
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );

  } catch (e) {
    _showError(context, 'Ocurrió un error durante el inicio de sesión: $e');
  } finally {
    setState(() {
      _isLoading = false; // Oculta el indicador de carga
    });
  }
}

  // Método _showError
  void _showError(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Iniciar sesión',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible, // Contraseña oculta o visible
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible; // Cambiar visibilidad
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            _isLoading
                ? Center(child: CircularProgressIndicator()) // Indicador de carga
                : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _login,
                      child: const Text('Iniciar sesión'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.blueAccent, // Color azul en el botón
                        textStyle: const TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Bordes redondeados
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

// Formulario de búsqueda
class SearchForm extends StatefulWidget {
  const SearchForm({Key? key}) : super(key: key);

  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final TextEditingController _fechaInicioController = TextEditingController();
  final TextEditingController _fechaFinController = TextEditingController();
  String? _origen;
  String? _destino;
  String? _numeroPersonas;

  final List<String> destinos = [
    'Lima', 'Nueva York', 'Londres', 'Tokio', 'París', 'Bogotá', 'Roma', 'Sídney', 'Miami', 'Madrid'
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Encuentra tu destino soñado',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Origen',
                border: OutlineInputBorder(),
              ),
              items: destinos.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _origen = value;
                });
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Destino',
                border: OutlineInputBorder(),
              ),
              items: destinos.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _destino = value;
                });
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Número de personas',
                border: OutlineInputBorder(),
              ),
              items: ['1', '2', '3', '4', '5'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _numeroPersonas = value;
                });
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _fechaInicioController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Fecha de inicio',
                      border: OutlineInputBorder(),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        _fechaInicioController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _fechaFinController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Fecha de fin',
                      border: OutlineInputBorder(),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        _fechaFinController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_origen != null && _destino != null && _numeroPersonas != null) {
                    Navigator.pushNamed(context, '/search-results', arguments: {
                      'origen': _origen!,
                      'destino': _destino!,
                      'numeroPersonas': _numeroPersonas!,
                      'fechaInicio': _fechaInicioController.text,
                      'fechaFin': _fechaFinController.text,
                    });
                  } else {
                    // Mostrar error si faltan campos
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Por favor, completa todos los campos.'),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                },
                child: const Text('Buscar'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Página de resultados de búsqueda
class SearchResultsPage extends StatelessWidget {
  const SearchResultsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados de búsqueda'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Origen: ${args['origen']}'),
            Text('Destino: ${args['destino']}'),
            Text('Número de personas: ${args['numeroPersonas']}'),
            Text('Fecha de inicio: ${args['fechaInicio']}'),
            Text('Fecha de fin: ${args['fechaFin']}'),
            const SizedBox(height: 20),
            const Text('Opciones de viaje:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            // Opciones de vuelo simuladas
            FlightOption(price: 500, company: 'Fly international', onSelected: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PassengerInfoPage()));
            }),
            FlightOption(price: 450, company: 'Viva', onSelected: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PassengerInfoPage()));
            }),
            FlightOption(price: 600, company: 'Avianca', onSelected: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PassengerInfoPage()));
            }),
          ],
        ),
      ),
    );
  }
}

class FlightOption extends StatelessWidget {
  final int price;
  final String company;
  final VoidCallback onSelected;

  const FlightOption({Key? key, required this.price, required this.company, required this.onSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected, // Llama a la función onSelected cuando se toca
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(company),
              Text('\$$price'),
            ],
          ),
        ),
      ),
    );
  }
}

// Definición de DestinationCard
class DestinationCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const DestinationCard({
    Key? key,
    required this.title,
    required this.description,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Sombra original
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DestinationDetailPage(
                          title: title,
                          description: description,
                          imagePath: imagePath,
                        ),
                      ),
                    );
                  },
                  child: const Text('Ver detalles'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DestinationDetailPage extends StatefulWidget {
  final String title;
  final String description;
  final String imagePath;

  const DestinationDetailPage({
    Key? key,
    required this.title,
    required this.description,
    required this.imagePath,
  }) : super(key: key);

  @override
  _DestinationDetailPageState createState() => _DestinationDetailPageState();
}

class _DestinationDetailPageState extends State<DestinationDetailPage> {
  final TextEditingController _opinionController = TextEditingController();
  final List<Map<String, String>> _opinions = []; // Lista para almacenar las opiniones
  final List<String> _photos = []; // Lista para almacenar las fotos

  void _addOpinion() {
    if (_opinionController.text.isNotEmpty) {
      setState(() {
        _opinions.add({
          'user': 'Usuario ${_opinions.length + 1}', // Placeholder para el nombre del usuario
          'opinion': _opinionController.text,
        });
        _opinionController.clear(); // Limpiar el campo de texto
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Opinión añadida')),
      );
    }
  }

  void _uploadPhoto() {
    // Aquí podrías implementar la funcionalidad para subir fotos
    // Actualmente, se agrega una imagen de ejemplo a la lista
    setState(() {
      _photos.add('assets/images/sample_photo.png'); // Cambiar por la lógica de selección de foto
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Foto subida exitosamente')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                widget.imagePath,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),
              Text(
                widget.description,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              const Text(
                'Opiniones de los viajeros:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // Listar las opiniones
              OpinionSection(opinions: _opinions),
              const SizedBox(height: 16),
              const Text(
                'Deja tu opinión:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _opinionController,
                decoration: InputDecoration(
                  labelText: 'Escribe tu opinión aquí...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _addOpinion,
                child: const Text('Enviar'),
              ),
              const SizedBox(height: 16),
              const Text(
                'Comparte tus fotos:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _uploadPhoto,
                child: const Text('Subir Foto'),
              ),
              const SizedBox(height: 16),
              const Text(
                'Fotos compartidas:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // Mostrar las fotos compartidas
              PhotoSection(photos: _photos),
            ],
          ),
        ),
      ),
    );
  }
}

// Sección para mostrar las opiniones
class OpinionSection extends StatelessWidget {
  final List<Map<String, String>> opinions;

  const OpinionSection({Key? key, required this.opinions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: opinions.map((opinion) {
        return OpinionCard(
          opinion: opinion['opinion']!,
          user: opinion['user']!,
        );
      }).toList(),
    );
  }
}

// Tarjeta para mostrar una opinión
class OpinionCard extends StatelessWidget {
  final String opinion;
  final String user;

  const OpinionCard({Key? key, required this.opinion, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(opinion),
          ],
        ),
      ),
    );
  }
}

// Sección para mostrar fotos
class PhotoSection extends StatelessWidget {
  final List<String> photos;

  const PhotoSection({Key? key, required this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: photos.map((photo) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Image.asset(
            photo,
            fit: BoxFit.cover,
            height: 100,
            width: double.infinity,
          ),
        );
      }).toList(),
    );
  }
}
