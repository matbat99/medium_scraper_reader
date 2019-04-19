class View
  def display(posts)
    posts.each_with_index do |post, index|
      mark = ""
      if post.read == true
        mark = '[Read]'
      else
        mark = "[new]"
      end
      puts "#{mark} #{post.read}  #{index + 1} - #{post.title} by #{post.author}"
    end
  end

  def ask_user_for_path
    puts "What is the path to the article?"
    return gets.chomp
  end

  def ask_user_for_index
    puts "which post?"
    print "►►  "
    return gets.chomp.to_i - 1
  end

  def show_post(post_output)
    puts post_output
  end
end
