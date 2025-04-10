import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:turbo/app/core/no_params.dart';
import 'package:turbo/events/event_repository/models/event.dart';
import 'package:turbo/events/module/get_events_use_case.dart';
import 'package:turbo/events/module/get_today_events_use_case.dart';

part 'event_state.dart';
part 'event_cubit.freezed.dart';

class EventCubit extends Cubit<EventState> {
  final GetEventsUseCase _getEventsUseCase;
  final GetTodayEventsUseCase _getTodayEventsUseCase;

  EventCubit({
    required GetEventsUseCase getEventsUseCase,
    required GetTodayEventsUseCase getTodayEventsUseCase,
  }) : _getEventsUseCase = getEventsUseCase,
       _getTodayEventsUseCase = getTodayEventsUseCase,
       super(const EventState.initial());

  Future<void> getEvents() async {
    emit(const EventState.loading());
    try {
      final events = await _getEventsUseCase(NoParams());
      emit(EventState.loaded(events: events));
    } catch (e) {
      emit(EventState.error(e.toString()));
    }
  }

  Future<void> getTodayEvents() async {
    emit(const EventState.loading());
    try {
      final events = await _getTodayEventsUseCase(NoParams());
      emit(EventState.todayEventsLoaded(events: events));
    } catch (e) {
      emit(EventState.error(e.toString()));
    }
  }
}
