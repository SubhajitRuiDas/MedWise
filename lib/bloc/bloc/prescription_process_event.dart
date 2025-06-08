part of 'prescription_process_bloc.dart';

@immutable
sealed class PrescriptionProcessEvent {}

class PrescriptionProcessClicked extends PrescriptionProcessEvent{
  final File imageFile;

  PrescriptionProcessClicked({required this.imageFile});
}
