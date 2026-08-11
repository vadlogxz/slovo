import 'package:slovo/core/assets/app_assets.dart';
import 'package:slovo/feature/vocabulary/domain/models/collection_icon.dart';

extension CollectionIconX on CollectionIcon {
  String get asset {
    switch (this) {
      case CollectionIcon.none:
        return AppAssets.collectionNone;
      case CollectionIcon.book:
        return AppAssets.collectionBook;
      case CollectionIcon.star:
        return AppAssets.collectionStar;
      case CollectionIcon.heart:
        return AppAssets.collectionHeart;
      case CollectionIcon.flag:
        return AppAssets.collectionFlag;
      case CollectionIcon.school:
        return AppAssets.collectionSchool;
      case CollectionIcon.travel:
        return AppAssets.collectionTravel;
      case CollectionIcon.work:
        return AppAssets.collectionWork;
      case CollectionIcon.food:
        return AppAssets.collectionFood;
      case CollectionIcon.music:
        return AppAssets.collectionMusic;
      case CollectionIcon.movie:
        return AppAssets.collectionMovie;
      case CollectionIcon.sport:
        return AppAssets.collectionSport;
      case CollectionIcon.nature:
        return AppAssets.collectionNature;
      case CollectionIcon.science:
        return AppAssets.collectionScience;
      case CollectionIcon.home:
        return AppAssets.collectionHome;
    }
  }
}