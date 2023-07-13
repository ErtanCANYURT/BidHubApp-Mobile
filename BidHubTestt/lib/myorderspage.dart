import 'package:flutter/material.dart';

class MyOrdersPage extends StatelessWidget {
  final List<Order> orders = [
    Order(
      id: '1',
      productName: 'Ürün 1',
      price: 100,
      quantity: 2,
      date: DateTime.now(),
      status: 'Tamamlandı',
    ),
    Order(
      id: '2',
      productName: 'Ürün 2',
      price: 50,
      quantity: 1,
      date: DateTime.now(),
      status: 'Sipariş Alındı',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Siparişlerim'),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text('Sipariş ID: ${orders[index].id}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ürün: ${orders[index].productName}'),
                  Text('Fiyat: ${orders[index].price} TL'),
                  Text('Adet: ${orders[index].quantity}'),
                  Text('Tarih: ${orders[index].date.toString()}'),
                  Text('Durum: ${orders[index].status}'),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderDetailPage(order: orders[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class Order {
  final String id;
  final String productName;
  final double price;
  final int quantity;
  final DateTime date;
  final String status;

  Order({
    required this.id,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.date,
    required this.status,
  });
}

class OrderDetailPage extends StatelessWidget {
  final Order order;

  OrderDetailPage({required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sipariş Detayı'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sipariş ID: ${order.id}'),
            Text('Ürün: ${order.productName}'),
            Text('Fiyat: ${order.price} TL'),
            Text('Adet: ${order.quantity}'),
            Text('Tarih: ${order.date.toString()}'),
            Text('Durum: ${order.status}'),
            // Diğer detaylar eklenebilir
          ],
        ),
      ),
    );
  }
}
