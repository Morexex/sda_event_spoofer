import 'package:flutter/material.dart';

import '../minor_screens/visit_store.dart';
import '../widgets/appbar_widgets.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:const AppBarBackButton(),
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(title: 'Stores'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 25, crossAxisSpacing: 25, crossAxisCount: 2),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const VisitStore()));
            },
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 120,
                      width: 120,
                      child: Image.asset('images/inapp/store.png'),
                    ),
                    const Positioned(
                      bottom: 28,
                      left: 12,
                      child: SizedBox(
                        height: 48,
                        width: 90,
                        child: Image(
                          image: AssetImage("images/inapp/cover1.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
                const Text('Techspace',
                    style: TextStyle(
                      fontSize: 26,
                      fontFamily: 'AkayaTelivigala',
                    ))
              ],
            ),
          );
        },
      ),
    );
  }
}
