import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/image_provider.dart';

class EditScreen extends ConsumerWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final img = ref.watch(imgNotifierProvider);
     
    return Scaffold(
      backgroundColor: Colors.black38,
      appBar: AppBar(
        title: const Text("Edit Image"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
           // img.clear();
            ref.read(imgNotifierProvider.notifier).removeImage;
            
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          TextButton(
            onPressed: () {
              ref.read(imgNotifierProvider.notifier).createPdf();
            },
            child: const Text("SAVE"),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: img.length,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 7),
                        child: Stack(
                          children: [
                            Image.file(
                              img[index].imagefile,
                              fit: BoxFit.fill,
                            ),
                            Positioned(
                              top: 2,
                              right: 2,
                              child: IconButton(
                                onPressed: () {
                                  ref.read(imgNotifierProvider.notifier).removeImage(img[index]);
                                },
                                icon: const Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                  size: 40,
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
