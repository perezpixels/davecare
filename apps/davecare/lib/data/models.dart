class ProductItem {
  const ProductItem({
    required this.id,
    required this.name,
    required this.detail,
    required this.priceGhs,
    required this.inStock,
    this.requiresRx = false,
    this.watching = false,
    this.boughtTimes,
  });

  final String id;
  final String name;
  final String detail;
  final double priceGhs;
  final bool inStock;
  final bool requiresRx;
  final bool watching;
  final int? boughtTimes;
}

class OrderItem {
  const OrderItem({
    required this.id,
    required this.number,
    required this.status,
    required this.totalGhs,
    required this.fulfillment,
    required this.itemsLabel,
    required this.steps,
  });

  final String id;
  final String number;
  final String status;
  final double totalGhs;
  final String fulfillment;
  final String itemsLabel;
  final List<String> steps;
}

class PrescriptionItem {
  const PrescriptionItem({
    required this.id,
    required this.title,
    required this.status,
    required this.customer,
    required this.uploadedAt,
    required this.items,
  });

  final String id;
  final String title;
  final String status;
  final String customer;
  final String uploadedAt;
  final List<String> items;
}

class ConsultationThread {
  const ConsultationThread({
    required this.id,
    required this.subject,
    required this.status,
    required this.customer,
    required this.preview,
    required this.messages,
  });

  final String id;
  final String subject;
  final String status;
  final String customer;
  final String preview;
  final List<ChatMessage> messages;
}

class ChatMessage {
  const ChatMessage({required this.sender, required this.body, required this.time});
  final String sender;
  final String body;
  final String time;
}

class TimelineEvent {
  const TimelineEvent({
    required this.title,
    required this.detail,
    required this.when,
  });

  final String title;
  final String detail;
  final String when;
}

class DemandRow {
  const DemandRow({
    required this.product,
    required this.waiters,
    required this.valueGhs,
    required this.status,
  });

  final String product;
  final int waiters;
  final double valueGhs;
  final String status;
}

class Customer360 {
  const Customer360({
    required this.name,
    required this.phone,
    required this.area,
    required this.nhis,
    required this.medications,
    required this.notes,
  });

  final String name;
  final String phone;
  final String area;
  final String nhis;
  final List<String> medications;
  final String notes;
}
