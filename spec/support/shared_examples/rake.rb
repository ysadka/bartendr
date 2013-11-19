require 'rake'

shared_context 'rake' do
  before :all do
    Rake.application.rake_require(task_path)
    Rake::Task.define_task(:environment)
  end

  def rake
    Rake::Task[task_name].reenable
    Rake::Task[task_name].invoke
  end

  def task_name
    self.class.top_level_description
  end

  def task_path
    "../../lib/tasks/#{task_name.split(':').first}"
  end
end
