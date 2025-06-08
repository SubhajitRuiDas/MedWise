import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:med_tech_app/utils/gemini_api_service.dart';
import 'package:meta/meta.dart';

part 'prescription_process_event.dart';
part 'prescription_process_state.dart';

class PrescriptionProcessBloc extends Bloc<PrescriptionProcessEvent, PrescriptionProcessState> {
  PrescriptionProcessBloc() : super(PrescriptionProcessInitial()) {
    on<PrescriptionProcessEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<PrescriptionProcessClicked>(_onClickedPrescriptionProcess);
  }

  Future<void> _onClickedPrescriptionProcess(PrescriptionProcessClicked event, Emitter<PrescriptionProcessState> emit) async{
    emit(PrescriptionProcessLoading());

    try{
      final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
      final RecognizedText recognizedText = await textRecognizer.processImage(InputImage.fromFile(event.imageFile));
      await textRecognizer.close();
      
      final extractedText = recognizedText.text;
      if(extractedText.isEmpty){
        emit(PrescriptionProcessError(errorText: "No text found from the image or any issue occured"));
        return;
      }

      final prompt = "$extractedText this is written in my prescription which is prescribed by my doctor. Which medicines are written? Mention timings, disease if any, and give brief analysis.";
      final aiGeneratedResponse = await GeminiApiService.askGeminiAI(prompt);

      emit(PrescriptionProcessSuccessful(aiGeneratedResponse: aiGeneratedResponse));
    } catch(e){
      emit(PrescriptionProcessError(errorText: "Something went wrong while AI generating response, please try again later..."));
    }
  }
}
