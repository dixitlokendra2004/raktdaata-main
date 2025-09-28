import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:raktdata_app/core/app_colors.dart';
import 'package:raktdata_app/models/donor_model1.dart';
import 'package:raktdata_app/widgets/Custom_textField_1.dart';

class DonorListScreen extends StatefulWidget {
  @override
  _DonorListScreenState createState() => _DonorListScreenState();
}

class _DonorListScreenState extends State<DonorListScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Donor> _donors = [];
  List<Donor> _filteredDonors = [];
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    _fetchDonors();
  }

  void _fetchDonors() async {
    QuerySnapshot snapshot = await _firestore.collection('donor').get();
    List<Donor> donors = snapshot.docs.map((doc) => Donor.fromDocumentSnapshot(doc)).toList();
    setState(() {
      _donors = donors;
      _filteredDonors = donors;
    });
  }

  void _filterDonors(String searchText) {
    List<Donor> filtered = _donors.where((donor) {
      return donor.name.toLowerCase().contains(searchText.toLowerCase()) ||
          donor.email.toLowerCase().contains(searchText.toLowerCase()) ||
          donor.city.toLowerCase().contains(searchText.toLowerCase()) ||
          donor.bloodGroup.toLowerCase().contains(searchText.toLowerCase()) ||
          donor.mobileNumber.contains(searchText);
    }).toList();
    setState(() {
      _filteredDonors = filtered;
      _searchText = searchText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.white),
        backgroundColor: AppColors.Red700,
        title: Text("Donors"),
        centerTitle: true,
        // actions: [
        //   IconButton(onPressed: () {
        //     _adminViewModel.onDeletePressed();
        //   }, icon: Icon(Icons.delete_outline)),
        // ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                _filterDonors(value);
              },
              style: TextStyle(
                  fontWeight: FontWeight.w500
              ),
              decoration: InputDecoration(
                hintText: 'Search...',
                contentPadding: EdgeInsets.zero,
                isDense: true,
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2), // Set the border color to red and width to 2 when TextField is focused
                ),
                prefixIcon: Icon(Icons.search, size: 20, color: Colors.grey.shade700),
              ),
            ),

          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingTextStyle: TextStyle(
                  fontWeight: FontWeight.w600
                ),
                dataTextStyle: TextStyle(
                  fontWeight: FontWeight.w500
                ),

                columns: [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Blood Group')),
                  DataColumn(label: Text('Last Donation')),
                  DataColumn(label: Text('City')),
                  DataColumn(label: Text('Mobile')),
                  DataColumn(label: Text('Email')),
                ],
                rows: _filteredDonors.map((donor) {
                  return DataRow(cells: [
                    DataCell(Text(donor.name)),
                    DataCell(Text(donor.bloodGroup)),
                    DataCell(Text(DateFormat('d MMM y').format(donor.bloodDonationDate))),
                    DataCell(Text(donor.city)),
                    DataCell(Text(donor.mobileNumber)),
                    DataCell(Text(donor.email)),
                  ]);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
