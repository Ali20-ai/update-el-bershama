import 'package:el_bershama/core/data_Source/data_source.dart';
import 'package:el_bershama/features/home/cubit/state_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicineCubit extends Cubit<MedicineStates> {
  final FirebaseDataSource firebaseDataSource=FirebaseDataSource();

  MedicineCubit(): super(MedicineInitialState());

  Future<void> loadMedicines() async {
    emit(LoadingMedicinesStates());
    try {
      final medicines = await firebaseDataSource.getMedicines();
      emit(LoadMedicinesSuccessStates(medicines));
    } catch (e) {
      emit(LoadMedicinesErrorStates(e.toString()));
    }
  }
}