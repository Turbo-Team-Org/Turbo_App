import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:turbo/app/l10n/l10n.dart';
import 'package:turbo/categories/module/get_places_by_category_use_case.dart';
import 'package:turbo/places/module/get_places_by_location_use_case.dart';
import 'package:turbo/places/module/params/search_filters_params.dart';
import 'package:turbo/places/module/params/search_places_params.dart';
import 'package:turbo/places/module/search_nearby_places_use_case.dart';
import 'package:turbo/places/module/search_places_use_case.dart';
import 'package:turbo/places/presentation/widgets/search_filters_sheet.dart';
import 'package:turbo/places/state_management/place_search_cubit/places_search_cubit.dart';

class MockGetPlacesByCategoryUseCase extends Mock
    implements GetPlacesByCategoryUseCase {}

class MockSearchPlacesUseCase extends Mock implements SearchPlacesUseCase {}

class MockSearchPlacesByVoiceUseCase extends Mock
    implements SearchPlacesByVoiceUseCase {}

class MockGetPlacesByLocationUseCase extends Mock
    implements GetPlacesByLocationUseCase {}

class MockSearchNearbyPlacesUseCase extends Mock
    implements SearchNearbyPlacesUseCase {}

class _FiltersScreenHarness extends StatelessWidget {
  const _FiltersScreenHarness();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              final cubit = context.read<PlacesSearchCubit>();
              final state = cubit.state;
              showModalBottomSheet<void>(
                context: context,
                builder: (context) {
                  return SizedBox(
                    height: 520,
                    child: BlocProvider.value(
                      value: cubit,
                      child: SearchFiltersSheet(
                        initialFilters: SearchFiltersParams(
                          minRating: state.minRating,
                          maxDistance: state.maxDistance,
                          sortBy: state.sortBy,
                          showOnlyOpenNow: state.showOnlyOpenNow,
                        ),
                        onApply: (filters) {
                          cubit.applyFilters(filters);
                          Navigator.of(context).maybePop();
                        },
                        onClear: () {
                          cubit.clearFilters();
                          Navigator.of(context).maybePop();
                        },
                      ),
                    ),
                  );
                },
              );
            },
            child: const Text('Abrir filtros'),
          ),
          const SizedBox(height: 12),
          BlocBuilder<PlacesSearchCubit, PlacesSearchState>(
            builder: (context, state) {
              return Wrap(
                spacing: 8,
                children: [
                  if (state.minRating > 0.0)
                    Chip(
                      label: Text(
                        'Rating ${state.minRating.toStringAsFixed(1)}+',
                      ),
                    ),
                  if (state.showOnlyOpenNow)
                    const Chip(label: Text('Abierto ahora')),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

void main() {
  late PlacesSearchCubit cubit;
  late MockGetPlacesByCategoryUseCase mockGetPlacesByCategoryUseCase;
  late MockSearchPlacesUseCase mockSearchPlacesUseCase;
  late MockSearchPlacesByVoiceUseCase mockSearchPlacesByVoiceUseCase;
  late MockGetPlacesByLocationUseCase mockGetPlacesByLocationUseCase;
  late MockSearchNearbyPlacesUseCase mockSearchNearbyPlacesUseCase;

  setUpAll(() {
    registerFallbackValue(
      SearchNearbyPlacesParams(location: const LatLng(23.1136, -82.3666)),
    );
    registerFallbackValue(
      GetPlacesByLocationParams(location: const LatLng(23.1136, -82.3666)),
    );
    registerFallbackValue(const SearchPlacesParams(query: 'test'));
    registerFallbackValue(
      const GetPlacesByCategoryParams(categoryId: 'test-category'),
    );
  });

  setUp(() {
    mockGetPlacesByCategoryUseCase = MockGetPlacesByCategoryUseCase();
    mockSearchPlacesUseCase = MockSearchPlacesUseCase();
    mockSearchPlacesByVoiceUseCase = MockSearchPlacesByVoiceUseCase();
    mockGetPlacesByLocationUseCase = MockGetPlacesByLocationUseCase();
    mockSearchNearbyPlacesUseCase = MockSearchNearbyPlacesUseCase();

    when(() => mockSearchNearbyPlacesUseCase.call(any()))
        .thenAnswer((_) async => []);
    when(() => mockGetPlacesByLocationUseCase.call(any()))
        .thenAnswer((_) async => []);
    when(() => mockSearchPlacesUseCase.call(any())).thenAnswer((_) async => []);
    when(() => mockGetPlacesByCategoryUseCase.call(any()))
        .thenAnswer((_) async => []);
    when(() => mockSearchPlacesByVoiceUseCase.call(any()))
        .thenAnswer((_) async => []);

    cubit = PlacesSearchCubit(
      getPlacesByCategoryUseCase: mockGetPlacesByCategoryUseCase,
      searchPlacesUseCase: mockSearchPlacesUseCase,
      searchPlacesByVoiceUseCase: mockSearchPlacesByVoiceUseCase,
      getPlacesByLocationUseCase: mockGetPlacesByLocationUseCase,
      searchNearbyPlacesUseCase: mockSearchNearbyPlacesUseCase,
    );
    cubit.initializeSearch(userLocation: const LatLng(23.1136, -82.3666));
  });

  tearDown(() async {
    await cubit.close();
  });

  testWidgets(
    'abre filtros, aplica y muestra chip activo',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('es'),
          home: BlocProvider.value(
            value: cubit,
            child: const _FiltersScreenHarness(),
          ),
        ),
      );

      await tester.tap(find.text('Abrir filtros'));
      await tester.pumpAndSettle();

      expect(find.text('Filtros de búsqueda'), findsOneWidget);

      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Aplicar'));
      await tester.pumpAndSettle();

      expect(find.text('Abierto ahora'), findsOneWidget);
    },
  );
}
