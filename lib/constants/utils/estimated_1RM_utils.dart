// Estimated 1RM class
import 'package:gym_bro/constants/enums.dart';

class Estimated1RMUtils {
  static bool showComparison1RM(
      dynamic set, SetType setType, bool nullComparisonSet) {
    if (set.isWarmUp || setType == SetType.comparison || nullComparisonSet) {
      return false;
    }

    // Check for partial inputs
    bool hasPartialInput = (set.weight == null && set.reps != null) ||
        (set.weight != null && set.reps == null);

    return hasPartialInput;
  }

  static bool showEstimated1RM(dynamic set) {
    // we only want to show the Est 1RM if we have both weight and reps
    if (set.isWarmUp ||
        set.weight == null ||
        set.reps == null ||
        set.weight == 0) {
      return false;
    }
    return true;
  }

  // Calculate Estimated 1RM
  static double? calculateEstimated1RM(double? weight, int? reps) {
    if (weight == null || reps == null) return null;
    if (reps < 5) {
      // Brzycki Formula
      return weight / (1.0278 - (0.0278 * reps));
    } else {
      // Epley Formula
      return weight * (1 + (0.0333 * reps));
    }
    return weight / (1.0278 - (0.0278 * reps));
  }

  static String? returnEstimated1RM(
      {required double weight, required int reps}) {
    double? calculatedWeight = calculateEstimated1RM(weight, reps);

    if (calculatedWeight == null) return null;
    return calculatedWeight.toStringAsFixed(2);
  }

  // Calculate Weight from Estimated 1RM
  static double calculateWeightFrom1RM(int reps, double est1RM) {
    if (reps < 5) {
      // Brzycki Conversion
      return est1RM * (1.0278 - (0.0278 * reps));
    } else {
      // Epley Conversion
      return est1RM / (1 + (0.0333 * reps));
    }
  }

  static String? returnCalculatedWeightFrom1RM(int? reps, double? est1RM) {
    if (reps == null || est1RM == null) return null;

    double calculatedWeight = calculateWeightFrom1RM(reps, est1RM);

    return calculatedWeight.toStringAsFixed(2);
  }

  // Calculate Reps from Estimated 1RM
  // TODO: needs validation step to decide if ±1 rep is better to display
  // 1 rep under est might be closer to est than the returned rep
  static double calculateRepsFrom1RM(double weight, double est1RM) {
    // GPT CODE:
    // Handle invalid input
    if (weight <= 0 || est1RM <= 0 || weight > est1RM) return 0;

    // Calculate using both formulas
    double brzyckiReps = (1.0278 - (weight / est1RM)) / 0.0278;
    double epleyReps = ((weight / est1RM) - 1) / 0.0333;

    // Return the appropriate reps based on formulas
    double returnReps = weight / est1RM > 0.8 // Brzycki works better for heavier loads
        ? brzyckiReps
        : epleyReps;

    // validating the calculated reps is closest to est1RM
    int roundedReps = returnReps.round();
    int lowerReps = returnReps.round() - 1;

    double calculatedEff1RM = calculateEstimated1RM(weight, roundedReps)!;
    double oneLessRepEff1RM = calculateEstimated1RM(weight, lowerReps)!;

    const double epsilon = 0.01; // Tolerance for floating-point errors

    // Return the reps that give the closest estimated 1RM
    return (calculatedEff1RM - est1RM).abs() <
        (oneLessRepEff1RM - est1RM).abs() + epsilon
        ? roundedReps.toDouble()
        : lowerReps.toDouble();
  }

  static String? returnCalculatedRepsFrom1RM(double? weight, double? est1RM) {
    if (weight == null || est1RM == null) return null;

    double calculatedReps = calculateRepsFrom1RM(weight, est1RM);
    return calculatedReps.toStringAsFixed(0);
  }
}