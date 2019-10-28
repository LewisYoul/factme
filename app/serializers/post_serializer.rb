class PostSerializer < ActiveModel::Serializer
  attributes :id, :synopsis, :created_at, :title
  has_many :tags

  def created_at
    object.created_at.strftime('%d %B %Y')
  end
end
