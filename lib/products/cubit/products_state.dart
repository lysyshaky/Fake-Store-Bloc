part of 'products_cubit.dart';

enum ProductsStatus {
  initial,
  loading,
  success,
  failure,
}

extension ProductsStatusX on ProductsStatus {
  bool get isInitial => this == ProductsStatus.initial;
  bool get isLoading => this == ProductsStatus.loading;
  bool get isSuccess => this == ProductsStatus.success;
  bool get isFailure => this == ProductsStatus.failure;
}

@JsonSerializable()
class ProductsState extends Equatable {
  final ProductsStatus status;
  final List<Product> products;
  ProductsState({
    this.status = ProductsStatus.initial,
    this.products = const <Product>[],
  });

  ProductsState copyWith({
    ProductsStatus? status,
    List<Product>? products,
  }) {
    return ProductsState(
      status: status ?? this.status,
      products: products ?? this.products,
    );
  }

  factory ProductsState.fromJson(Map<String, dynamic> json) => _$ProductsStateFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsStateToJson(this);

  @override
  List<Object?> get props => [status, products];
}
