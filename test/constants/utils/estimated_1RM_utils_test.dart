import 'package:flutter_test/flutter_test.dart';
import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/constants/utils/estimated_1RM_utils.dart';

// TODO: add more tests, cba agr

class MockSet {
  final bool isWarmUp;
  final double? weight;
  final int? reps;

  MockSet({required this.isWarmUp, this.weight, this.reps});
}

void main() {
  group('showComparisonSetEstimated1RM', () {
    test('returns false for warm-up set', () {
      final set = MockSet(isWarmUp: true, weight: 100, reps: 5);

      expect(
          Estimated1RMUtils.showComparisonSetEstimated1RM(
              set, SetType.current, false),
          false);
    });

    test('returns false for comparison set type', () {
      final set = MockSet(isWarmUp: false, weight: 100, reps: 5);
      expect(
          Estimated1RMUtils.showComparisonSetEstimated1RM(
              set, SetType.comparison, false),
          false);
    });

    test('returns false when nullComparisonSet is true', () {
      final set = MockSet(isWarmUp: false, weight: 100, reps: 5);
      expect(
          Estimated1RMUtils.showComparisonSetEstimated1RM(
              set, SetType.current, true),
          false);
    });

    test('returns false when weight and reps are both provided', () {
      final set = MockSet(isWarmUp: false, weight: 100, reps: 5);
      expect(
          Estimated1RMUtils.showComparisonSetEstimated1RM(
              set, SetType.current, false),
          false);
    });

    test('returns true when only reps are provided', () {
      final set = MockSet(isWarmUp: false, weight: null, reps: 5);
      expect(
          Estimated1RMUtils.showComparisonSetEstimated1RM(
              set, SetType.current, false),
          true);
    });

    test('returns true when only weight is provided', () {
      final set = MockSet(isWarmUp: false, weight: 100, reps: null);
      expect(
          Estimated1RMUtils.showComparisonSetEstimated1RM(
              set, SetType.current, false),
          true);
    });
  });
  group('showEstimated1RM', () {
    test('returns false for warm-up set', () {
      final set = MockSet(isWarmUp: true, weight: 100, reps: 5);
      expect(Estimated1RMUtils.showEstimated1RM(set), false);
    });

    test('returns false when weight is null', () {
      final set = MockSet(isWarmUp: false, weight: null, reps: 5);
      expect(Estimated1RMUtils.showEstimated1RM(set), false);
    });

    test('returns false when reps are null', () {
      final set = MockSet(isWarmUp: false, weight: 100, reps: null);
      expect(Estimated1RMUtils.showEstimated1RM(set), false);
    });

    test('returns false when weight is 0', () {
      final set = MockSet(isWarmUp: false, weight: 0, reps: 5);
      expect(Estimated1RMUtils.showEstimated1RM(set), false);
    });

    test(
        'returns true when both weight and reps are provided and weight is nonzero',
        () {
      final set = MockSet(isWarmUp: false, weight: 100, reps: 5);
      expect(Estimated1RMUtils.showEstimated1RM(set), true);
    });
  });

  // Calc 1RM
  group('calculateEstimated1RM', () {
    test('testing a effective 1RM for reps < 5', () {
      var testWeightAndRepRanges = [
        {'weight': 100, 'reps': 1, 'expected': 100},
        {'weight': 50, 'reps': 1, 'expected': 50},
        {'weight': 33, 'reps': 1, 'expected': 33},
        {'weight': 1.5, 'reps': 1, 'expected': 1.5},
        {'weight': 100, 'reps': 2, 'expected': 102.9},
        {'weight': 100, 'reps': 3, 'expected': 105.9},
        {'weight': 100, 'reps': 4, 'expected': 109.1},
        {'weight': 55, 'reps': 2, 'expected': 56.6},
        {'weight': 55, 'reps': 3, 'expected': 58.2},
        {'weight': 55, 'reps': 4, 'expected': 60},
      ];

      for (var test in testWeightAndRepRanges) {
        double result = Estimated1RMUtils.calculateEstimated1RM(
            test['weight']!.toDouble(), test['reps']!.toInt())!;
        double roundedResult = double.parse(result.toStringAsFixed(1));

        expect(roundedResult, test['expected']!.toDouble());
      }
    });
    // This test is tricky to do as we use a different formula
    // for reps > 5 so we have no data to test it against..
    // test('testing a effective 1RM for 5 <= reps < 10', () {
    //   var testWeightAndRepRanges = [
    //     {'weight': 100, 'reps': 5, 'expected': 112.5},
    //     {'weight': 100, 'reps': 6, 'expected': 116.1},
    //     {'weight': 100, 'reps': 7, 'expected': 120},
    //     {'weight': 100, 'reps': 8, 'expected': 124.2},
    //     {'weight': 100, 'reps': 9, 'expected': 128.8},
    //
    //     {'weight': 55, 'reps': 5, 'expected': 61.9},
    //     {'weight': 55, 'reps': 6, 'expected': 63.9},
    //     {'weight': 55, 'reps': 7, 'expected': 66},
    //     {'weight': 55, 'reps': 8, 'expected': 68.3},
    //     {'weight': 55, 'reps': 9, 'expected': 70.8},
    //   ];
    //
    //   for (var test in testWeightAndRepRanges) {
    //     double result = Estimated1RMUtils.calculateEstimated1RM(test['weight']!.toDouble(), test['reps']!.toInt())!;
    //     double roundedResult = double.parse(result.toStringAsFixed(1));
    //
    //     expect(roundedResult, test['expected']!.toDouble());
    //   }
    // });
    test('return null for reps == null || weight == null', () {
      expect(Estimated1RMUtils.calculateEstimated1RM(1, null), isNull);
      expect(Estimated1RMUtils.calculateEstimated1RM(null, 1), isNull);
      expect(Estimated1RMUtils.calculateEstimated1RM(null, null), isNull);
    });
  });
  group('returnEstimated1RM', () {
    test('returns correctly formatted 1RM', () {});
  });

  // Calc weight from 1RM
  group('calculateWeightFrom1RM', () {
    test('testing calculated weight from 1RM with reps < 5', () {
      var test1RMAndRepRanges = [
        {'expected': 100, 'reps': 1, '1RM': 100},
        {'expected': 50, 'reps': 1, '1RM': 50},
        {'expected': 33, 'reps': 1, '1RM': 33},
        {'expected': 1.5, 'reps': 1, '1RM': 1.5},
        {'expected': 100, 'reps': 2, '1RM': 102.9},
        {'expected': 100, 'reps': 3, '1RM': 105.9},
        {'expected': 100, 'reps': 4, '1RM': 109.1},
        {'expected': 55, 'reps': 2, '1RM': 56.6},
        {'expected': 55, 'reps': 3, '1RM': 58.2},
        {'expected': 55, 'reps': 4, '1RM': 60},
      ];

      for (var test in test1RMAndRepRanges) {
        double result = Estimated1RMUtils.calculateWeightFrom1RM(
            test['reps']!.toInt(), test['1RM']!.toDouble());
        double roundedResult = double.parse(result.toStringAsFixed(1));

        expect(roundedResult, test['expected']!.toDouble());
      }
    });
  });
  group('returnCalculatedWeightFrom1RM', () {});

  // Calc reps from 1RM
  group('calculateRepsFrom1RM', () {
    test('testing calculated reps from 1RM with weight < 5', () {
      var test1RMAndWeightRanges = [
        {'weight': 100, 'expected': 1, '1RM': 100},
        {'weight': 50, 'expected': 1, '1RM': 50},
        {'weight': 33, 'expected': 1, '1RM': 33},
        {'weight': 1.5, 'expected': 1, '1RM': 1.5},
        {'weight': 100, 'expected': 2, '1RM': 102.9},
        {'weight': 100, 'expected': 3, '1RM': 105.9},
        {'weight': 100, 'expected': 4, '1RM': 109.1},
        {'weight': 55, 'expected': 2, '1RM': 56.6},
        {'weight': 55, 'expected': 3, '1RM': 58.2},
        {'weight': 55, 'expected': 4, '1RM': 60},
      ];

      for (var test in test1RMAndWeightRanges) {
        double result = Estimated1RMUtils.calculateRepsFrom1RM(
            test['weight']!.toDouble(), test['1RM']!.toDouble());
        double roundedResult = double.parse(result.toStringAsFixed(1));

        expect(roundedResult, test['expected']!.toDouble());
      }
    });
  });
  group('returnCalculatedRepsFrom1RM', () {});
}
