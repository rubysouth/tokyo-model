class Post
  include TokyoModel::Persistable
  attr_accessor :title, :body, :author, :permalink
end