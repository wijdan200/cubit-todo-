import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_bloc_app/app_bloc_observer.dart';
import 'bloc/task_bloc.dart';
import 'bloc/counterb.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'pages/task_page.dart';
// import 'cubit/counter_cubit.dart';
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   HydratedBloc.storage = await HydratedStorage.build(
//     storageDirectory: kIsWeb
//         ? HydratedStorageDirectory.web
//         : HydratedStorageDirectory((await getTemporaryDirectory()).path),
//   );
Future<void> main() async {
   Bloc.observer = AppBlocObserver();
    WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb ? HydratedStorageDirectory.web : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );  
 
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => TaskBloc(),
          ),
          BlocProvider(
            create: (_) => CounterBloc(),
          ),
        ],
        child: TaskPage(title: 'To Do with Bloc'),
      ),
    ),
  );
}




