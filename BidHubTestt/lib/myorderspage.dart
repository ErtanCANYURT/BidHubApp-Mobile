import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyOrdersPage extends StatefulWidget {
  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  List<Order> orders = [];

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    final url = 'https://bidhubappprod.azurewebsites.net/bids/Bids/MyAllOrder';

    try {
      final response = await http.get(Uri.parse(url));
      final responseData = json.decode(response.body);
      final List<dynamic> orderData = responseData;

      setState(() {
        orders = orderData.map((data) => Order.fromJson(data)).toList();
      });
    } catch (error) {
      print('Error fetching orders: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Siparişlerim'),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            child: ListTile(
              title: Text('Sipariş ID: ${order.id}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ürün: ${order.productName}'),
                  Text('Fiyat: ${order.price.toStringAsFixed(2)} TL'),
                  Text('Adet: ${order.quantity}'),
                  Text('Tarih: ${order.date.toString()}'),
                  Text('Durum: ${order.status}'),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderDetailPage(order: order),
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

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'].toString(),
      productName: json['auctionId'].toString(),
      price: json['price'].toDouble(),
      quantity: 1, // Burada bir adet varsayılan olarak ayarladım, gerektiğinde değiştirin
      date: DateTime.parse(json['createdTime']),
      status: 'Tamamlandı', // Durumu gelen veriden almanız gerekiyor
    );
  }
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
            Text('Fiyat: ${order.price.toStringAsFixed(2)} TL'),
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
