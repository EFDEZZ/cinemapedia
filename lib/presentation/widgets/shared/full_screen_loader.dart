import 'package:flutter/material.dart';

  List<String> loadingMesseges = [
    'cargando datos de la aplicación...',
    'cargando las más vistas...',
    'cargando las más populares... ',
    'cargando nuevos estrenos...',
    'cargando mejores calificadas...',
    'cargando metadata...',
    'Esto esta tardando más de lo esperado...',
  ];

  Stream<String> getLoadingMessages(){
    return Stream.periodic(const Duration(seconds: 2), (step){

      return loadingMesseges[step];
    }).take(loadingMesseges.length);
  }

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Espere por favor"),
          const SizedBox(height: 10,),
          const CircularProgressIndicator(strokeWidth: 2,),
          const SizedBox(height: 10,),

            StreamBuilder(
              stream: getLoadingMessages(), 
              builder: (context, snapshot) {
                if(!snapshot.hasData) return const Text("cargando...");
            
                return Text(snapshot.data!);
              },
              ),
        ],
      ),
    );
  }
}