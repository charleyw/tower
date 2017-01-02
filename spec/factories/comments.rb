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

FactoryGirl.define do
  factory :comment do
    content "MyText"
    author factory: :user
  end
end
