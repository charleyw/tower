# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  name       :string
#  team_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_projects_on_team_id  (team_id)
#

FactoryGirl.define do
  factory :project do
    name { FFaker::Name.name }
    team
  end
end
