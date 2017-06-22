class CMS

  def login
    @login ||= LoginPage.new
  end

  def home
    @home ||= HomePage.new
  end

  def collection
    @collection ||= CollectionPage.new
  end

  def article
    @article  ||= ArticlePage.new
  end

  def documents
    @documents ||= DocumentsPage.new
  end

end