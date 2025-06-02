class Pagination {
  Pagination({
    required this.pageSize,
    required this.pageNum,
    required this.total,
  });
  final int pageSize;
  final int pageNum;
  final int total;
}
