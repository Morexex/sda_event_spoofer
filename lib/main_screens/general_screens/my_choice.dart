import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/my_choices_model.dart';
import '../../providers/mychoice_provider.dart';
import '../../widgets/alert_dialogue.dart';
import '../../widgets/appbar_widgets.dart';

class MyChoiceScreen extends StatefulWidget {
  const MyChoiceScreen({super.key});

  @override
  State<MyChoiceScreen> createState() => _MyChoiceScreenState();
}

class _MyChoiceScreenState extends State<MyChoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
            leading: const AppBarBackButton(),
            elevation: 0,
            backgroundColor: Colors.white,
            title: const AppBarTitle(title: 'My Choices'),
            actions: [
               context.watch<Wish>().getWishItems.isEmpty
                  ? const SizedBox()
                  : IconButton(
                      onPressed: () {
                        MyAlertDialogue.showMyDialogue(
                            context: context,
                            title: 'Clear Choices?',
                            content: 'Are you sure you want to clear choices?',
                            tabNo: () {
                              Navigator.pop(context);
                            },
                            tabYes: () {
                              context.read<Wish>().clearWishList();
                              Navigator.pop(context);
                            });
                      },
                      icon: const Icon(
                        Icons.delete_forever,
                        color: Colors.black,
                      ))
            ], 
          ),
          body: context.watch<Wish>().getWishItems.isNotEmpty
              ? const WishItems()
              : const EmptyWishlist(),
        ),
      ),
    );
  }
}

class EmptyWishlist extends StatelessWidget {
  const EmptyWishlist({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Your Choices are Empty!',
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}

class WishItems extends StatelessWidget {
  const WishItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Wish>(
      builder: (context, wish, child) {
        return ListView.builder(
            itemCount: wish.count,
            itemBuilder: (context, index) {
              final service = wish.getWishItems[index];
              return MyChoiceModel(service: service);
            });
      },
    );
  }
}
