import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/models/student_submission_model.dart';
import 'package:mobile/features/student/controllers/classes/school_work_controller.dart';
import 'package:mobile/features/student/controllers/classes/submission_attachment_controller.dart';
import 'package:mobile/features/student/controllers/submissions/student_submission_controller.dart';
import 'package:mobile/features/webview/webview-screen.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/formatters/formatter.dart';
import 'package:mobile/data/services/submission_attachment_service.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart'; // Import for webview

class SchoolWorkDetailScreen extends StatefulWidget {
  final int schoolWorkId;
  final SchoolWorkController controller = Get.put(SchoolWorkController());
  final SubmissionAttachmentController submissionAttachmentController =
      Get.put(SubmissionAttachmentController());

  final StudentSubmissionController studentSubmissionController =
      Get.put(StudentSubmissionController());

  SchoolWorkDetailScreen({super.key, required this.schoolWorkId});

  @override
  _SchoolWorkDetailScreenState createState() => _SchoolWorkDetailScreenState();
}

class _SchoolWorkDetailScreenState extends State<SchoolWorkDetailScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch the single school work in a post-frame callback
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.fetchSingleSchoolWork(widget.schoolWorkId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("School Work Details")),
      body: Obx(() {
        if (widget.controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final schoolWork = widget.controller.singleSchoolWork.value;

        if (schoolWork == null) {
          return const Center(child: Text("No details available"));
        }

        String points = "0"; // Ensure `points` is declared

        switch (schoolWork.type) {
          case 'assignment':
            points = schoolWork.assignment!.points;
            break;

          case 'activity':
            points = schoolWork.activity!.points;
            break;

          case 'exam':
            points = schoolWork.exam!.points;
            break;

          default:
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Due: ${TFormatter.formatDate(schoolWork.dueDatetime, 'MMM dd, yy h:m a')}", // Assuming `dueDate` is available
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      const SizedBox(height: 4),

                      Text(
                        schoolWork.title,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),

                      // Subject and Description Section
                      const Text(
                        "Subject: ",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    "$points Points",
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black, width: .5, style: BorderStyle.solid),
                ),
              ),

              const SizedBox(height: 16),
              Text(
                schoolWork.description,
                style: const TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 25),

              // Attachments Section
              const Text(
                "Attachments:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              schoolWork.attachments != null &&
                      schoolWork.attachments!.isNotEmpty
                  ? Column(
                      children: schoolWork.attachments!.map((attachment) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0), // Add vertical margin here
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListTile(
                              leading: const Icon(Icons.attach_file),
                              title: Text(attachment.attachmentName),
                              trailing: IconButton(
                                icon: const Icon(Icons.arrow_right),
                                onPressed: () {
                                  String url =
                                      "https://e-learn.godesqsites.com/assets/uploads/school_work_attachments/${attachment.attachmentName}";
                                  print("URL: $url");
                                  Get.to(WebViewScreen(url: url));
                                },
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 12.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error_outline, color: Colors.grey),
                          SizedBox(width: 8),
                          Text("No Attachment Found",
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
              const Spacer(),

              // Upload Att Button
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Center(
                        child: ElevatedButton.icon(
                          icon: const Icon(
                            Icons.attachment,
                            color: TColors.primaryColor,
                            size: 20.0,
                          ),
                          label: const Text('Upload Attachment'),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Upload Attachments'),
                              content: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Obx(() {
                                      return Column(
                                        children: widget
                                            .submissionAttachmentController
                                            .attachments
                                            .asMap()
                                            .entries
                                            .map((entry) {
                                          int index = entry.key;
                                          var attachment = entry.value;
                                          return Row(
                                            children: [
                                              DropdownButton<String>(
                                                value: attachment[
                                                    'attachment_type'],
                                                items: const [
                                                  DropdownMenuItem(
                                                      value: 'file',
                                                      child: Text('File')),
                                                  DropdownMenuItem(
                                                      value: 'link',
                                                      child: Text('Link')),
                                                ],
                                                onChanged: (value) {
                                                  if (value != null) {
                                                    widget.submissionAttachmentController
                                                                    .attachments[
                                                                index][
                                                            'attachment_type'] =
                                                        value;
                                                    widget
                                                        .submissionAttachmentController
                                                        .setAttachment(index,
                                                            null); // Reset attachment
                                                  }
                                                },
                                              ),
                                              const SizedBox(width: 10),
                                              if (attachment[
                                                      'attachment_type'] ==
                                                  'file')
                                                ElevatedButton(
                                                  onPressed: () => widget
                                                      .submissionAttachmentController
                                                      .pickFile(index),
                                                  child: Text(attachment[
                                                              'attachment'] ==
                                                          null
                                                      ? 'Choose File'
                                                      : 'File Selected'),
                                                )
                                              else
                                                Expanded(
                                                  child: TextFormField(
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText:
                                                                'Enter URL'),
                                                    onChanged: (value) => widget
                                                        .submissionAttachmentController
                                                        .setAttachment(
                                                            index, value),
                                                  ),
                                                ),
                                              IconButton(
                                                icon: const Icon(Icons.delete),
                                                onPressed: () => widget
                                                    .submissionAttachmentController
                                                    .removeAttachment(index),
                                              ),
                                            ],
                                          );
                                        }).toList(),
                                      );
                                    }),
                                    const SizedBox(height: 10),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: TColors.primaryColor,
                                        foregroundColor: TColors.white,
                                        side: const BorderSide(
                                          color: Colors
                                              .black, // Customize the border color
                                          width:
                                              2.0, // Customize the border width
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              5), // Optional: rounded corners
                                        ),
                                      ),
                                      onPressed: () => widget
                                          .submissionAttachmentController
                                          .addAttachment('file'),
                                      child: const Text('Add Attachment'),
                                    )
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: TColors.primaryColor,
                                    foregroundColor: TColors.white,
                                    side: const BorderSide(
                                      color: Colors
                                          .black, // Customize the border color
                                      width: 2.0, // Customize the border width
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          5), // Optional: rounded corners
                                    ),
                                  ),
                                  onPressed: () async {
                                    await Get.find<
                                            SubmissionAttachmentService>()
                                        .submitAttachments(
                                      widget.schoolWorkId,
                                      widget.submissionAttachmentController
                                          .attachments,
                                    );
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Submit'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(TColors.buttonPrimary),
                      foregroundColor: WidgetStateProperty.all(TColors.white),
                    ),
                    onPressed: () {
                      // Fetch submissions when button is pressed
                      widget.studentSubmissionController
                          .fetchStudentSubmission(widget.schoolWorkId);

                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Student Submissions'),
                            content: SizedBox(
                              child: Obx(() {
                                // Check if still loading
                                if (widget.studentSubmissionController.isLoading
                                    .value) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }

                                // Check if student_submission is null
                                StudentSubmission? studentSubmission = widget
                                    .studentSubmissionController
                                    .student_submission
                                    .value;

                                if (studentSubmission == null) {
                                  return const Center(
                                    child: Text(
                                      "No submission data available.",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  );
                                }

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('Score: ${studentSubmission.score}'),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      child: studentSubmission.attachments !=
                                                  null &&
                                              studentSubmission
                                                  .attachments!.isNotEmpty
                                          ? Column(
                                              children: studentSubmission
                                                  .attachments!
                                                  .map((attachment) {
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 5.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: Colors.black),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: ListTile(
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      leading: const Icon(
                                                          Icons.attach_file),
                                                      title: Text(
                                                        attachment
                                                            .attachmentName
                                                            .substring(
                                                          0,
                                                          attachment.attachmentName
                                                                      .length >
                                                                  20
                                                              ? 20
                                                              : attachment
                                                                  .attachmentName
                                                                  .length,
                                                        ),
                                                      ),
                                                      trailing: IconButton(
                                                        icon: const Icon(
                                                          Icons.delete,
                                                          color: Colors.red,
                                                        ),
                                                        onPressed: () {
                                                          // Implement download or other options here
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            )
                                          : Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16.0,
                                                      horizontal: 12.0),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.error_outline,
                                                      color: Colors.grey),
                                                  SizedBox(width: 8),
                                                  Text(
                                                    "No Attachment Found",
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            ),
                                    )
                                  ],
                                );

                                // Show list of submissions
                              }),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text("Submissions"),
                  )
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
