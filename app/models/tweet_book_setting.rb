class TweetBookSetting < ActiveRecord::Base
  unloadable

  belongs_to :project

  cattr_accessor :settings

  validates_uniqueness_of :name, :scope => [:project_id]

  class << self
    # Returns the value of the setting named name
    def [](name, project_id)
      project_id = project_id.id if project_id.is_a?(Project)
      find_or_default(name, project_id).value
    end

    def []=(name, project_id, v)
      project_id = project_id.id if project_id.is_a?(Project)
      setting = find_or_default(name, project_id)
      setting.value = (v ? v : "")
      setting.save
      setting.value
    end

    private

    # Returns the Setting instance for the setting named name
    # (record found in database or new record with default value)
    def find_or_default(name, project_id)
      name = name.to_s
      setting = find_by_name_and_project_id(name, project_id)
      setting ||= new(:name => name, :value => '', :project_id => project_id)
    end
  end

end
