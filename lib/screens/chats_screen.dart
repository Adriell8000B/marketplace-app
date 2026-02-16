import 'dart:ui';
import 'package:flutter/material.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            backgroundColor: (theme.appBarTheme.backgroundColor ?? colorScheme.surface)
                .withValues(alpha: 0.8),
            flexibleSpace: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(color: Colors.transparent),
              ),
            ),
            title: const Text(
              "Chats",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search_rounded, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.more_vert_rounded, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Search conversations...",
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                  prefixIcon: const Icon(Icons.search_rounded, color: Colors.grey, size: 22),
                  fillColor: Colors.white.withValues(alpha: 0.05),
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Text(
                "Recent",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              _conversations.map((c) => _ChatTile(conversation: c)).toList(),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

final _conversations = [
  _Conversation(
    name: "TechStore Official",
    lastMessage: "Your order #2847 has shipped! Track it here.",
    time: "2m",
    avatarUrl: "https://picsum.photos/100?random=1",
    unread: 2,
    isOnline: true,
  ),
  _Conversation(
    name: "Sarah M.",
    lastMessage: "Is the Sonic-X still available?",
    time: "15m",
    avatarUrl: "https://picsum.photos/100?random=2",
    unread: 0,
    isOnline: true,
  ),
  _Conversation(
    name: "Fashion Hub",
    lastMessage: "New arrivals are live. Check them out!",
    time: "1h",
    avatarUrl: "https://picsum.photos/100?random=3",
    unread: 0,
    isOnline: false,
  ),
  _Conversation(
    name: "Alex Chen",
    lastMessage: "Thanks, received the keyboard yesterday.",
    time: "Yesterday",
    avatarUrl: "https://picsum.photos/100?random=4",
    unread: 0,
    isOnline: false,
  ),
  _Conversation(
    name: "GadgetWorld",
    lastMessage: "We have a flash sale on headphones — 30% off.",
    time: "Yesterday",
    avatarUrl: "https://picsum.photos/100?random=5",
    unread: 1,
    isOnline: true,
  ),
];

class _Conversation {
  final String name;
  final String lastMessage;
  final String time;
  final String avatarUrl;
  final int unread;
  final bool isOnline;

  _Conversation({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.avatarUrl,
    this.unread = 0,
    this.isOnline = false,
  });
}

class _ChatTile extends StatelessWidget {
  final _Conversation conversation;

  const _ChatTile({required this.conversation});

  @override
  Widget build(BuildContext context) {
    final c = conversation;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: colorScheme.surfaceContainerHighest,
                    backgroundImage: NetworkImage(c.avatarUrl),
                  ),
                  if (c.isOnline)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: const Color(0xFF34C759),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            c.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          c.time,
                          style: TextStyle(
                            color: c.unread > 0 ? colorScheme.secondary : Colors.grey,
                            fontSize: 12,
                            fontWeight: c.unread > 0 ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            c.lastMessage,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: c.unread > 0 ? FontWeight.w500 : FontWeight.normal,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (c.unread > 0)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: colorScheme.secondary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "${c.unread}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
