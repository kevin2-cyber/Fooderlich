// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../models/models.dart';
import 'widgets.dart';

class FriendPostListView extends StatelessWidget {
  final List<Post> friendPosts;

  const FriendPostListView({
    Key? key,
    required this.friendPosts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Social Chefs ! ', style: Theme.of(context).textTheme.headline1),
          // 5
          const SizedBox(height: 16),
          // Add PostListView here
          ListView.separated(
            // 2
            primary: false,
            // 3
            physics: const NeverScrollableScrollPhysics(),
            // 4
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: friendPosts.length,
            itemBuilder: (context, index) {
              // 5
              final post = friendPosts[index];
              return FriendPostTile(post: post);
            },
            separatorBuilder: (context, index) {
              // 6
              return const SizedBox(height: 16);
            },
          ),
          // 6
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
