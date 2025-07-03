import 'package:freezed_annotation/freezed_annotation.dart';

part 'multiplication_problem.freezed.dart';
part 'multiplication_problem.g.dart';

@freezed
class MultiplicationProblem with _$MultiplicationProblem {
  const factory MultiplicationProblem({
    required int factor1,
    required int factor2,
    required int answer, // answerはコンストラクタで計算され、直接アクセス可能
  }) = _MultiplicationProblem;

  // カスタムファクトリコンストラクタでanswerを計算し、メインコンストラクタに渡す
  factory MultiplicationProblem.create({
    required int factor1,
    required int factor2,
  }) {
    return MultiplicationProblem(
      factor1: factor1,
      factor2: factor2,
      answer: factor1 * factor2, // ここでanswerを計算して設定
    );
  }

  factory MultiplicationProblem.fromJson(Map<String, dynamic> json) =>
      _$MultiplicationProblemFromJson(json);
}
