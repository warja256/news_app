import 'package:flutter/material.dart';
import 'package:flutter_chat_reactions/flutter_chat_reactions.dart';
import 'package:flutter_chat_reactions/utilities/default_data.dart';
import 'package:news_app/features/news_article/view/news_article_screen.dart';
import 'package:news_app/features/news_list/widgets/reaction_widget.dart';
import 'package:news_app/features/news_list/widgets/tag_widget.dart';
import 'package:news_app/repositories/news_list/models/news_article.dart';

class NewsListTile extends StatefulWidget {
  const NewsListTile({
    super.key,
    required this.article,
  });

  final NewsArticle article;

  @override
  State<NewsListTile> createState() => _NewsListTileState();
}

class _NewsListTileState extends State<NewsListTile> {
  Map<String, int> reactions = {};
  final GlobalKey _tileKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final sortedReactions = reactions.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return GestureDetector(
      onLongPress: () {
        final RenderBox box =
            _tileKey.currentContext!.findRenderObject() as RenderBox;
        final Offset position = box.localToGlobal(Offset.zero);
        List<String> availableReactions = List.from(DefaultData.reactions)
          ..remove('➕');
        showGeneralDialog(
          context: context,
          barrierDismissible: true,
          barrierLabel: 'Reaction Dialog',
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (context, anim1, anim2) {
            return Stack(
              children: [
                Positioned(
                  left: position.dx,
                  top: position.dy + 90,
                  child: ReactionsDialogWidget(
                    id: widget.article.id.toString(),
                    messageWidget: const Text(''),
                    reactions: availableReactions,
                    onReactionTap: (reaction) {
                      setState(() {
                        reactions.update(
                          reaction,
                          (value) => value + 1,
                          ifAbsent: () => 1,
                        );
                      });
                    },
                    onContextMenuTap: (menuItem) {},
                    menuItems: [],
                  ),
                ),
              ],
            );
          },
          transitionBuilder: (context, anim1, anim2, child) {
            return FadeTransition(
              opacity: anim1,
              child: child,
            );
          },
        );
      },
      child: Column(
        key: _tileKey,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              widget.article.title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                widget.article.body.substring(0, 30) + '...',
                style: Theme.of(context).textTheme.displaySmall,
                textAlign: TextAlign.justify,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            onTap: () async {
              final result = await Navigator.push<Map<String, int>>(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsArticleScreen(
                    article: widget.article,
                    reactions: reactions,
                    tileKey: _tileKey,
                  ),
                ),
              );
              if (result != null) {
                setState(() {
                  reactions = result;
                });
              }
            },
          ),
          if (widget.article.tags.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TagWidget(
                tags: widget.article.tags,
              ),
            ),
          if (reactions.isNotEmpty)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Wrap(
                spacing: 12,
                children: sortedReactions
                    .map((entry) => GestureDetector(
                          onTap: () {
                            setState(() {
                              if (entry.value > 1) {
                                reactions.update(
                                    entry.key, (value) => value - 1);
                              } else {
                                reactions.remove(entry.key);
                              }
                            });
                          },
                          child: ReactionWidget(
                            entry: entry,
                          ),
                        ))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
