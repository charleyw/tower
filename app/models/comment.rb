# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  content          :text
#  author_id        :integer
#  commentable_id   :integer
#  commentable_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_comments_on_commentable_id_and_commentable_type  (commentable_id,commentable_type)
#

class Comment < ApplicationRecord
  after_create :create_event
  belongs_to :author, class_name: 'User'
  belongs_to :commentable, polymorphic: true

  private
  def create_event
    EventCreateService.new.comment_todo self, author
  end
end
