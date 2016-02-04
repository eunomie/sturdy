require 'rugged'
require 'fileutils'

module GitHelpers
  def repo_path
    'fixtures/repo.git'
  end

  def create_empty_repository
    Rugged::Repository.init_at repo_path
  end

  def create_non_repository
    FileUtils.mkdir_p repo_path
  end

  def clear_fixtures
    FileUtils.rm_rf repo_path
  end
end
