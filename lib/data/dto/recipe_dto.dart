import 'package:flap_app/domain/entity/recipe.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recipe_dto.g.dart';

@JsonSerializable()
class RecipeDto extends Recipe {
  final int _id;
  final String? _title;
  final String? _image;
  const RecipeDto(int id, String? title, String? image)
      : _id = id,
        _title = title,
        _image = image,
        super(id: id);
  @override
  int get id => _id;
  @override
  String? get title => _title;
  @override
  String? get image => _image;
  factory RecipeDto.fromJson(Map<String, dynamic> json) =>
      _$RecipeDtoFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeDtoToJson(this);
}
