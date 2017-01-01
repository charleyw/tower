# == Schema Information
#
# Table name: project_members
#
#  id         :integer          not null, primary key
#  project_id :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_project_members_on_project_id  (project_id)
#  index_project_members_on_user_id     (user_id)
#

class ProjectMember < ApplicationRecord
  belongs_to :project
  belongs_to :user
end
