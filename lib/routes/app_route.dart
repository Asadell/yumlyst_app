import 'package:auto_route/auto_route.dart';
import 'package:recipe_app/features/auth/views/login_screen.dart';
import 'package:recipe_app/features/auth/views/register_screen.dart';
import 'package:recipe_app/features/camera/views/camera_screen.dart';
import 'package:recipe_app/features/category/views/category_screen.dart';
import 'package:recipe_app/features/food/views/about_screen.dart';
import 'package:recipe_app/features/food/views/add_review_screen.dart';
import 'package:recipe_app/features/food/views/favorite_screen.dart';
import 'package:recipe_app/features/food/views/food_detail_screen.dart';
import 'package:recipe_app/features/food/views/history_screen.dart';
import 'package:recipe_app/features/food/views/instruction_screen.dart';
import 'package:recipe_app/features/food/views/review_screen.dart';
import 'package:recipe_app/features/food/views/search_screen.dart';
import 'package:recipe_app/features/home/views/home_screen.dart';
import 'package:recipe_app/features/main/views/main_screen.dart';
import 'package:recipe_app/features/onboarding/views/onboarding_cook_guidance_screen.dart';
import 'package:recipe_app/features/onboarding/views/onboarding_image_recognition_screen.dart';
import 'package:recipe_app/features/onboarding/views/onboarding_user_discussion_screen.dart';
import 'package:recipe_app/features/onboarding/views/splash_screen.dart';
import 'package:recipe_app/features/profile/views/help_center_screen.dart';
import 'package:recipe_app/features/profile/views/profile_screen.dart';
import 'package:recipe_app/features/profile/views/reset_password_screen.dart';
import 'package:recipe_app/features/profile/views/update_profile_screen.dart';

part 'app_route.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashRoute.page,
          // initial: true,
        ),
        AutoRoute(
          page: OnboardingCookGuidanceRoute.page,
        ),
        AutoRoute(
          page: OnboardingUserDiscussionRoute.page,
        ),
        AutoRoute(
          page: OnboardingImageRecognitionRoute.page,
        ),
        AutoRoute(
          page: LoginRoute.page,
          initial: true,
        ),
        AutoRoute(
          page: RegisterRoute.page,
        ),
        AutoRoute(
          page: MainRoute.page,
        ),
        AutoRoute(
          page: HomeRoute.page,
        ),
        AutoRoute(
          page: CategoryRoute.page,
        ),
        AutoRoute(
          page: SearchRoute.page,
        ),
        AutoRoute(
          page: FoodDetailRoute.page,
        ),
        AutoRoute(
          page: InstructionRoute.page,
        ),
        AutoRoute(
          page: AboutRoute.page,
        ),
        AutoRoute(
          page: ReviewRoute.page,
        ),
        AutoRoute(
          page: AddReviewRoute.page,
        ),
        AutoRoute(
          page: CameraRoute.page,
        ),
        AutoRoute(
          page: ProfileRoute.page,
        ),
        AutoRoute(
          page: UpdateProfileRoute.page,
        ),
        AutoRoute(
          page: ResetPasswordRoute.page,
        ),
        AutoRoute(
          page: HistoryRoute.page,
        ),
        AutoRoute(
          page: FavoriteRoute.page,
        ),
        AutoRoute(
          page: HelpCenterRoute.page,
        ),
      ];
}
