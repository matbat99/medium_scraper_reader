class Post
  attr_reader :path, :author, :title, :text_body, :read
  attr_writer :read

  def initialize(path, author, title, text_body, read = false)
    @path = path
    @author = author
    @title = title
    @text_body = text_body
    @read = read
  end
end
