class ProjectsController < ApplicationController
  def index
    @projects = YAML.load(File.open("#{Rails.root}/lib/data/projects.yml", 'r'))
  end
end
