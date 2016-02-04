require 'rugged'
require 'sturdy/not_a_repository'
require 'sturdy/empty_repository'

module Sturdy
  class Repo
    # Initialize a new Sturdy for a git repository
    # @param [String] repo_path Path of git repository
    def initialize(repo_path)
      @repo_path = repo_path
      begin
        @repo = Rugged::Repository.new @repo_path
      rescue Rugged::RepositoryError
        raise Sturdy::NotARepository.new @repo_path
      end
      raise Sturdy::EmptyRepository.new @repo_path if @repo.empty?
    end

    # Get log messages for a repository
    # @return [Array<String>] log messages
    def log_messages
      walker = Rugged::Walker.new @repo
      walker.push @repo.head.target_id
      message_list = walker.inject([]) { |messages, c| messages << c.message }
      walker.reset
      message_list
    end
  end
end
