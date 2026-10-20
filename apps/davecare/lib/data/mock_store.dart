import 'models.dart';

abstract final class MockStore {
  static const customerName = 'Ama Mensah';
  static const customerPhone = '024 498 0122';
  static const pharmacistName = 'Pharm. David Mensah';
  static const pharmacyName = 'DavidCare Pharmacy • Osu Oxford St, Accra';
  static const branch = 'East Legon Hub';
  static const digitalAddress = 'GD-183-4921';

  static const products = <ProductItem>[
    ProductItem(
      id: 'p1',
      name: 'Paracetamol Extra',
      detail: '500mg • 20 tablets',
      priceGhs: 18,
      inStock: true,
      boughtTimes: 3,
    ),
    ProductItem(
      id: 'p2',
      name: 'Vitamin C 1000mg',
      detail: 'Effervescent • 20 tabs',
      priceGhs: 42,
      inStock: true,
      boughtTimes: 4,
    ),
    ProductItem(
      id: 'p3',
      name: 'Omeprazole 20mg',
      detail: 'Delayed-release caps',
      priceGhs: 35,
      inStock: true,
    ),
    ProductItem(
      id: 'p4',
      name: 'Amoxicillin 500mg',
      detail: 'Capsules • 21 count',
      priceGhs: 55,
      inStock: true,
      requiresRx: true,
    ),
    ProductItem(
      id: 'p5',
      name: 'Augmentin 625mg',
      detail: 'Tablets • 14 count',
      priceGhs: 85,
      inStock: false,
      requiresRx: true,
      watching: true,
    ),
    ProductItem(
      id: 'p6',
      name: 'Ventolin Evohaler',
      detail: '100mcg • Asthma relief',
      priceGhs: 48,
      inStock: true,
      requiresRx: true,
    ),
    ProductItem(
      id: 'p7',
      name: 'Metformin 500mg',
      detail: 'Tablets • 56 count',
      priceGhs: 26.5,
      inStock: false,
      watching: true,
    ),
  ];

  static const orders = <OrderItem>[
    OrderItem(
      id: 'o1',
      number: 'DC-1042',
      status: 'Out for delivery',
      totalGhs: 115,
      fulfillment: 'delivery',
      itemsLabel: '2 items • MoMo Paid GH₵115.00',
      steps: [
        'Requested',
        'Pharmacist reviewed',
        'Preparing',
        'Out for delivery',
        'Delivered',
      ],
    ),
    OrderItem(
      id: 'o2',
      number: 'DC-1038',
      status: 'Ready for pickup',
      totalGhs: 145,
      fulfillment: 'pickup',
      itemsLabel: 'Prescription pack • MoMo Paid GH₵145.00',
      steps: [
        'Requested',
        'Approved',
        'Preparing',
        'Ready for pickup',
        'Collected',
      ],
    ),
  ];

  static const prescriptions = <PrescriptionItem>[
    PrescriptionItem(
      id: 'rx1',
      title: 'Dr. Boateng — Chest infection',
      status: 'under_review',
      customer: 'Ama Mensah',
      uploadedAt: 'Today, 08:14',
      items: ['Amoxicillin 500mg', 'Vitamin C 1000mg'],
    ),
    PrescriptionItem(
      id: 'rx2',
      title: 'Korle-Bu outpatient',
      status: 'approved',
      customer: 'Kwame Asante',
      uploadedAt: 'Yesterday',
      items: ['Metformin 500mg', 'Amlodipine 5mg'],
    ),
    PrescriptionItem(
      id: 'rx3',
      title: 'Paediatric syrup',
      status: 'action_required',
      customer: 'Akosua Boateng',
      uploadedAt: '13 Sep',
      items: ['Azithromycin suspension'],
    ),
  ];

  static const consultations = <ConsultationThread>[
    ConsultationThread(
      id: 'c1',
      subject: 'Stomach discomfort on antibiotic',
      status: 'pharmacist_replied',
      customer: 'Ama Mensah',
      preview: 'Complete the 7-day course even if you feel better by Day 4.',
      messages: [
        ChatMessage(
          sender: 'Ama',
          body:
              'I have mild stomach discomfort after the afternoon Amoxicillin dose. Should I stop?',
          time: '09:12',
        ),
        ChatMessage(
          sender: 'Pharm. David',
          body:
              'Please remember to complete your full 7-day antibiotic course even if you feel completely fine by Day 4. Take after meals. Text me if discomfort increases.',
          time: '09:22',
        ),
      ],
    ),
    ConsultationThread(
      id: 'c2',
      subject: 'Refill timing for metformin',
      status: 'awaiting_pharmacist',
      customer: 'Kwame Asante',
      preview: 'Waiting for pharmacist.',
      messages: [
        ChatMessage(
          sender: 'Kwame',
          body: 'My last pack finishes Friday. Can I collect tomorrow?',
          time: '08:40',
        ),
      ],
    ),
  ];

  static const timeline = <TimelineEvent>[
    TimelineEvent(
      title: 'Prescription uploaded',
      detail: 'Chest infection script from Dr. Boateng',
      when: '12 Sep',
    ),
    TimelineEvent(
      title: 'Prescription under review',
      detail: 'Pharm. David opened the file',
      when: '13 Sep',
    ),
    TimelineEvent(
      title: 'Order collected',
      detail: 'Amoxicillin 500mg — East Legon Hub',
      when: '14 Sep',
    ),
    TimelineEvent(
      title: 'Refill may be due',
      detail: 'This medication may be due for a refill based on your previous purchase pattern.',
      when: '10 Oct',
    ),
  ];

  static const demand = <DemandRow>[
    DemandRow(product: 'Metformin 500mg', waiters: 28, valueGhs: 3920, status: 'watching'),
    DemandRow(product: 'Amlodipine 5mg', waiters: 23, valueGhs: 3220, status: 'watching'),
    DemandRow(product: 'Lisinopril 10mg', waiters: 13, valueGhs: 1820, status: 'requested'),
    DemandRow(product: 'Augmentin 625mg', waiters: 8, valueGhs: 680, status: 'not_available'),
  ];

  static const customers = <Customer360>[
    Customer360(
      name: 'Ama Mensah',
      phone: '024 498 0122',
      area: 'Osu • GA-492-1204',
      nhis: 'Linked',
      medications: ['Amoxicillin 500mg', 'Paracetamol Extra', 'Vitamin C 1000mg'],
      notes: 'Active 7-day antibiotic course. Prefers MoMo MTN. Delivery to Oxford St.',
    ),
    Customer360(
      name: 'Kwame Asante',
      phone: '020 311 8841',
      area: 'East Legon • GD-183-2201',
      nhis: 'Linked',
      medications: ['Metformin 500mg', 'Amlodipine 5mg'],
      notes: 'Regular refill customer. Watchlist on metformin.',
    ),
    Customer360(
      name: 'Akosua Boateng',
      phone: '054 220 1190',
      area: 'Adabraka',
      nhis: 'Not linked',
      medications: ['Azithromycin suspension'],
      notes: 'Paediatric dependent care. Clarification requested on syrup strength.',
    ),
  ];
}

String formatGhs(double v) => 'GH₵${v.toStringAsFixed(2)}';
