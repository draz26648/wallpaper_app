part of 'download_cubit.dart';

@immutable
abstract class DownloadState {}

class DownloadInitial extends DownloadState {}

class DownloadLoading extends DownloadState {}

class DownloadSuccess extends DownloadState {}

class DownloadError extends DownloadState {}
