require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Elis', photo: 'https://avatars.githubusercontent.com/u/7747059?v=4', posts_counter: 6, bio: 'Full-stack web developer') }

  before { subject.save }

  describe 'validations' do
    it 'should be valid' do
      expect(subject).to be_valid
    end

    it 'requires a name' do
      subject.name = nil
      expect(subject).not_to be_valid
    end

    it 'requires posts_counter to be an integer greater than or equal to zero' do
      subject.posts_counter = -1
      expect(subject).not_to be_valid
    end
  end

  describe 'methods' do
    it 'recent_posts method returns zero(0) when user is created' do
      expect(subject.recent_posts.count).to eq 0
    end

    it 'recent_posts method returns last 3 posts in descending order' do

        post1= Post.create(
            title: 'Test Post',
            author: subject,
            text: 'This is test post', comments_counter: 0, likes_counter: 0
          )
          post2= Post.create(
            author: subject,
            title: 'Codding',
            text: 'Software development is a crucial aspect of the tech industry', comments_counter: 0, likes_counter: 0
          )
          post3=Post.create(
            author: subject,
            title: 'Nigeria',
            text: 'Nigeria is a beautiful country to visit', comments_counter: 0, likes_counter: 0
          )
          post4= Post.create(
            author: subject,
            title: 'Microverse',
            text: 'Is Microverse really the best tech school out there?', comments_counter: 0, likes_counter: 0
          )
      

      recent_posts = subject.recent_posts
      expect(recent_posts.size).to eq(3)
      expect(recent_posts).to eq([post4,post3,post2])
    end
  end
end
