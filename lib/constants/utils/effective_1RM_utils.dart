// Effective 1RM class
import 'package:gym_bro/constants/enums.dart';

class Effective1RMUtils {
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

  static bool showEffective1RM(dynamic set) {
    // we only want to show the Eff 1RM if we have both weight and reps
    if (set.isWarmUp ||
        set.weight == null ||
        set.reps == null ||
        set.weight == 0) {
      return false;
    }
    return true;
  }

  // Calculate Effective 1RM
  static double? calculateEffective1RM(double? weight, int? reps) {
    if (weight == null || reps == null) return null;
    if (reps < 5) {
      // Brzycki Formula
      return weight / (1.0278 - (0.0278 * reps));
    } else {
      // Epley Formula
      return weight * (1 + (0.0333 * reps));
    }
  }

  static String? returnEffective1RM(
      {required double weight, required int reps}) {
    double? calculatedWeight = calculateEffective1RM(weight, reps);

    if (calculatedWeight == null) return null;
    return calculatedWeight.toStringAsFixed(2);
  }

  // Calculate Weight from Effective 1RM
  static double calculateWeightFrom1RM(int reps, double eff1RM) {
    if (reps < 5) {
      // Brzycki Conversion
      return eff1RM * (1.0278 - (0.0278 * reps));
    } else {
      // Epley Conversion
      return eff1RM / (1 + (0.0333 * reps));
    }
  }

  static String? returnCalculatedWeightFrom1RM(int? reps, double? eff1RM) {
    if (reps == null || eff1RM == null) return null;

    double calculatedWeight = calculateWeightFrom1RM(reps, eff1RM);

    return calculatedWeight.toStringAsFixed(2);
  }

  // Calculate Reps from Effective 1RM
  // TODO: needs validation step to decide if ±1 rep is better to display
  // 1 rep under eff might be closer to eff than the returned rep
  static double calculateRepsFrom1RM(double weight, double eff1RM) {
    // GPT CODE:
    // Handle invalid input
    if (weight <= 0 || eff1RM <= 0 || weight > eff1RM) return 0;

    // Calculate using both formulas
    double brzyckiReps = (1.0278 - (eff1RM / weight)) / 0.0278;
    double epleyReps = ((eff1RM / weight) - 1) / 0.0333;

    // Return the appropriate reps based on formulas
    double returnReps =
    weight / eff1RM > 0.8 // Brzycki works better for heavier loads
        ? brzyckiReps
        : epleyReps;

    // validating the calculated reps is closest to eff1RM
    int roundedReps = returnReps.round();
    int lowerReps = returnReps.round() - 1;

    double calculatedEff1RM = calculateEffective1RM(weight, roundedReps)!;
    double oneLessRepEff1RM = calculateEffective1RM(weight, lowerReps)!;

    const double epsilon = 0.01; // Tolerance for floating-point errors

    // Return the reps that give the closest effective 1RM
    return (calculatedEff1RM - eff1RM).abs() <
        (oneLessRepEff1RM - eff1RM).abs() + epsilon
        ? roundedReps.toDouble()
        : lowerReps.toDouble();
  }

  static String? returnCalculatedRepsFrom1RM(double? weight, double? eff1RM) {
    if (weight == null || eff1RM == null) return null;

    double calculatedReps = calculateRepsFrom1RM(weight, eff1RM);
    return calculatedReps.toStringAsFixed(0);
  }
}