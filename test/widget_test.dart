// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:belajarflutter/hello_world.dart';
import 'package:belajarflutter/column_widget.dart';
import 'package:belajarflutter/row_widget.dart';
import 'package:belajarflutter/about_page.dart';
import 'package:belajarflutter/home_page.dart';
import 'package:belajarflutter/model/produk.dart';
import 'package:belajarflutter/model/login.dart';
import 'package:belajarflutter/main.dart';

void main() {
  group('Pertemuan 2 Widget Tests', () {
    testWidgets('HelloWorld renders properly', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HelloWorld()));
      expect(find.text('Belajar Flutter'), findsOneWidget);
      expect(find.text('Hello World'), findsOneWidget);
    });

    testWidgets('ColumnWidget renders properly', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ColumnWidget()));
      expect(find.text('Widget Column'), findsOneWidget);
      expect(find.text('Kolom 1'), findsOneWidget);
      expect(find.text('Kolom 4'), findsOneWidget);
    });

    testWidgets('RowWidget renders properly', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: RowWidget()));
      expect(find.text('Widget Row'), findsOneWidget);
      expect(find.text('Row 1'), findsOneWidget);
      expect(find.text('Row 4'), findsOneWidget);
    });
  });

  group('Pertemuan 3 Widget Tests', () {
    testWidgets('HomePage and AboutPage render properly', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({'username': 'afkar'});
      await tester.pumpWidget(const MaterialApp(home: HomePage()));
      await tester.pumpAndSettle();
      expect(find.text('Home Page'), findsOneWidget);

      await tester.pumpWidget(const MaterialApp(home: AboutPage()));
      expect(find.text('About Page'), findsOneWidget);
      expect(find.text('Ini adalah halaman About'), findsOneWidget);
    });
  });

  group('Pertemuan 4 Model Tests', () {
    test('Produk model serializes and deserializes correctly', () {
      final json = {
        'id': 1,
        'kode_produk': 'A001',
        'nama_produk': 'Kamera',
        'harga': 5000000,
      };
      final produk = Produk.fromJson(json);
      expect(produk.id, 1);
      expect(produk.kodeProduk, 'A001');
      expect(produk.namaProduk, 'Kamera');
      expect(produk.hargaProduk, 5000000);

      // Test string fallback parsing
      final jsonStr = {
        'id': '2',
        'kode_produk': 'B002',
        'nama_produk': 'Laptop',
        'harga': '7500000',
      };
      final produk2 = Produk.fromJson(jsonStr);
      expect(produk2.id, 2);
      expect(produk2.hargaProduk, 7500000);
    });

    test('Login model handles integer and string user ID', () {
      final json = {
        'code': 200,
        'status': true,
        'data': {
          'token': 'mock-token-xyz',
          'user': {
            'id': 10,
            'email': 'afkar@example.com',
          }
        }
      };
      final login = Login.fromJson(json);
      expect(login.code, 200);
      expect(login.status, true);
      expect(login.token, 'mock-token-xyz');
      expect(login.userID, 10);
    });
  });

  group('Pertemuan 5 App Integration Tests', () {
    testWidgets('MyApp initial screen transitions to LoginPage when logged out', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      await tester.pumpWidget(const MyApp());
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.text('Login'), findsWidgets);
    });
  });
}
