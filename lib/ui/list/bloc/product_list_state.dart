part of 'product_list_bloc.dart';

abstract class ProductListState extends Equatable {
  const ProductListState();

  @override
  List<Object> get props => [];
}

class ProductListLoading extends ProductListState {}

class ProdutListSuccess extends ProductListState {
  final List<ProductEntity> products;
  final int sort;
  final List<String> sortNames;

  const ProdutListSuccess(this.products, this.sort, this.sortNames);

  @override
  List<Object> get props => [sort, sortNames, products];
}

class ProductListError extends ProductListState {
  final AppException exception;

  const ProductListError(this.exception);

  @override
  List<Object> get props => [exception];
}
