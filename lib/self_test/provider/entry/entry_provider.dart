import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '/self_test/db/database.dart';
import '/self_test/provider/database_provider.dart';
import '/self_test/provider/questionnaire/questionnaire_provider.dart';

part 'entry_provider.freezed.dart';

final entryProvider = StreamProvider.family<HistoryEntry, int>(
  (ref, entryId) {
    return ref.watch(databaseProvider).watchEntry(entryId).map((entry) {
      return HistoryEntry(
        entry: entry,
        result: entry.toResult(),
      );
    });
  },
);

@freezed
class HistoryEntry with _$HistoryEntry {
  const factory HistoryEntry({
    required Entry entry,
    required Result result,
  }) = _HistoryEntry;
}
