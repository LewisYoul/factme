class Post < ApplicationRecord
  has_and_belongs_to_many :tags

  def serializable
    PostSerializer.new(self)
  end


  def serialize
    serializable.to_h
  end
end
