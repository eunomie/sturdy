require 'sturdy'

describe Sturdy do
  before(:each) do
    clear_fixtures
  end

  describe '#new' do
    context 'without a git repository' do
      before(:each) do
        create_non_repository
      end

      it 'raise an error' do
        expect{Sturdy::Repo.new repo_path}.to raise_error Sturdy::NotARepository, "'#{repo_path}' is not a git repository"
      end
    end

    context 'with an empty repository' do
      before(:each) do
        create_empty_repository
      end

      it 'raise an error' do
        expect{Sturdy::Repo.new repo_path}.to raise_error Sturdy::EmptyRepository, "'#{repo_path}' is empty"
      end
    end
  end
end
