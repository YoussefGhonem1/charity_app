import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsState {
  final bool notificationsEnabled;
  final bool donateAsAnonymous;

  const SettingsState({
    required this.notificationsEnabled,
    required this.donateAsAnonymous,
  });

  SettingsState copyWith({bool? notificationsEnabled, bool? donateAsAnonymous}) {
    return SettingsState(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      donateAsAnonymous: donateAsAnonymous ?? this.donateAsAnonymous,
    );
  }
}

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState(notificationsEnabled: true, donateAsAnonymous: false));

  Future<void> load() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final data = doc.data() ?? {};
    emit(SettingsState(
      notificationsEnabled: (data['notificationsEnabled'] as bool?) ?? true,
      donateAsAnonymous: (data['donateAsAnonymous'] as bool?) ?? false,
    ));
  }

  Future<void> setNotifications(bool enabled) async {
    emit(state.copyWith(notificationsEnabled: enabled));
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      await FirebaseFirestore.instance.collection('users').doc(uid).set(
        {'notificationsEnabled': enabled},
        SetOptions(merge: true),
      );
    }
  }

  Future<void> setDonateAsAnonymous(bool enabled) async {
    emit(state.copyWith(donateAsAnonymous: enabled));
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      await FirebaseFirestore.instance.collection('users').doc(uid).set(
        {'donateAsAnonymous': enabled},
        SetOptions(merge: true),
      );
    }
  }
}


