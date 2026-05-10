import 'package:el_bershama/features/models/personal/models.dart';

abstract class MedicineStates {}

class MedicineInitialState extends MedicineStates {}

class LoadingMedicinesStates extends MedicineStates {}

class LoadMedicinesSuccessStates extends MedicineStates {
  final List<Medicine> medicines;

  LoadMedicinesSuccessStates(this.medicines);
}

class LoadMedicinesErrorStates extends MedicineStates {
  final String error;

  LoadMedicinesErrorStates(this.error);
}