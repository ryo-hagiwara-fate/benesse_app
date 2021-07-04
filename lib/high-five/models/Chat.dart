class Chat {
  final String name, lastMessage, image, time;
  final bool isActive;

  Chat({
    this.name = '',
    this.lastMessage = '',
    this.image = '',
    this.time = '',
    this.isActive = false,
  });
}

List chatsData = [
  Chat(
    name: "伊藤博文",
    lastMessage: "Hope you are doing well...",
    image: "images/user_3.png",
    time: "3m ago",
    isActive: false,
  ),
  Chat(
    name: "井伊直弼",
    lastMessage: "Hello Abdullah! I am...",
    image: "images/user_2.png",
    time: "8m ago",
    isActive: true,
  ),
  Chat(
    name: "大谷翔平",
    lastMessage: "Do you have update...",
    image: "images/user_3.png",
    time: "5d ago",
    isActive: false,
  ),
  Chat(
    name: "Lisa",
    lastMessage: "You’re welcome :)",
    image: "images/user_4.png",
    time: "5d ago",
    isActive: true,
  ),
  Chat(
    name: "Albert Flores",
    lastMessage: "Thanks",
    image: "images/user_5.png",
    time: "6d ago",
    isActive: false,
  ),
  Chat(
    name: "Jenny Wilson",
    lastMessage: "Hope you are doing well...",
    image: "images/user_4.png",
    time: "3m ago",
    isActive: false,
  ),
  Chat(
    name: "Esther Howard",
    lastMessage: "Hello Abdullah! I am...",
    image: "images/user_2.png",
    time: "8m ago",
    isActive: true,
  ),
  Chat(
    name: "Ralph Edwards",
    lastMessage: "Do you have update...",
    image: "images/user_3.png",
    time: "5d ago",
    isActive: false,
  ),
];
