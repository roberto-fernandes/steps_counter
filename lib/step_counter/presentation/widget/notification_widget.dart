import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_counter/core/data/data_status.dart';
import 'package:steps_counter/core/utils/constants.dart';
import 'package:steps_counter/core/utils/notification_helper.dart';
import 'package:steps_counter/step_counter/bloc/settings/settings_counter_bloc.dart';
import 'package:steps_counter/step_counter/bloc/settings/settings_event.dart';
import 'package:steps_counter/step_counter/bloc/settings/settings_state.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
      listenWhen: (previousState, state) {
        if (previousState.status == DataStatus.initial) {
          return false;
        }
        final notificationStatusChanged =
            previousState.notificationStatus != state.notificationStatus;
        final permissionNotGranted = state.status == DataStatus.failure &&
            state.error == NotificationsHelper.notificationPermissionNotGranted;
        return notificationStatusChanged || permissionNotGranted;
      },
      listener: (context, state) {
        if (state.status == DataStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            _NotificationSnackBar(
              backgroundColor: Colors.red,
              message: 'Permissions not granted',
            ),
          );
        } else if (state.status == DataStatus.success &&
            state.notificationStatus) {
          ScaffoldMessenger.of(context).showSnackBar(
            _NotificationSnackBar(
              backgroundColor: Colors.green,
              message: 'Notifications on',
            ),
          );
        } else if (state.status == DataStatus.success &&
            !state.notificationStatus) {
          ScaffoldMessenger.of(context).showSnackBar(
            _NotificationSnackBar(
              backgroundColor: Colors.red,
              message: 'Notifications off',
            ),
          );
        }
      },
      builder: (context, state) {
        return InkWell(
          onTap: () {
            context.read<SettingsBloc>().add(NotificationTogged());
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              state.notificationStatus
                  ? Icons.notifications_outlined
                  : Icons.notifications_off_outlined,
            ),
          ),
        );
      },
    );
  }
}

class _NotificationSnackBar extends SnackBar {
  _NotificationSnackBar({
    required Color backgroundColor,
    required String message,
    Key? key,
  }) : super(
          backgroundColor: backgroundColor,
          content: Text(message),
          duration: const Duration(
            milliseconds: Defaults.snackBarDurationMilliseconds,
          ),
          key: key,
        );
}
