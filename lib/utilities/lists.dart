/* Crediting Google Gemini 3 for help with this code! */
import 'dart:collection';

sealed class ListDifference<T> {
  final int at;

  ListDifference({required this.at});
}

class Insert<T> extends ListDifference<T> {
  final T value;

  Insert({required this.value, required super.at});
}

class Remove<T> extends ListDifference<T> {
  Remove({required super.at});
}

bool equalsEquals(dynamic a, dynamic b) => a == b;

/// LCS stands for longest common subsequence.
/// The general idea of this algorithm is that
/// If the current element of the source is the same as the target, then it must be in the longest common subsequence!
/// Otherwise, snip one element off of the source and recurse and
/// Snip one element off the target and recurse
int _findLcsLength<T>(
  int sourceStart,
  int targetStart,
  List<T> source,
  List<T> target,
  List<List<int>> cache, {
  bool Function(T, T) isEqual = equalsEquals,
}) {
  if (sourceStart >= source.length || targetStart >= target.length) {
    return 0;
  }

  if (cache[sourceStart][targetStart] != -1) {
    return cache[sourceStart][targetStart];
  }

  final currentSource = source[sourceStart];
  final remainingSourceStart = sourceStart + 1;

  final currentTarget = target[targetStart];
  final remainingTargetStart = targetStart + 1;

  if (isEqual(currentSource, currentTarget)) {
    final result =
        1 +
        _findLcsLength(
          remainingSourceStart,
          remainingTargetStart,
          source,
          target,
          cache,
          isEqual: isEqual,
        );
    cache[sourceStart][targetStart] = result;
    return result;
  }

  final snippedSourceLength = _findLcsLength(
    remainingSourceStart,
    targetStart,
    source,
    target,
    cache,
    isEqual: isEqual,
  );

  final snippedTargetLength = _findLcsLength(
    sourceStart,
    remainingTargetStart,
    source,
    target,
    cache,
    isEqual: isEqual,
  );

  final result = ((snippedSourceLength > snippedTargetLength)
      ? snippedSourceLength
      : snippedTargetLength);

  cache[sourceStart][targetStart] = result;

  return result;
}

List<List<int>> lcsCache<T>(
  List<T> source,
  List<T> target, {
  bool Function(T, T) isEqual = equalsEquals,
}) {
  List<List<int>> cache = List.generate(
    source.length,
    (_) => List.filled(target.length, -1),
  );

  /// The longest common subsequence length will be at 0, 0!
  _findLcsLength(0, 0, source, target, cache, isEqual: isEqual);

  return cache;
}

/// Whenever you calculate the differences between two lists, you also always get their LCS!
/// Instead of hiding that extra work, this function chooses to return that too.
///
/// IMPORTANT: Make sure you use this function with types that can be compared with [==]!
/// If you're trying to compare a type that can't be compared with [==], just wrap it in an extension type or something.
(Iterable<ListDifference<T>>, List<T>) differencesAndLCS<T>(
  List<T> source,
  List<T> target, {
  bool Function(T, T) isEqual = equalsEquals,
}) {
  final sourceLength = source.length;
  final targetLength = target.length;

  /// Why am I not returning the [cache] too?
  /// Well, I think that this function turns the LCS cache into its most useful forms,
  /// so I don't need it anymore!
  final cache = lcsCache(source, target, isEqual: isEqual);

  /// We use a [DoubleLinkedQueue] here so that each [ListDifference] can be added in reverse order;
  /// we do that so that the differences can be applied in order without recalculating indexes!
  final diffs = DoubleLinkedQueue<ListDifference<T>>();
  final lcs = <T>[];
  var sourceIndex = 0;
  var targetIndex = 0;

  while (sourceIndex < sourceLength && targetIndex < targetLength) {
    if (isEqual(source[sourceIndex], target[targetIndex])) {
      lcs.add(source[sourceIndex]);

      sourceIndex++;
      targetIndex++;
      continue;
    }

    final nextSourceIndex = sourceIndex + 1;
    final snippedSourceLength = ((nextSourceIndex < sourceLength)
        ? cache[nextSourceIndex][targetIndex]
        : 0);

    final nextTargetIndex = targetIndex + 1;
    final snippedTargetLength = ((nextTargetIndex < targetLength)
        ? cache[sourceIndex][nextTargetIndex]
        : 0);

    if (snippedSourceLength >= snippedTargetLength) {
      diffs.addFirst(Remove(at: sourceIndex));
      sourceIndex++;
    } else {
      diffs.addFirst(Insert(at: sourceIndex, value: target[targetIndex]));
      targetIndex++;
    }
  }

  while (sourceIndex < sourceLength) {
    diffs.addFirst(Remove(at: sourceIndex));
    sourceIndex++;
  }

  while (targetIndex < targetLength) {
    diffs.addFirst(Insert(at: sourceIndex, value: target[targetIndex]));
    targetIndex++;
  }

  return (diffs, lcs);
}
