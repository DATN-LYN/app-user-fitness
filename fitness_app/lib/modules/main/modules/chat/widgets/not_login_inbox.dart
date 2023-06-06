import 'package:fitness_app/global/enums/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../global/gen/assets.gen.dart';
import '../../../../../global/providers/app_settings_provider.dart';
import '../../../../../global/widgets/login_panel.dart';
import '../../../../../global/widgets/shadow_wrapper.dart';

class NotLoginInbox extends ConsumerWidget {
  const NotLoginInbox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final currentLocale = ref.watch(appSettingProvider).locale;
    final isVN = currentLocale == AppLocale.viVN;

    return Column(
      children: [
        const LoginPanel(),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Assets.images.logoContainer.image(width: 40, height: 40),
                  ShadowWrapper(
                    child: Text(
                      isVN
                          ? 'Xin chào! Tôi có thể giúp gì cho bạn?'
                          : 'Hello! How can I help you?',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ShadowWrapper(
                    child: Text(
                      isVN
                          ? 'Tôi nên làm gì để giảm cân?'
                          : 'What should I do to lose weight?',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: width * 0.75),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Assets.images.logoContainer.image(width: 40, height: 40),
                    Expanded(
                      child: ShadowWrapper(
                        child: Text(
                          isVN
                              ? 'Giảm cân là mục tiêu chung của nhiều người và bạn có thể thực hiện một số bước để đạt được mục tiêu này. Sau đây là một số mẹo giúp bạn bắt đầu: \n1. Đặt mục tiêu thực tế. Trước khi bạn bắt đầu, điều quan trọng là phải đặt mục tiêu giảm cân thực tế. Điều này sẽ giúp bạn duy trì động lực và đi đúng hướng. \n2. Tạo ra sự thiếu hụt calo. Giảm cân là đốt cháy nhiều calo hơn mức tiêu thụ. Để tạo ra sự thâm hụt calo, bạn có thể giảm lượng calo nạp vào, tăng hoạt động thể chất hoặc kết hợp cả hai. \n3. Chọn thực phẩm lành mạnh. Để giảm cân, hãy tập trung vào việc ăn các loại thực phẩm toàn phần, giàu chất dinh dưỡng như trái cây, rau, protein nạc và chất béo lành mạnh. Tránh thực phẩm chế biến và những thực phẩm có nhiều đường bổ sung và chất béo bão hòa. \n4. Kiểm soát khẩu phần ăn của bạn. Kiểm soát khẩu phần là chìa khóa để giảm cân. Sử dụng những chiếc đĩa nhỏ hơn, đo lượng thức ăn của bạn và tránh ăn trước TV hoặc trong khi bị phân tâm. \n5. Tập thể dục thường xuyên. Tập thể dục thường xuyên có thể giúp bạn đốt cháy calo và duy trì khối lượng cơ bắp. Đặt mục tiêu tập thể dục cường độ vừa phải ít nhất 150 phút hoặc 75 phút tập thể dục cường độ cao mỗi tuần. \n6. Ngủ đủ giấc. Giấc ngủ rất quan trọng để giảm cân. Đặt mục tiêu ngủ 7-8 tiếng mỗi đêm, vì thiếu ngủ có thể dẫn đến cảm giác đói và thèm ăn tăng lên. \nHãy nhớ rằng, giảm cân là một quá trình dần dần đòi hỏi sự kiên nhẫn và bền bỉ. Tập trung vào việc thực hiện những thay đổi nhỏ, bền vững trong lối sống của bạn và bạn sẽ đạt được mục tiêu giảm cân của mình.'
                              : 'Losing weight is a common goal for many people, and there are several steps you can take to achieve this. Here are some tips to help you get started: \n1. Set a realistic goal. Before you start, its important to set a realistic weight loss goal. This will help you stay motivated and on track. \n2. Create a calorie deficit. Weight loss is all about burning more calories than you consume. To create a calorie deficit, you can either reduce your calorie intake, increase your physical activity, or a combination of both. \n3. Choose healthy foods. To lose weight, focus on eating nutrient-dense, whole foods such as fruits, vegetables, lean proteins, and healthy fats. Avoid processed foods and those high in added sugars and saturated fats. \n4. Control your portions. Portion control is key to weight loss. Use smaller plates, measure your food, and avoid eating in front of the TV or while distracted.\n5. Exercise regularly. Regular exercise can help you burn calories and maintain muscle mass. Aim for at least 150 minutes of moderate-intensity exercise or 75 minutes of vigorous exercise per week. \n6. Get enough sleep. Sleep is important for weight loss. Aim for 7-8 hours of sleep per night, as lack of sleep can lead to increased hunger and cravings. \nRemember, losing weight is a gradual process that requires patience and persistence. Focus on making small, sustainable changes to your lifestyle, and you\'ll be on your way to achieving your weight loss goals.',
                          maxLines: 40,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ShadowWrapper(
                    child: Text(isVN ? 'Cảm ơn' : 'Thank you'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
