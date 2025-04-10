import 'package:turbo/app/core/no_params.dart';
import 'package:turbo/app/core/use_case.dart';
import 'package:turbo/events/event_repository/event_repository.dart';
import 'package:turbo/events/event_repository/models/event.dart';

class GetTodayEventsUseCase implements UseCase<Future<List<Event>>, NoParams> {
  final EventRepository eventRepository;

  GetTodayEventsUseCase({required this.eventRepository});

  @override
  Future<List<Event>> call(NoParams params) async {
    return await eventRepository.getTodayEvents();
  }
}
