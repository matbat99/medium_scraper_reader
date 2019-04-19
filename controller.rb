require_relative 'post'
require_relative 'view'
require 'open-uri'
require 'nokogiri'

class Controller
  def initialize(repo)
    @repo = repo
    @view = View.new
  end

  def list
    show_list
  end

  def create
    # scrape the new post
    user_path = @view.ask_user_for_path
    attributes = scrape_it(user_path)
    new_post = Post.new(user_path, attributes[:author], attributes[:title], attributes[:text])

    @repo.add_post(new_post)
  end

  def read
    show_list
    index = @view.ask_user_for_index
    output = @repo.read_post(index)
    @view.show_post(output)
  end

  def mark_read
    show_list
    index = @view.ask_user_for_index
    @repo.mark_post_read(index)
    show_list
  end

  private

  def show_list
    list = @repo.all
    @view.display(list)
  end

  def scrape_it(path)
    post_contents = {}
    body_text = scrape_body_text(path)
    post_contents[:text] = body_text.join(' ')
    post_contents[:title] = scrape_title(path)
    post_contents[:author] = scrape_author(path)
    post_contents
  end

  def scrape_title(path)
    url = "https://medium.com/#{path}"
    doc = Nokogiri::HTML(open(url).read)
    doc.search('.section-content .section-inner h1').each do |element|
      return element.text.strip
    end
  end

  def scrape_author(path)
    url = "https://medium.com/#{path}"
    doc = Nokogiri::HTML(open(url).read)
    doc.search('footer .js-cardUser h3').each do |element|
      return element.text.strip
    end
  end

  def scrape_body_text(path)
    url = "https://medium.com/#{path}"
    doc = Nokogiri::HTML(open(url).read)
    temp_array = []
    doc.search('.postArticle-content p').each do |element|
      temp_array << element.text.strip
    end
    temp_array
  end
end
