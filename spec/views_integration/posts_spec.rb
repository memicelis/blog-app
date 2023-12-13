require 'rails_helper'

RSpec.describe Post, type: :system do
  let(:user) { User.new(name: 'User1', photo: 'https://avatars.githubusercontent.com/u/7747059?v=4', posts_counter: 6, bio: 'Full-stack web developer') }

  let!(:post) do
    Post.create({ author: user, title: 'First Post', text: 'My first post', comments_counter: 0, likes_counter: 1 })
  end

  let!(:comment1) { Comment.create({ user:, post:, text: 'First comment' }) }
  let!(:comment2) { Comment.create({ user:, post:, text: 'Second comment' }) }
  let!(:comment3) { Comment.create({ user:, post:, text: 'Third comment' }) }
  let!(:comment4) { Comment.create({ user:, post:, text: 'Fourth comment' }) }
  let!(:comment5) { Comment.create({ user:, post:, text: 'Fifth comment' }) }
  let!(:comment6) { Comment.create({ user:, post:, text: 'Sixth comment' }) }

  it 'shows user details and posts on user posts#index page' do
    visit user_posts_path(user)

    expect(page).to have_css("img[src*='#{user.photo}']")
    expect(page).to have_content(user.name)
    expect(page).to have_content(user.posts_counter)
    expect(page).to have_content(post.title)
    expect(page).to have_content(post.text)

    recent_comments = post.recent_comments
    expect(recent_comments.size).to eq(5)

    expect(page).to have_content(post.comments_counter)
    expect(page).to have_content(post.likes_counter)

    click_link 'First Post'
    expect(page).to have_current_path(user_post_path(user, post))
  end

  it 'shows pagination if there are more posts than fit on view' do
    Post.create([
                  { author: user, title: 'First Post', text: 'My first post' },
                  { author: user, title: 'Second Post', text: 'My Second post' },
                  { author: user, title: 'Third Post', text: 'My Third post' },
                  { author: user, title: 'Fourth Post', text: 'My Fourth post' }
                ])
    visit user_posts_path(user)
    expect(page).to have_css('.pagy-nav')
  end

  it 'post#show shows post details, number of likes and comments and all the comments with its usernames' do
    visit user_post_path(user, post)

    expect(page).to have_content(post.title)
    expect(page).to have_content(post.author.name)
    expect(page).to have_content(post.comments_counter)
    expect(page).to have_content(post.likes_counter)
    expect(page).to have_content(post.text)
    post.comments.each do |comment|
      expect(page).to have_content(comment.text)
      expect(page).to have_content(comment.user.name)
    end
  end
end
