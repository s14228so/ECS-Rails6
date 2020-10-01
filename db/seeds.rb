5.times.each do |i|
  Post.create(title: "test#{i + 1}")
end
