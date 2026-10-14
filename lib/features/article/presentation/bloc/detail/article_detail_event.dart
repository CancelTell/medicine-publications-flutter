sealed class ArticleDetailEvent {
  const ArticleDetailEvent();
}

final class ArticleDetailOpened extends ArticleDetailEvent {
  const ArticleDetailOpened(this.pmid);

  final int pmid;
}
