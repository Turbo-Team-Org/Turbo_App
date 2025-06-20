part of 'sync_cubit.dart';

@freezed
sealed class SyncState with _$SyncState {
  /// Estado inicial, antes de comenzar la sincronización
  const factory SyncState.initial() = SyncInitial;

  /// Estado de sincronización en progreso
  const factory SyncState.syncing({
    required String message,
    required double progress, // 0.0 a 1.0
  }) = SyncSyncing;

  /// Estado de sincronización completada exitosamente
  const factory SyncState.completed() = SyncCompleted;

  /// Estado de error durante la sincronización
  const factory SyncState.error({required String message}) = SyncError;
}
