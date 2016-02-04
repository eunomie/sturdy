require 'rugged'

module Sturdy
  class Repo
    # Initialize a new Sturdy for a git repository
    # @param [String] repo_path Path of git repository
    def initialize(repo_path)
      @repo_path = repo_path
      begin
        @repo = Rugged::Repository.new @repo_path
      rescue Rugged::RepositoryError
        raise Sturdy::RepositoryError.new @repo_path
      end
      raise Sturdy::EmptyRepositoryError.new @repo_path if @repo.empty?
    end

    private

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
