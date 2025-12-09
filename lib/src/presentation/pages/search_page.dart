import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_typography.dart';
import '../../core/theme/spacing_tokens.dart';
import '../providers/search_provider.dart';
import '../widgets/movie_card.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final _controller = TextEditingController();
  Timer? _debounce;
  String _query = '';

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    // Cancel previous debounce timer
    _debounce?.cancel();

    // Create new debounce timer (300ms delay)
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() => _query = value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final resultsAsync = ref.watch(searchResultsProvider(_query));

    return Padding(
      padding: const EdgeInsets.all(Spacing.pagePadding),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Tìm phim...',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: _onSearchChanged,
          ),
          const SizedBox(height: Spacing.lg),
          Expanded(
            child: resultsAsync.when(
              data: (movies) {
                if (_query.isEmpty) {
                  return Center(
                    child: Text(
                      'Nhập từ khóa để tìm phim',
                      style: AppTypography.bodyMedium,
                    ),
                  );
                }
                if (movies.isEmpty) {
                  return Center(
                    child: Text(
                      'Không tìm thấy',
                      style: AppTypography.bodyMedium,
                    ),
                  );
                }
                return ListView.separated(
                  itemCount: movies.length,
                  separatorBuilder: (_, __) => const SizedBox(height: Spacing.listItemSpacing),
                  itemBuilder: (context, index) {
                    final m = movies[index];
                    return MovieCard(
                      movie: m,
                      onTap: () {
                        // Navigate to movie detail page
                        context.goNamed(
                          'movieDetail',
                          pathParameters: {'id': m.id},
                        );
                      },
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(
                child: Text(
                  'Lỗi tìm kiếm: $e',
                  style: AppTypography.bodyMedium,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

