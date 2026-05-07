import 'package:flutter/material.dart';
import 'package:turbo/app/l10n/l10n.dart';
import 'package:turbo/places/module/params/search_filters_params.dart';

class SearchFiltersSheet extends StatefulWidget {
  const SearchFiltersSheet({
    super.key,
    required this.initialFilters,
    required this.onApply,
    required this.onClear,
  });

  final SearchFiltersParams initialFilters;
  final ValueChanged<SearchFiltersParams> onApply;
  final VoidCallback onClear;

  @override
  State<SearchFiltersSheet> createState() => _SearchFiltersSheetState();
}

class _SearchFiltersSheetState extends State<SearchFiltersSheet> {
  late double _minRating;
  late bool _showOnlyOpenNow;
  late String _sortBy;

  @override
  void initState() {
    super.initState();
    _minRating = widget.initialFilters.minRating;
    _showOnlyOpenNow = widget.initialFilters.showOnlyOpenNow;
    _sortBy = widget.initialFilters.sortBy;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.filterSearchTitle,
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(l10n.filterMinRating),
          Slider(
            value: _minRating,
            min: 0,
            max: 5,
            divisions: 10,
            label: _minRating.toStringAsFixed(1),
            onChanged: (value) => setState(() => _minRating = value),
          ),
          const SizedBox(height: 12),
          Text(l10n.filterOpenNow),
          Switch(
            value: _showOnlyOpenNow,
            onChanged: (value) => setState(() => _showOnlyOpenNow = value),
          ),
          const SizedBox(height: 12),
          Text(l10n.filterSortBy),
          DropdownButton<String>(
            value: _sortBy,
            items: [
              DropdownMenuItem(value: 'distance', child: Text(l10n.filterNearest)),
              DropdownMenuItem(
                value: 'rating',
                child: Text(l10n.filterHighestRated),
              ),
              DropdownMenuItem(
                value: 'price',
                child: Text(l10n.filterLowestPrice),
              ),
            ],
            onChanged: (value) {
              if (value == null) return;
              setState(() => _sortBy = value);
            },
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: widget.onClear,
                  child: Text(l10n.filterClear),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    widget.onApply(
                      SearchFiltersParams(
                        minRating: _minRating,
                        showOnlyOpenNow: _showOnlyOpenNow,
                        sortBy: _sortBy,
                      ),
                    );
                  },
                  child: Text(l10n.commonApply),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
