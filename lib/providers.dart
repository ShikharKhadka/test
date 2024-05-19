// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:riverpod/riverpod.dart';

import 'package:go_routering/post_api.dart';
import 'package:go_routering/post_model.dart';

final postProvider = StateProvider<List<PostModel>>((ref) {
  // print(ref.controller.state.length);
  return [];
});

final futurePostProvider =
    FutureProvider.autoDispose<List<PostModel>>((ref) async {
  final List<PostModel> postModel = await PostApi().getPost();
  if (postModel.isNotEmpty) {
    ref.read(postProvider.notifier).state = postModel;
    return postModel;
  }
  return [];
});

class Count {
  int count;
  Count({
    required this.count,
  });

  Count copyWith({
    int? count,
  }) {
    return Count(
      count: count ?? this.count,
    );
  }
}

class Edit {
  bool edit;
  Edit({
    this.edit = false,
  });

  Edit copyWith({
    bool edit = false,
  }) {
    return Edit(
      edit: edit,
    );
  }
}

class CountNotifier extends StateNotifier<Count> {
  CountNotifier() : super(Count(count: 0));
  void increment() {
    state = state.copyWith(count: state.count + 1);
  }
}

final myStateProvider = StateNotifierProvider<CountNotifier, Count>(
  (ref) => CountNotifier(),
);

class EditNotifier extends StateNotifier<Edit> {
  EditNotifier() : super(Edit());
  void increment() {
    state = state.copyWith(edit: !state.edit);
  }
}

final myStateProvider1 = StateNotifierProvider<EditNotifier, Edit>(
  (ref) => EditNotifier(),
);
final initialStateProvider = Provider<Count>((ref) {
  // Logic to determine initial state or retrieve data asynchronously
  return Count(count: 10); // Example initial state
});

class MyNotifier extends AsyncNotifier<List<PostModel>> {
  @override
  Future<List<PostModel>> build() async {
    return PostApi().getPost();
  }
}

final myStateProvider2 =
    AsyncNotifierProvider<MyNotifier, List<PostModel>>(MyNotifier.new);
