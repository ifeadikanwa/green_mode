import 'package:intl/intl.dart';

class NewsUtil {
  static String getValidDescription(String? description) {
    if (description != null && description.trim().isNotEmpty) {
      return description;
    } else {
      return "Read more...";
    }
  }

  static String getPublishTimeAndAuthorString({
    required String? publishTime,
    required String? author,
  }) {
    String result = "";
    if (publishTime != null) {
      final date = DateTime.parse(publishTime);
      final formattedDate = DateFormat.yMMMMd().format(date);
      result = "$formattedDate ";
    }

    if (author != null) {
      result += "by $author";
    }

    return result;
  }

  static String prepareContentForDisplay(List<String> contentList) {
    //take the list and build a string
    //each item in the list is seperated by two new lines
    //return the new String

    final StringBuffer stringBuffer = StringBuffer();

    for (var paragraph in contentList) {
      //if the paragraph contains only numbers, starts with published, view or comments skip
      if (isValidParagraph(paragraph)) {
        stringBuffer.write("${paragraph.trimLeft()}\n\n");
      }
    }

    return stringBuffer.toString();
  }

  static bool isValidParagraph(String paragraph) {
    return !(paragraph.trim().isEmpty ||
        paragraph.trim().contains(RegExp("^[0-9]+\$")) ||
        paragraph.trim().toLowerCase().startsWith("view") ||
        paragraph.trim().toLowerCase().startsWith("publish") ||
        paragraph.trim().toLowerCase().startsWith("comment") ||
        paragraph.trim().toLowerCase().startsWith("by") ||
        paragraph.trim().toLowerCase().startsWith("share") ||
        paragraph.trim().toLowerCase().startsWith("readmore"));
  }
}
