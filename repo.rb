require 'csv'
require_relative 'post'

class Repo
  def initialize(csv_file_path)
    @post_store = []
    @csv_file_path = csv_file_path
    load_csv_file
  end

  def all
    @post_store
  end

  def add_post(new_post)
    @post_store << new_post
    write_array_file
  end

  def remove_post(post_index)
    @post_store.delete_at(post_index)
    write_array_file
  end

  def mark_post_read(post_index)
    @post_store[post_index].read = true
    write_array_file
  end

  def read_post(post_index)
    mark_post_read(post_index)
    "#{@post_store[post_index].title} \n by #{@post_store[post_index].author} \n #{@post_store[post_index].text_body}"
  end

  private

  def write_array_file
    CSV.open(@csv_file_path, 'wb') do |csv|
      @post_store.each do |post|
        csv << [post.path, post.author, post.title, post.text_body, post.read]
      end
    end
  end

  def load_csv_file
    CSV.foreach(@csv_file_path) do |row|
      @post_store << Post.new(row[0], row[1], row[2], row[3], row[4])
    end
  end
end
