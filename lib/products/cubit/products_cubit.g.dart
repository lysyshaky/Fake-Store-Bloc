// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsState _$ProductsStateFromJson(Map<String, dynamic> json) =>
    ProductsState(
      status: $enumDecodeNullable(_$ProductsStatusEnumMap, json['status']) ??
          ProductsStatus.initial,
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Product>[],
    );

Map<String, dynamic> _$ProductsStateToJson(ProductsState instance) =>
    <String, dynamic>{
      'status': _$ProductsStatusEnumMap[instance.status]!,
      'products': instance.products,
    };

const _$ProductsStatusEnumMap = {
  ProductsStatus.initial: 'initial',
  ProductsStatus.loading: 'loading',
  ProductsStatus.success: 'success',
  ProductsStatus.failure: 'failure',
};
