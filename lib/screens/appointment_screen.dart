import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorModel {
  final String imageUrl;
  final String name;
  final String rating;
  DoctorModel({
    required this.imageUrl,
    required this.name,
    required this.rating,
  });
}

class AppointmentScreen extends StatelessWidget {
  List<DoctorModel> doctors = [
    DoctorModel(
        imageUrl:
            'https://i.pinimg.com/564x/7c/23/13/7c2313f8d49ff41e48982af55d5938f9.jpg',
        name: 'Dr. Stella Kane',
        rating: 'Rating 4.1'),
    DoctorModel(
        imageUrl:
            'https://i.pinimg.com/736x/c4/60/80/c460808901a708eeae3b14a697d7df9e.jpg',
        name: 'Dr. Fred Mask',
        rating: 'Rating 4.2'),
    DoctorModel(
        imageUrl:
            'https://i.pinimg.com/564x/3e/2f/c4/3e2fc4434228acce0fb9c32f60647ff1.jpg',
        name: 'Dr. Zac Wolff',
        rating: 'Rating 4.3'),
    DoctorModel(
        imageUrl:
            'https://i.pinimg.com/564x/18/35/eb/1835eb1fa62c5a4392798b2bde720450.jpg',
        name: 'Dr. Mark Kane',
        rating: 'Rating 4.4'),
    DoctorModel(
        imageUrl:
            'https://i.pinimg.com/564x/6c/b2/92/6cb292bb19398b280f4ca5ad0af94469.jpg',
        name: 'Dr. Cem Baysal',
        rating: 'Rating 4.8'),
    DoctorModel(
        imageUrl:
            'https://i.pinimg.com/564x/6c/b2/92/6cb292bb19398b280f4ca5ad0af94469.jpg',
        name: 'Dr. Cem Baysal',
        rating: 'Rating 4.8'),
    DoctorModel(
        imageUrl:
            'https://i.pinimg.com/564x/6c/b2/92/6cb292bb19398b280f4ca5ad0af94469.jpg',
        name: 'Dr. Cem Baysal',
        rating: 'Rating 4.8'),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              color: Colors.teal[300],
              child: Column(
                children: [
                  SizedBox(
                    height: 64,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Center(
                        child: const TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search",
                            icon: Icon(
                              Icons.search,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Expanded(flex: 3,child: Placeholder()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                // physics: NeverScrollableScrollphysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => buildListItem(doctors[index]),
                separatorBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey[300],
                  ),
                ),

                itemCount: doctors.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListItem(DoctorModel doctor) => Row(
        children: [
          CircleAvatar(
            radius: 40.0,
            backgroundImage: NetworkImage(
              '${doctor.imageUrl}',
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${doctor.name}',
                style: GoogleFonts.montserrat(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${doctor.rating}',
                style: GoogleFonts.montserrat(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      );
}
