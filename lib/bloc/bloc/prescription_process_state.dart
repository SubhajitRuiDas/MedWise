part of 'prescription_process_bloc.dart';

@immutable
sealed class PrescriptionProcessState {}

// basically states are observed in the ui screen
final class PrescriptionProcessInitial extends PrescriptionProcessState {}

final class PrescriptionProcessLoading extends PrescriptionProcessState {}

final class PrescriptionProcessSuccessful extends PrescriptionProcessState {
  final String aiGeneratedResponse;
  PrescriptionProcessSuccessful({required this.aiGeneratedResponse});
}

final class PrescriptionProcessError extends PrescriptionProcessState {
  final String errorText;
  PrescriptionProcessError({required this.errorText});
}
