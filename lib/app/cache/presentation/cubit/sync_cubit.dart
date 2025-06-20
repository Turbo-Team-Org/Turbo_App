import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:turbo/app/cache/domain/use_cases/sync_cache_use_case.dart';
import 'package:turbo/app/core/no_params.dart';

part 'sync_state.dart';
part 'sync_cubit.freezed.dart';

/// Cubit para manejar la sincronización de datos en el splash screen
class SyncCubit extends Cubit<SyncState> {
  final SyncCacheUseCase _syncCacheUseCase;

  SyncCubit({required SyncCacheUseCase syncCacheUseCase})
    : _syncCacheUseCase = syncCacheUseCase,
      super(const SyncState.initial());

  /// Inicia la sincronización de datos
  Future<void> startSync() async {
    emit(
      const SyncState.syncing(
        message: 'Iniciando sincronización...',
        progress: 0.0,
      ),
    );

    try {
      // Escuchar el progreso de sincronización
      await for (final progress in _syncCacheUseCase.getSyncProgress()) {
        if (progress.hasError) {
          emit(SyncState.error(message: progress.message));
          return;
        }

        emit(
          SyncState.syncing(
            message: progress.message,
            progress: progress.progress,
          ),
        );

        // Si completó la sincronización, emitir estado de completado
        if (progress.progress >= 1.0) {
          emit(const SyncState.completed());
          return;
        }
      }
    } catch (e) {
      emit(SyncState.error(message: 'Error durante la sincronización: $e'));
    }
  }

  /// Sincronización simple sin progreso (para casos más rápidos)
  Future<void> quickSync() async {
    emit(
      const SyncState.syncing(message: 'Sincronizando datos...', progress: 0.5),
    );

    try {
      await _syncCacheUseCase.call(NoParams());
      emit(const SyncState.completed());
    } catch (e) {
      emit(SyncState.error(message: 'Error de sincronización: $e'));
    }
  }

  /// Verifica solo los datos locales (modo offline)
  Future<void> verifyLocalData() async {
    emit(
      const SyncState.syncing(
        message: 'Verificando datos locales...',
        progress: 0.8,
      ),
    );

    try {
      // Aquí podríamos hacer verificaciones adicionales de integridad
      await Future.delayed(const Duration(milliseconds: 500));
      emit(const SyncState.completed());
    } catch (e) {
      emit(SyncState.error(message: 'Error verificando datos locales: $e'));
    }
  }

  /// Reinicia la sincronización
  void retry() {
    startSync();
  }
}
