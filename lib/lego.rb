require "lego/version"
require 'rails'
require 'active_record'
require 'active_model/validations'
# require 'spring'

module Lego
  class Base
    include ActiveModel::Model
    include ActiveModel::Validations
    include ActiveModel::Validations::Callbacks
  end

  class Git < Base
    attr_accessor :service, :account

    before_validation :set_defaults

    validates :service, :account, presence: true

    def set_defaults
      self.service ||= 'git@github.com'
    end

    def url(name)
      "#{service}:#{account}/#{name}.git"
    end

    def push(name)
      system "git remote add origin #{url(name)}"
      system "git push -u origin master"
    end
  end

  class Project < Base
    attr_accessor :name, :parent_dir, :dir

    before_validation :set_defaults

    validates :name, :parent_dir, presence: true

    after_validation :make_directory

    def set_defaults
      self.parent_dir ||= Dir.home
      self.dir = "#{parent_dir}/#{name}"
    end

    def make_directory
      FileUtils.mkdir(dir) unless Dir.exists?(dir)
    end
  end

  class App < Base
    attr_accessor :project, :git, :name

    before_validation :set_defaults

    validates :project, :git, :name, presence: true
    validate :associated_valid?

    def associated_valid?
      git.valid? && project.valid?
    end

    def set_defaults
      raise NotImplementedError, 'instantiate a child class of App'
    end

    def push
      raise 'Model invalid' if invalid?
      Dir.chdir("#{project.dir}/#{name}") do
        git.push(name)
      end
    end
  end

  class RailsApp < App
    def set_defaults
      self.name ||= "#{project.name}-api"
    end

    def create
      return if invalid? or Dir.exists?("#{project.dir}/#{name}")
      Dir.chdir(project.dir) do
        system "rails new #{name} --api -m ~/rails-templates/templates/rails5/api.rb"
        system 'git add .'
        system "git commit -m 'Initial Commit from Rails'"
      end
    end
  end

  class EmberApp < App
    def set_defaults
      self.name ||= "#{project.name}-app"
    end

    def create
      return if invalid? or Dir.exists?("#{project.dir}/#{name}")
      Dir.chdir(project.dir) do
        system "ember new #{name}"
        # TODO: Add the default addons here
        # system "ember install ember-simple-auth"
      end
    end
  end

  class MicroService < Base
    attr_accessor :account, :name, :rails, :ember

    after_validation :initialize_apps

    def initialize_apps
      git = Git.new(account: account)
      project = Project.new(name: name)
      self.rails = RailsApp.new(git: git, project: project)
      self.ember = EmberApp.new(git: git, project: project)
    end

    def create
      return if invalid?
      rails.create
      ember.create
    end

    def push
      return if invalid?
      rails.push
      ember.push
    end
  end
end
