import 'package:flutter/material.dart';

import '../widgets/StorageContainer.dart';
import '../widgets/UploadOptions.dart';

class StorageScreen extends StatelessWidget {
  const StorageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          StorageContainer(),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 18),
            child: UploadOptions(),
          )
        ],
      ),
    );
  }
}
