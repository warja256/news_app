import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_reactions/flutter_chat_reactions.dart';
import 'package:flutter_chat_reactions/utilities/default_data.dart';
import 'package:news_app/features/news_list/widgets/reaction_widget.dart';
import 'package:news_app/features/news_list/widgets/tag_widget.dart';
import 'package:news_app/repositories/news_list/models/news_article.dart';

@RoutePage()
class NewsArticleScreen extends StatefulWidget {
  final NewsArticle article;
  final Map<String, int> reactions;
  final GlobalKey tileKey;

  const NewsArticleScreen({
    super.key,
    required this.article,
    required this.reactions,
    required this.tileKey,
  });

  @override
  State<NewsArticleScreen> createState() => _NewsArticleScreenState();
}

class _NewsArticleScreenState extends State<NewsArticleScreen> {
  @override
  Widget build(BuildContext context) {
    final sortedReactions = widget.reactions.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context, widget.reactions),
            icon: Icon(Icons.arrow_back_ios)),
        title: const Icon(Icons.newspaper_rounded),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onLongPress: () {
            final RenderBox box =
                widget.tileKey.currentContext!.findRenderObject() as RenderBox;
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
                      top: position.dy + 200,
                      child: ReactionsDialogWidget(
                        id: widget.article.id.toString(),
                        messageWidget: const Text(''),
                        reactions: availableReactions,
                        onReactionTap: (reaction) {
                          setState(() {
                            widget.reactions.update(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.article.title,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              Divider(
                color: Theme.of(context).dividerColor,
              ),
              const SizedBox(height: 10),
              Text(widget.article.body,
                  style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 10),
              if (widget.article.tags.isNotEmpty)
                TagWidget(tags: widget.article.tags),
              if (widget.reactions.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 4,
                    children: sortedReactions
                        .map((entry) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (entry.value > 1) {
                                    widget.reactions.update(
                                        entry.key, (value) => value - 1);
                                  } else {
                                    widget.reactions.remove(entry.key);
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
        ),
      ),
    );
  }
}
