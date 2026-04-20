import 'package:everyones_tone/app/style/app_color.dart';
import 'package:everyones_tone/app/style/app_text_style.dart';
import 'package:everyones_tone/presentation/post/widget/night_sky_card_web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///
/// 게시글 업로드 완료 후 하단에서 올라오는 웹 엽서 공유 다이얼로그
///
Future<void> showShareCardDialog({
  required BuildContext context,
  required String postId,
  required String postTitle,
  required String audioUrl,
  required String nickname,
  required String profilePicUrl,
  required String userEmail,
  required String dateCreated,
}) {
  return showGeneralDialog(
    context: context,
    barrierColor: Colors.transparent,
    barrierDismissible: true,
    barrierLabel: '',
    pageBuilder: (_, __, ___) => const SizedBox.shrink(),
    transitionDuration: const Duration(milliseconds: 350),
    transitionBuilder: (ctx, animation, _, __) {
      final double backgroundOpacity = animation.value * 0.55;
      final slideAnim = Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
      );

      return Stack(
        children: [
          // 배경 딤
          Positioned.fill(
            child: GestureDetector(
              onTap: () => Navigator.of(ctx).pop(),
              child: Container(
                color: Colors.black.withOpacity(backgroundOpacity),
              ),
            ),
          ),
          // 다이얼로그 본체
          Positioned(
            left: 16,
            right: 16,
            bottom: 40,
            child: SlideTransition(
              position: slideAnim,
              child: Material(
                color: AppColor.neutrals80,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                clipBehavior: Clip.antiAlias,
                child: _ShareCardDialogContent(
                  postId: postId,
                  postTitle: postTitle,
                  audioUrl: audioUrl,
                  nickname: nickname,
                  profilePicUrl: profilePicUrl,
                  userEmail: userEmail,
                  dateCreated: dateCreated,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

// 다이얼로그 내부 상태
enum _CardState { prompt, loading, complete, error }

class _ShareCardDialogContent extends StatefulWidget {
  final String postId;
  final String postTitle;
  final String audioUrl;
  final String nickname;
  final String profilePicUrl;
  final String userEmail;
  final String dateCreated;

  const _ShareCardDialogContent({
    required this.postId,
    required this.postTitle,
    required this.audioUrl,
    required this.nickname,
    required this.profilePicUrl,
    required this.userEmail,
    required this.dateCreated,
  });

  @override
  State<_ShareCardDialogContent> createState() =>
      _ShareCardDialogContentState();
}

class _ShareCardDialogContentState extends State<_ShareCardDialogContent> {
  _CardState _state = _CardState.prompt;
  String? _generatedUrl;
  bool _copied = false;

  /// 웹뷰 화면으로 이동하여 엽서 편집 시작
  void _startCreation() {
    setState(() => _state = _CardState.loading);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => NightSkyCardWebView(
          postId: widget.postId,
          postTitle: widget.postTitle,
          audioUrl: widget.audioUrl,
          nickname: widget.nickname,
          profilePicUrl: widget.profilePicUrl,
          userEmail: widget.userEmail,
          dateCreated: widget.dateCreated,
          onComplete: (url) {
            // 웹뷰 pop 완료 후 다이얼로그 상태 업데이트
            if (mounted) {
              setState(() {
                _generatedUrl = url;
                _state = _CardState.complete;
              });
            }
          },
          onCancelled: () {
            if (mounted) setState(() => _state = _CardState.prompt);
          },
          onError: () {
            if (mounted) setState(() => _state = _CardState.error);
          },
        ),
      ),
    );
  }

  /// URL 클립보드 복사
  Future<void> _copyUrl() async {
    if (_generatedUrl == null) return;
    await Clipboard.setData(ClipboardData(text: _generatedUrl!));
    if (mounted) setState(() => _copied = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _copied = false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: switch (_state) {
        _CardState.prompt => _buildPrompt(),
        _CardState.loading => _buildLoading(),
        _CardState.complete => _buildComplete(),
        _CardState.error => _buildError(),
      },
    );
  }

  // ------------------------------------------------------------------
  // 초기 안내 상태
  // ------------------------------------------------------------------
  Widget _buildPrompt() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('웹 엽서로 공유하기', style: AppTextStyle.headlineMedium()),
        const SizedBox(height: 8),
        Text(
          '내 음성 게시글을 예쁜 웹 엽서로 꾸며 외부에 공유할 수 있어요.',
          style: AppTextStyle.bodyMedium(AppColor.neutrals40),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _startCreation,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primaryBlue,
              foregroundColor: AppColor.neutrals20,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text('웹 엽서 만들기', style: AppTextStyle.titleMedium()),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              '다음에 하기',
              style: AppTextStyle.bodyMedium(AppColor.neutrals40),
            ),
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------------
  // 로딩 상태 (웹뷰에서 편집 중)
  // ------------------------------------------------------------------
  Widget _buildLoading() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 8),
        const SizedBox(
          width: 52,
          height: 52,
          child: CircularProgressIndicator(
            color: AppColor.primaryBlue,
            strokeWidth: 3,
          ),
        ),
        const SizedBox(height: 20),
        Text('웹 엽서 링크 생성 중...', style: AppTextStyle.titleMedium()),
        const SizedBox(height: 6),
        Text(
          '웹 엽서 편집 화면에서 작업을 완료해 주세요.',
          style: AppTextStyle.bodySmall(AppColor.neutrals40),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        TextButton(
          onPressed: () {
            // 로딩 취소: 웹뷰가 현재 열려 있으면 pop, 없으면 무시
            try {
              Navigator.of(context).pop();
            } catch (_) {}
            setState(() => _state = _CardState.prompt);
          },
          child: Text(
            '취소하기',
            style: AppTextStyle.bodyMedium(AppColor.neutrals40),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  // ------------------------------------------------------------------
  // 완료 상태
  // ------------------------------------------------------------------
  Widget _buildComplete() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.check_circle_outline_rounded,
              color: AppColor.primaryBlue,
              size: 22,
            ),
            const SizedBox(width: 8),
            Text('웹 엽서가 생성되었어요!', style: AppTextStyle.headlineMedium()),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          '아래 링크를 복사하여 공유하세요.',
          style: AppTextStyle.bodySmall(AppColor.neutrals40),
        ),
        const SizedBox(height: 16),
        // URL + 복사 버튼
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: AppColor.neutrals70,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  _generatedUrl ?? '',
                  style: AppTextStyle.bodySmall(AppColor.neutrals20),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: _copyUrl,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: _copied
                      ? const Icon(
                          Icons.check_rounded,
                          key: ValueKey('check'),
                          color: AppColor.primaryBlue,
                          size: 20,
                        )
                      : const Icon(
                          Icons.copy_rounded,
                          key: ValueKey('copy'),
                          color: AppColor.neutrals40,
                          size: 20,
                        ),
                ),
              ),
            ],
          ),
        ),
        // 복사 완료 메시지
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          child: _copied
              ? Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    '클립보드에 복사되었습니다.',
                    style: AppTextStyle.bodySmall(AppColor.primaryBlue),
                  ),
                )
              : const SizedBox.shrink(),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              '닫기',
              style: AppTextStyle.bodyMedium(AppColor.neutrals40),
            ),
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------------
  // 오류 상태
  // ------------------------------------------------------------------
  Widget _buildError() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 4),
        const Icon(
          Icons.error_outline_rounded,
          color: AppColor.secondaryRed,
          size: 44,
        ),
        const SizedBox(height: 12),
        Text('링크 생성에 실패했어요.', style: AppTextStyle.headlineMedium()),
        const SizedBox(height: 6),
        Text(
          '잠시 후 다시 시도해 주세요.',
          style: AppTextStyle.bodySmall(AppColor.neutrals40),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColor.neutrals60),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  '닫기',
                  style: AppTextStyle.bodyMedium(AppColor.neutrals40),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: _startCreation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryBlue,
                  foregroundColor: AppColor.neutrals20,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text('다시 시도', style: AppTextStyle.bodyMedium()),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
      ],
    );
  }
}
