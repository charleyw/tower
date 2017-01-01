# == Schema Information
#
# Table name: events
#
#  id           :integer          not null, primary key
#  target_id    :integer
#  target_type  :string
#  source_id    :integer
#  source_type  :string
#  initiator_id :integer
#  action       :integer
#  data         :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_events_on_source_id_and_source_type  (source_id,source_type)
#  index_events_on_target_id_and_target_type  (target_id,target_type)
#

require 'rails_helper'

RSpec.describe Event, type: :model do
  describe '.by_projects' do
    let!(:project){create(:project)}
    let!(:project_another){create(:project)}
    let!(:event){create(:created_todo_event, source: project)}
    let!(:event_another){create(:created_todo_event, source: project_another)}

    it 'should show events for specified projects' do
      expect(described_class.by_projects([project])).to eq([event])
    end
  end
end
