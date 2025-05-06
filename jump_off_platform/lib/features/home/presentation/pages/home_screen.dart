// home screen contents
import '../../../core/constants/image_constants.dart';
import '../../../core/constants/string_constants.dart' as string_constants;
import '../../../core/utils/helpers/app_state_notifier.dart';
import '../../../shared/widgets/cache_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
// TODO: Verify AuthenticationBloc and related states/events imports after auth feature is processed
import '../../authentication/presentation/bloc/authentication_bloc.dart'; // Placeholder path

class HomeScreen extends StatelessWidget {
  // ignore: close_sinks
  // TODO: Resolve AuthenticationBlocController() or replace with DI
  // final AuthenticationBloc authenticationBloc =
  //     AuthenticationBlocController().authenticationBloc;

  @override
  Widget build(BuildContext context) {
    // TODO: This needs a valid authenticationBloc instance via DI
    final AuthenticationBloc authenticationBloc = context.watch<AuthenticationBloc>(); // Example with Provider/BlocProvider
    // If using GetIt: final AuthenticationBloc authenticationBloc = serviceLocator<AuthenticationBloc>();
    
    authenticationBloc.add(GetUserData()); // Ensure GetUserData event is defined
    return WillPopScope(
        onWillPop: () async => false,
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            bloc: authenticationBloc,
            builder: (BuildContext context, AuthenticationState state) {
              // Ensure SetUserData state and its properties are correctly defined and imported
              if (state is SetUserData) {
                return Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: Text(
                      string_constants.app_bar_title,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    actions: [
                      IconButton(
                          icon: Icon(Icons.logout),
                          onPressed: () {
                            authenticationBloc.add(UserLogOut()); // Ensure UserLogOut event is defined
                          }),
                    ],
                  ),
                  body: Center(
                    child: Text('/home'),
                  ),
                  drawer: Drawer(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        DrawerHeader(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white),
                                    child: CachedImage(
                                      imageUrl:
                                          state.currentUserData.data.avatar,
                                      fit: BoxFit.fitWidth,
                                      errorWidget: Image.network(
                                        AllImages().kDefaultImage,
                                      ),
                                      width: 80,
                                      height: 80,
                                      placeholder: CircularProgressIndicator(),
                                    ),
                                  ),
                                  Switch(
                                    value:
                                        Provider.of<AppStateNotifier>(context)
                                            .isDarkMode,
                                    onChanged: (value) {
                                      Provider.of<AppStateNotifier>(context,
                                              listen: false)
                                          .updateTheme(value);
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).dividerColor,
                          ),
                        ),
                        ListTile(
                          title: Text(
                              '${state.currentUserData.data.firstName} ${state.currentUserData.data.lastName}',
                              style: Theme.of(context).textTheme.bodyText2),
                        ),
                        ListTile(
                          title: Text(state.currentUserData.data.email,
                              style: Theme.of(context).textTheme.bodyText2),
                        ),
                        ListTile(
                          title: Text(state.currentUserData.ad.company,
                              style: Theme.of(context).textTheme.bodyText2),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }));
  }
} 