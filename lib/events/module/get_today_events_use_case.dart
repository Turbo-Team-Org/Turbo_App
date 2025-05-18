import 'package:core/core.dart';
import 'package:turbo/app/core/no_params.dart';
import 'package:turbo/app/core/use_case.dart';

class GetTodayEventsUseCase implements UseCase<Future<List<Event>>, NoParams> {
  final EventRepository eventRepository;

  GetTodayEventsUseCase({required this.eventRepository});

  @override
  Future<List<Event>> call(NoParams params) async {
    return await eventRepository.getTodayEvents();
  }
}
