require 'sturdy'

describe Sturdy::Repo do
  before(:each) do
    clear_fixtures
  end

  describe '#new' do
    context 'without a git repository' do
      before(:each) do
        create_non_repository
      end

      it 'should raise an error' do
        expect{Sturdy::Repo.new repo_path}.to raise_error Sturdy::NotARepository, "'#{repo_path}' is not a git repository"
      end
    end

    context 'with an empty repository' do
      before(:each) do
        create_empty_repository
      end

      it 'should raise an error' do
        expect{Sturdy::Repo.new repo_path}.to raise_error Sturdy::EmptyRepository, "'#{repo_path}' is empty"
      end
    end

    context 'with a non empty repository' do
      before(:each) do
        create_repo_with_linear_history
      end

      it 'should not raise an error' do
        expect{Sturdy::Repo.new repo_path}.to_not raise_error
      end
    end
  end

  describe '#log_messages' do
    context 'with a repository with linear history' do
      before(:each) do
        create_repo_with_linear_history
      end

      it 'returns commit messages' do
        sturdy = Sturdy::Repo.new repo_path
        messages = sturdy.log_messages

        expect(messages.size).to eq 3
        expect(messages[0]).to eq "3rd commit\n\nplop plop"
        expect(messages[1]).to eq "2nd commit\n\nplop plop"
        expect(messages[2]).to eq "first commit\n\nplop plop"
      end

      context 'using array#first_lines' do
        it 'returns first lines of commit messages' do
          sturdy = Sturdy::Repo.new repo_path
          messages = sturdy.log_messages.first_lines

          expect(messages.size).to eq 3
          expect(messages[0]).to eq "3rd commit"
          expect(messages[1]).to eq "2nd commit"
          expect(messages[2]).to eq "first commit"
        end
      end
    end
  end
end
