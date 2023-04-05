import 'package:flutter/material.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../../../../global/themes/app_colors.dart';

class MessageInputWidget extends StatelessWidget {
  const MessageInputWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: AppColors.white,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.grey5,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 13,
                  horizontal: 16,
                ),
              ),
              maxLines: 5,
              minLines: 1,
            ),
          ),
          const SizedBox(width: 12),
          TouchableOpacity(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Icon(
                Icons.send_rounded,
                color: AppColors.grey1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
