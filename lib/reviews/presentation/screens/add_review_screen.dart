import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:core/core.dart';
import 'package:turbo/app/l10n/l10n.dart';
import 'package:turbo/app/utils/app_preferences.dart';
import 'package:turbo/authentication/state_management/auth_cubit/cubit/auth_cubit_cubit.dart';
import 'package:turbo/reviews/state_management/cubit/review_cubit.dart';

import '../widgets/star_rating_widget.dart';

const int kReviewCommentMinLength = 10;

@RoutePage()
class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({
    super.key,
    required this.placeId,
    this.placeName,
    this.editingReviewId,
  });

  final String placeId;
  final String? placeName;
  final String? editingReviewId;

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();
  final _prefs = AppPreferences();
  int _rating = 0;
  bool _submitting = false;
  Review? _editingTemplate;

  bool get _isEditing => widget.editingReviewId != null;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _hydrateEditing());
  }

  void _hydrateEditing() {
    if (!_isEditing || !mounted) return;
    final state = context.read<ReviewCubit>().state;
    if (state is! ReviewLoaded) return;
    try {
      final r = state.reviews.firstWhere((e) => e.id == widget.editingReviewId);
      _editingTemplate = r;
      setState(() {
        _rating = r.rating.round().clamp(1, 5);
        _commentController.text = r.comment;
      });
    } catch (_) {}
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = context.l10n;
    if (!_formKey.currentState!.validate()) return;
    if (_rating < 1 || _rating > 5) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.reviewsSelectRating)));
      return;
    }

    final authState = context.read<AuthCubit>().state;
    if (authState is! Authenticated) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.reviewsAuthRequired)));
      return;
    }

    setState(() => _submitting = true);
    try {
      final cubit = context.read<ReviewCubit>();
      if (_isEditing && _editingTemplate != null) {
        final updated = _editingTemplate!.copyWith(
          comment: _commentController.text.trim(),
          rating: _rating.toDouble(),
          date: DateTime.now(),
        );
        await cubit.updateReview(updated, widget.placeId);
      } else {
        final review = Review(
          id: const Uuid().v4(),
          userId: authState.user.uid,
          userName: _prefs.getUserName() ?? l10n.defaultUserName,
          userAvatar: '',
          comment: _commentController.text.trim(),
          rating: _rating.toDouble(),
          date: DateTime.now(),
        );
        await cubit.addReview(review, widget.placeId);
      }
      if (!mounted) return;
      context.router.maybePop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('${context.l10n.errorGeneric}: $e')));
    } finally {
      if (mounted) {
        setState(() => _submitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final title =
        _isEditing ? l10n.reviewsEditTitle : l10n.reviewsAddTitle;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                l10n.reviewsSelectRating,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              StarRatingWidget(
                value: _rating,
                onChanged: (v) => setState(() => _rating = v),
                iconSize: 36,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _commentController,
                minLines: 4,
                maxLines: 8,
                decoration: InputDecoration(
                  labelText: l10n.reviewsCommentHint,
                  alignLabelWithHint: true,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  final t = value?.trim() ?? '';
                  if (t.length < kReviewCommentMinLength) {
                    return l10n.reviewsCommentMinLength(kReviewCommentMinLength);
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _submitting ? null : _submit,
                child:
                    _submitting
                        ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                        : Text(_isEditing ? l10n.reviewsSave : l10n.reviewsSubmit),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
