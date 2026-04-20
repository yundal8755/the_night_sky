///
/// 게시글 업로드 완료 후 반환되는 결과 모델
///
class UploadPostResult {
  final String documentId;
  final String audioUrl;
  final String dateCreated;

  const UploadPostResult({
    required this.documentId,
    required this.audioUrl,
    required this.dateCreated,
  });
}
