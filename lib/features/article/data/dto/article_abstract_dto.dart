import 'package:xml/xml.dart';

final class ArticleAbstractDto {
  const ArticleAbstractDto({
    required this.pmid,
    required this.text,
  });

  final String? pmid;
  final String text;

  factory ArticleAbstractDto.fromXml(String source) {
    final document = XmlDocument.parse(source);

    if (document.rootElement.name.local != 'PubmedArticleSet') {
      throw const FormatException('Некорректный ответ EFetch');
    }

    final citation = document
        .findAllElements('MedlineCitation')
        .firstOrNull;

    final book = document
        .findAllElements('BookDocument')
        .firstOrNull;

    final record = citation ?? book;

    if (record == null) {
      return const ArticleAbstractDto(pmid: null, text: '');
    }

    final pmid = record.getElement('PMID')?.innerText.trim();

    if (pmid == null || pmid.isEmpty) {
      throw const FormatException('В записи нет PMID');
    }

    final paragraphs = record
        .findAllElements('AbstractText')
        .map((element) {
      final label = element.getAttribute('Label');
      final text = element.innerText.trim();

      if (text.isEmpty) return '';
      if (label == null || label.isEmpty) return text;

      return '$label: $text';
    })
        .where((text) => text.isNotEmpty)
        .toList();

    return ArticleAbstractDto(
      pmid: pmid,
      text: paragraphs.join('\n\n'),
    );
  }
}