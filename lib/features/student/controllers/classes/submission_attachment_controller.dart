import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class SubmissionAttachmentController extends GetxController {
  var attachments = <Map<String, dynamic>>[].obs;
  var uploadedAttachments = <Map<String, dynamic>>[].obs;

  void addAttachment(String attachmentType) {
    attachments.add({
      'attachment_type': attachmentType,
      'attachment': null,
    });
  }

  void setAttachment(int index, dynamic attachment) {
    attachments[index]['attachment'] = attachment;
    attachments.refresh();
  }

  void removeAttachment(int index) {
    attachments.removeAt(index);
  }

  Future<void> pickFile(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      PlatformFile file = result.files.first;
      setAttachment(index, file);
    }
  }
}
