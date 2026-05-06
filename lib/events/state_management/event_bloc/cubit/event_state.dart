part of 'event_cubit.dart';

@freezed
sealed class EventState with _$EventState {
  const factory EventState.initial() = EventInitial;
  const factory EventState.loading() = EventLoading;
  const factory EventState.loaded({required List<Event> events}) = EventLoaded;
  const factory EventState.error(String message) = EventError;
  const factory EventState.todayEventsLoaded({required List<Event> events}) =
      TodayEventsLoaded;
}
