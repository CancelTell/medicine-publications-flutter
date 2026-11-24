sealed class ArticleDetailEvent {
  const ArticleDetailEvent(this.pmid);

  final int pmid;
}

final class ArticleDetailOpened extends ArticleDetailEvent {
  const ArticleDetailOpened(super.pmid);
}

final class ArticleDetailRetried extends ArticleDetailEvent {
  const ArticleDetailRetried(super.pmid);
}
